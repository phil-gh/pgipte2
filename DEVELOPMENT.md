# Development Notes

## Architecture

The project is structured into focused modules:

### config.ts
- Manages user settings (percent, rate)
- Uses `conf` package for persistent storage
- Validates input ranges (percent: 1-99, rate: >0)
- Config stored in user's config directory

### clipboard.ts
- Handles clipboard read/write operations
- Parses prices from text (supports comma/period decimals)
- Validates numeric input

### actions.ts
- **handlePercentageReduction()** - F3 handler
  - Right-click → Copy → Calculate reduction → Paste → Enter
- **handleCurrencyConversion()** - F4 handler  
  - Right-click → Copy → Calculate conversion → Paste → Tab → Up×3 → Enter×2
- Includes timing delays for game UI responsiveness

### settings-ui.ts
- Interactive CLI for configuration
- Uses `inquirer` for user-friendly prompts
- Validates and saves settings

### index.ts
- Main entry point
- Registers global hotkeys (F2, F3, F4)
- Prevents overlapping executions
- Handles graceful shutdown

## Dependencies

- **@jitsi/robotjs** - Keyboard/mouse automation (fork of robotjs, better maintained)
- **clipboardy** - Cross-platform clipboard access
- **node-global-key-listener** - Global hotkey registration
- **conf** - Configuration storage
- **inquirer** - Interactive CLI prompts

## Building

```bash
npm run dev     # Run without building (uses tsx)
npm start       # Run built version
```

## Module System

- Using ESM (`"type": "module"` in package.json)
- Local imports require .js extension (e.g., `./config.js`)
- External packages don't use .js extension

## Testing Notes

**Manual Testing Checklist:**
- [ ] F2 - Opens settings, validates input, saves correctly
- [ ] F3 - Reduces price by configured percentage
- [ ] F4 - Converts currency and navigates UI correctly
- [ ] Config persists between runs
- [ ] Invalid prices are handled gracefully
- [ ] Multiple rapid keypresses don't cause issues (debouncing works)

## Known Limitations

1. **Platform-specific**: Primarily tested on Windows (PoE2's main platform)
2. **Timing-dependent**: Sleep delays may need adjustment for different systems
3. **Game-specific**: UI navigation hardcoded for PoE2's trade interface
4. **No GUI**: Settings are CLI-based (could upgrade to Electron later)

## Future Improvements

- [ ] Add GUI for settings (Electron or web-based)
- [ ] Configurable timing delays
- [ ] Logging system
- [ ] Distribution packaging (pkg, electron-builder)
- [ ] Unit tests for price parsing and calculations
- [ ] Hotkey customization
