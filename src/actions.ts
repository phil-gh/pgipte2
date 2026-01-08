import robot from '@jitsi/robotjs';
import { configManager } from './config.js';
import { readPrice, writePrice } from './clipboard.js';

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
  // Right-click to open price dialog
  robot.mouseClick('right');
  await sleep(300);

  // Clear clipboard and copy
  // Note: We can't actually clear the clipboard easily, so we just copy
  robot.keyTap('c', ['control']);
  await sleep(600); // Wait for clipboard

  // Read and parse price
  const price = await readPrice();
  
  if (!price || price < 1) {
    console.log('Failed to read valid price from clipboard');
    return null;
  }

  return price;
}

/**
 * Paste a value and confirm with Enter
 */
async function pasteAndConfirm(value: number): Promise<void> {
  await writePrice(value);
  await sleep(50);
  
  robot.keyTap('v', ['control']);
  await sleep(50);
  
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
  
  // Paste the value
  await writePrice(newValue);
  await sleep(50);
  robot.keyTap('v', ['control']);
  await sleep(50);

  // Special UI navigation
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
