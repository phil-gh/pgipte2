# PGIPTE2 - Project Summary

## Overview

A complete TypeScript rewrite of the Path of Exile 2 price management tool, originally written in AutoHotkey. This tool automates price reduction and currency conversion for PoE2 trading.

## Project Status

✅ **Phase 1 - Project Setup** - COMPLETE
- Git repository initialized
- TypeScript configuration
- Dependencies installed and configured
- Build system setup

✅ **Phase 2 - Core Functionality** - COMPLETE
- Configuration management
- Clipboard operations
- Keyboard/mouse automation
- Global hotkey registration
- F2/F3/F4 handlers implemented

## Project Structure

```
~/src/pgipte2/
├── src/
│   ├── index.ts          # Main entry point, hotkey registration
│   ├── config.ts         # Settings management (percent, rate)
│   ├── clipboard.ts      # Clipboard operations & price parsing
│   ├── actions.ts        # F3/F4 action handlers
│   └── settings-ui.ts    # F2 settings interface
├── package.json          # Dependencies & scripts
├── tsconfig.json         # TypeScript configuration
├── README.md             # User-facing documentation
├── USAGE.md              # Detailed usage guide
├── DEVELOPMENT.md        # Developer documentation
└── test-parsing.js       # Price parsing tests
```

## Features Implemented

### F3 - Percentage Reduction
- Right-click → Copy → Reduce by % → Paste → Confirm
- Configurable reduction percentage (1-99%)
- Default: 10%

### F4 - Currency Conversion
- Right-click → Copy → Multiply by rate → Paste → UI Navigation
- Special UI navigation: Tab → Up×3 → Enter×2
- Configurable conversion rate
- Default: 130 (chaos to divine)

### F2 - Settings
- Interactive CLI for configuration
- Input validation
- Persistent storage in user config directory

## Technologies Used

| Package | Purpose | Version |
|---------|---------|---------|
| TypeScript | Type-safe development | 5.x |
| @jitsi/robotjs | Keyboard/mouse automation | 0.6.x |
| clipboardy | Clipboard access | 4.x |
| node-global-key-listener | Global hotkeys | 0.1.x |
| conf | Configuration storage | Latest |
| inquirer | Interactive CLI | Latest |

## Key Differences from Original

| Feature | Original (AHK) | New (TypeScript) |
|---------|---------------|------------------|
| Language | AutoHotkey | TypeScript/Node.js |
| Platform | Windows only | Cross-platform |
| Config | INI file | JSON (via conf) |
| Settings UI | AHK GUI | CLI (inquirer) |
| Build | None | TypeScript compiler |
| Packaging | .exe | Node app (can bundle) |

## Installation & Usage

```bash
# Install
cd ~/src/pgipte2
npm install
npm run build

# Run
npm start

# Hotkeys
F2 - Settings
F3 - Reduce price
F4 - Convert currency
```

## Testing

- ✅ Price parsing tested (11 test cases passing)
- ✅ Build succeeds without errors
- ⏳ Manual testing required in PoE2

## Git History

```
47a05c6 Add comprehensive usage guide
a35e998 Add development documentation and parsing tests
a6798da Phase 2: Implement core functionality
81cacbe Initial project setup with TypeScript and dependencies
```

## Next Steps (Future Phases)

### Phase 3 - Polish & Distribution
- [ ] Error handling improvements
- [ ] Better logging system
- [ ] Configurable timing delays
- [ ] Package for distribution (pkg/nexe)

### Phase 4 - Enhancements
- [ ] GUI for settings (Electron)
- [ ] Hotkey customization
- [ ] Multiple preset configurations
- [ ] Price history/statistics
- [ ] Auto-update mechanism

## Known Limitations

1. Requires Node.js runtime
2. Timing delays may need adjustment per system
3. Settings UI is CLI-based (no GUI yet)
4. Platform-specific testing needed (developed on Linux)

## License

ISC (same as package.json default)

## Original Project

Based on [pgipte](https://github.com/phil-gh/pgipte) by phil-gh

---

**Status**: Ready for testing in PoE2  
**Last Updated**: 2026-01-08  
**Version**: 1.0.0
