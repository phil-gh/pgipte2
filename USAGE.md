# Usage Guide

## Installation

```bash
cd ~/src/pgipte2
npm install
npm run build
```

## Running the Application

### Development Mode (with auto-reload)
```bash
npm run dev
```

### Production Mode
```bash
npm run build
npm start
```

## Workflow in Path of Exile 2

### Initial Setup

1. Start the application: `npm start`
2. You'll see:
```
=================================
PGIPTE2 - PoE Price Tool
=================================

Hotkeys:
  F2 - Settings
  F3 - Reduce price by percentage
  F4 - Convert currency
  Ctrl+C - Exit

Current configuration:
  Reduction: 10%
  Rate: 130

Listening for hotkeys...
```

3. Press **F2** to configure your settings:
   - **Reduction Percent**: How much to reduce prices (e.g., 10 for 10% off)
   - **Conversion Rate**: Multiplier for currency conversion (e.g., 130 for chaos to divine)

### Using F3 - Price Reduction

**Scenario**: You want to reduce your item price by 10%

1. In PoE2, hover over your item in the stash
2. Right-click to open the price dialog (or position cursor where needed)
3. Press **F3**
4. The tool will:
   - Right-click at cursor
   - Copy current price
   - Calculate new price (original × 0.9 if 10% reduction)
   - Paste and confirm

**Example**:
- Current price: 100 chaos
- Reduction: 10%
- New price: 90 chaos

### Using F4 - Currency Conversion

**Scenario**: Converting chaos to divine (or other currency)

1. In PoE2, hover over your item
2. Right-click to open the price dialog
3. Press **F4**
4. The tool will:
   - Right-click at cursor
   - Copy current price
   - Calculate conversion (original × rate)
   - Paste value
   - Navigate UI: Tab → Up×3 → Enter×2

**Example**:
- Current price: 2 divine
- Rate: 130 (divine to chaos)
- Result: 260 chaos + UI navigation

### Adjusting Settings During Use

Press **F2** at any time to change:
- Reduction percentage
- Conversion rate

Changes take effect immediately.

## Troubleshooting

### "Failed to read valid price from clipboard"
- Make sure you have a valid number in the price field
- Check that the game UI is ready before pressing the hotkey
- Try increasing timing delays in `src/actions.ts` if your system is slow

### Hotkeys not working
- Ensure no other application is capturing the same keys
- Run with sudo/admin privileges if needed (some systems require this for global hotkeys)
- Check console for error messages

### Wrong values being pasted
- Verify your settings with F2
- Check that the clipboard contains only the price number
- Ensure you're clicking in the correct field

### Build errors
```bash
npm run clean
npm install
npm run build
```

## Tips

1. **Test your settings** on a cheap item first
2. **Timing adjustments**: If actions happen too fast/slow, edit delays in `src/actions.ts`
3. **Backup prices**: The tool directly modifies prices - have a backup strategy
4. **Multiple currencies**: Use F4's rate setting for different currency pairs

## Example Workflow

```
Starting session...
$ npm start

[Game: List item for 500 chaos]
Press F3 → Price reduced to 450 chaos (10% off)

[Game: Want to convert to divine]
Press F2 → Set rate to 130
Press F4 → Price converted to 3.46 divine (rounded to 3)

[Game: Further reduce divine price]
Press F2 → Set percent to 15
Press F3 → Price reduced to 2.55 divine (rounded to 2)
```

## Keyboard Shortcuts Summary

| Key | Action |
|-----|--------|
| F2  | Open settings |
| F3  | Reduce price by % |
| F4  | Convert currency |
| Ctrl+C | Exit application |
