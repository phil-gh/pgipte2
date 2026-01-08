import clipboardy from 'clipboardy';

/**
 * Parse a numeric price from clipboard text
 * Handles both comma and period as decimal separators
 */
export function parsePrice(text: string): number | null {
  const trimmed = text.trim();
  
  // Match number with optional decimal separator (comma or period)
  const match = trimmed.match(/^([\d]+([.,]\d+)?)$/);
  
  if (!match) {
    return null;
  }
  
  // Replace comma with period for proper float parsing
  const normalized = match[1].replace(',', '.');
  const value = parseFloat(normalized);
  
  return isNaN(value) ? null : value;
}

/**
 * Read current clipboard content
 */
export async function readClipboard(): Promise<string> {
  return await clipboardy.read();
}

/**
 * Write text to clipboard
 */
export async function writeClipboard(text: string): Promise<void> {
  await clipboardy.write(text);
}

/**
 * Read and parse price from clipboard
 */
export async function readPrice(): Promise<number | null> {
  const text = await readClipboard();
  return parsePrice(text);
}

/**
 * Write a numeric value to clipboard
 */
export async function writePrice(value: number): Promise<void> {
  await writeClipboard(value.toString());
}
