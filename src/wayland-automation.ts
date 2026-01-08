import { exec } from 'child_process';
import { promisify } from 'util';
import robot from '@jitsi/robotjs';

const execAsync = promisify(exec);

/**
 * Check if running on Wayland
 */
export function isWayland(): boolean {
  return process.env.XDG_SESSION_TYPE === 'wayland' || !!process.env.WAYLAND_DISPLAY;
}

/**
 * Copy text from current selection using wl-copy on Wayland
 */
async function copyViaWlClipboard(): Promise<void> {
  // wl-copy reads from stdin, so we need to use wl-paste to get current clipboard
  // But we want to COPY from the current selection, so we use primary selection
  try {
    // Trigger copy by simulating the selection being copied
    // This is tricky - we may need to use wl-copy differently
    // For now, just wait for the app to put data in clipboard
    await new Promise(resolve => setTimeout(resolve, 100));
  } catch (error) {
    console.error('wl-copy error:', error);
  }
}

/**
 * Read clipboard using wl-paste on Wayland
 */
async function readClipboardWayland(): Promise<string> {
  try {
    const { stdout } = await execAsync('wl-paste');
    return stdout;
  } catch (error) {
    console.error('wl-paste error:', error);
    return '';
  }
}

/**
 * Write to clipboard using wl-copy on Wayland
 */
async function writeClipboardWayland(text: string): Promise<void> {
  try {
    await execAsync(`echo -n "${text}" | wl-copy`);
  } catch (error) {
    console.error('wl-copy error:', error);
  }
}

/**
 * Copy current selection to clipboard
 * On Wayland: uses wl-paste (assumes app already copied)
 * On X11/Windows: uses Ctrl+C
 */
export async function copyToClipboard(): Promise<void> {
  if (isWayland()) {
    // On Wayland, we can't simulate Ctrl+C
    // But robotjs CAN do the right-click which opens the dialog
    // The dialog shows the current price, which should already be selected
    // We'll rely on the app having the value ready
    await new Promise(resolve => setTimeout(resolve, 100));
  } else {
    // On X11/Windows, use Ctrl+C
    robot.keyTap('c', ['control']);
    await new Promise(resolve => setTimeout(resolve, 100));
  }
}

/**
 * Read clipboard content
 */
export async function readClipboard(): Promise<string> {
  if (isWayland()) {
    return await readClipboardWayland();
  } else {
    // Use the regular clipboardy on X11/Windows
    const clipboardy = await import('clipboardy');
    return await clipboardy.default.read();
  }
}

/**
 * Write to clipboard
 */
export async function writeClipboard(text: string): Promise<void> {
  if (isWayland()) {
    await writeClipboardWayland(text);
  } else {
    const clipboardy = await import('clipboardy');
    await clipboardy.default.write(text);
  }
}

/**
 * Paste from clipboard
 * On Wayland: uses wl-paste to read, then types the value
 * On X11/Windows: uses Ctrl+V
 */
export async function pasteFromClipboard(): Promise<void> {
  if (isWayland()) {
    // Read from clipboard and type it
    const text = await readClipboardWayland();
    robot.typeString(text);
  } else {
    // On X11/Windows, use Ctrl+V
    robot.keyTap('v', ['control']);
  }
}

/**
 * Mouse and keyboard operations that work on all platforms
 */
export const automation = {
  // Mouse operations (work on Wayland)
  mouseClick: (button: 'left' | 'right' = 'left') => robot.mouseClick(button),
  
  // Keyboard operations (work on Wayland)
  keyTap: (key: string, modifiers?: string[]) => robot.keyTap(key, modifiers),
  typeString: (text: string) => robot.typeString(text),
  
  // Clipboard operations (Wayland-aware)
  copyToClipboard,
  readClipboard,
  writeClipboard,
  pasteFromClipboard,
};
