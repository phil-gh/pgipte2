# PGIPTE2 - Path of Exile 2 Price Tool

A TypeScript rewrite of the PoE price reduction tool, providing automated price management for Path of Exile 2 trading.

## Features

- **F3**: Percentage-based price reduction
- **F4**: Currency conversion with automatic UI navigation
- **F2**: Settings configuration

## Installation

```bash
cd ~/src/pgipte2
npm install
npm run build
```

## Usage

### On Windows (Recommended - where PoE2 runs)

```bash
npm start
```

The tool will listen for global hotkeys (F2, F3, F4) in the background.

### On Linux

Due to Wayland/security restrictions, global hotkeys require system integration.

**Option 1: Command-line mode (testing)**
```bash
npm start -- --settings   # Configure settings
npm start -- --reduce     # Test F3 (price reduction)
npm start -- --convert    # Test F4 (currency conversion)
```

**Option 2: Desktop environment keyboard shortcuts**

Bind the following commands to your desired keys:
- F2: `node ~/src/pgipte2/dist/index.js --settings`
- F3: `node ~/src/pgipte2/dist/index.js --reduce`
- F4: `node ~/src/pgipte2/dist/index.js --convert`

Instructions for popular DEs:
- **KDE**: System Settings → Shortcuts → Custom Shortcuts
- **GNOME**: Settings → Keyboard → Custom Shortcuts
- **XFCE**: Settings → Keyboard → Application Shortcuts

**Option 3: Use X11**

If you're on Wayland, switch to X11 session for native global hotkey support.

## Configuration

Settings are stored in a JSON configuration file with the following options:
- `percent`: Percentage to reduce prices by (default: 10)
- `rate`: Currency conversion rate (default: 130)

## Hotkeys

| Key | Action | Description |
|-----|--------|-------------|
| F2  | Settings | Open configuration dialog |
| F3  | Reduce | Reduce price by configured % |
| F4  | Convert | Convert currency & navigate UI |

## Requirements

- Node.js 18+
- **Windows**: Full global hotkey support
- **Linux**: Requires X11 or DE keyboard shortcuts

## Platform Support

| Platform | Global Hotkeys | Status |
|----------|----------------|--------|
| Windows  | ✅ Native     | Fully supported |
| Linux X11| ✅ Native     | Supported |
| Linux Wayland | ⚠️ Requires DE integration | Use CLI mode or DE shortcuts |
| macOS    | ⚠️ Untested   | May work with permissions |

## Troubleshooting

### Linux: "OS is not supported" error

This is expected on Wayland. Use command-line mode or configure DE shortcuts.

### Windows: Hotkeys not working

- Run as administrator
- Check for conflicting applications using the same hotkeys
- Ensure antivirus isn't blocking keyboard hooks

## Original Project

Based on [pgipte](https://github.com/phil-gh/pgipte) by phil-gh

## Documentation

- [USAGE.md](USAGE.md) - Detailed usage guide
- [DEVELOPMENT.md](DEVELOPMENT.md) - Development documentation
- [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Project overview
