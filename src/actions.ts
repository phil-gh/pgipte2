import robot from '@jitsi/robotjs';
import { configManager } from './config.js';
import { parsePrice } from './clipboard.js';
import { automation, readClipboard, writeClipboard, isWayland } from './wayland-automation.js';

/**
 * Delay helper
 */
function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

/**
 * Copy current price from the game
 * Returns null if no valid price found
 */
async function copyPrice(): Promise<number | null> {
  console.log(`Platform: ${isWayland() ? 'Wayland' : 'X11/Windows'}`);
  
  // Right-click to open price dialog (works on Wayland)
  robot.mouseClick('right');
  await sleep(50);

  // On Wayland, we can't use Ctrl+C, but the game might auto-select the price
  // Let's try to read what's already in clipboard, or use wl-paste
  if (isWayland()) {
    console.log('Using Wayland clipboard (wl-paste)...');
    // Wait a bit for the dialog to appear and potentially copy
    await sleep(50);
    
    // Read current clipboard using wl-paste
    const text = await readClipboard();
    console.log(`Read from clipboard: "${text}"`);
    
    const price = parsePrice(text);
    if (!price || price < 1) {
      console.log('No valid price found. Mouse over a priced item in your market. It might be price-locked, in which case you cannot change its price.');
      return null;
    }
    
    return price;
  } else {
    // On X11/Windows, use Ctrl+C
    robot.keyTap('c', ['control']);
    await sleep(50);
    
    const text = await readClipboard();
    const price = parsePrice(text);
    
    if (!price || price < 1) {
      console.log('Failed to read valid price from clipboard');
      return null;
    }
    
    return price;
  }
}

/**
 * Paste a value and confirm with Enter
 */
async function pasteAndConfirm(value: number): Promise<void> {
  // Write to clipboard
  await writeClipboard(value.toString());
  await sleep(50);
  
  if (isWayland()) {
    // On Wayland, type the string directly since Ctrl+V doesn't work
    console.log('Typing value directly (Wayland)...');
    robot.typeString(value.toString());
  } else {
    // On X11/Windows, use Ctrl+V
    robot.keyTap('v', ['control']);
  }
  
  await sleep(50);
  
  // Enter works on all platforms
  robot.keyTap('enter');
}

/**
 * F3 Handler - Percentage reduction
 */
export async function handlePercentageReduction(): Promise<void> {
  console.log('F3: Percentage reduction triggered');
  
  const price = await copyPrice();
  if (!price) {
    return;
  }

  const percent = configManager.getPercent();
  const factor = 1 - (percent / 100);
  let newValue = Math.floor(price * factor);
  
  if (newValue < 1) {
    newValue = 1;
  }

  console.log(`Original: ${price}, Reducing by ${percent}%, New: ${newValue}`);
  await pasteAndConfirm(newValue);
}

/**
 * F4 Handler - Currency conversion with UI navigation
 */
export async function handleCurrencyConversion(): Promise<void> {
  console.log('F4: Currency conversion triggered');
  
  const price = await copyPrice();
  if (!price) {
    return;
  }

  const rate = configManager.getRate();
  let newValue = Math.floor(price * rate);
  
  if (newValue < 1) {
    newValue = 1;
  }

  console.log(`Original: ${price}, Rate: ${rate}, New: ${newValue}`);
  
  // Write to clipboard
  await writeClipboard(newValue.toString());
  await sleep(50);
  
  if (isWayland()) {
    // Type directly on Wayland
    robot.typeString(newValue.toString());
  } else {
    // Use Ctrl+V on X11/Windows
    robot.keyTap('v', ['control']);
  }
  
  await sleep(50);

  // Special UI navigation (works on all platforms)
  robot.keyTap('tab');
  await sleep(50);
  
  // Press Up 3 times
  for (let i = 0; i < 3; i++) {
    robot.keyTap('up');
    await sleep(50);
  }
  
  // Press Enter twice
  robot.keyTap('enter');
  await sleep(50);
  robot.keyTap('enter');
  
  console.log('Currency conversion complete');
}
