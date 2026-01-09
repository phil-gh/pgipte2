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
npm run dev
```

## Usage

### On Windows (Recommended - where PoE2 runs)

```bash
npm start
```

The tool will listen for global hotkeys (F2, F3, F4) in the background.

### On Linux

Due to Wayland/security restrictions, global hotkeys require system integration.

#### 🚀 Quick Automated Setup

```bash
cd ~/src/pgipte2
./setup-linux-hotkeys.sh
```

This will automatically configure F2/F3/F4 hotkeys for your desktop environment (GNOME, KDE, XFCE, Sway, i3, etc.).

#### 📖 Detailed Instructions

See [LINUX_SETUP.md](LINUX_SETUP.md) for:
- Complete manual setup for all DEs
- Troubleshooting tips
- Alternative keybinding options
- Step-by-step screenshots

#### Alternative: Command-line mode (for testing)

```bash
npm start -- --settings   # Configure settings
npm start -- --reduce     # Test F3 (price reduction)
npm start -- --convert    # Test F4 (currency conversion)
```

## Configuration

Settings are stored in a JSON configuration file with the following options:
- `percent`: Percentage to reduce prices by (default: 10)
- `rate`: Currency conversion rate (default: 130)
- `uiDelayMs`: Delay in milliseconds between UI interactions (default: 50, range: 0-5000)

## Hotkeys

| Key | Action | Description |
|-----|--------|-------------|
| F2  | Settings | Open configuration dialog |
| F3  | Reduce | Reduce price by configured % |
| F4  | Convert | Convert currency & navigate UI |

## Requirements

- Node.js 18+
- **Windows**: Full global hotkey support ✅
- **Linux**: Requires desktop environment integration (see [LINUX_SETUP.md](LINUX_SETUP.md)) ⚙️

## Platform Support

| Platform | Global Hotkeys | Status |
|----------|----------------|--------|
| Windows  | ✅ Native     | Fully supported |
| Linux X11| ✅ Native     | Supported |
| Linux Wayland | ✅ Via DE shortcuts | **Use setup script** |
| macOS    | ⚠️ Untested   | May work with permissions |

## Quick Links

- **[LINUX_SETUP.md](LINUX_SETUP.md)** - Detailed Linux hotkey setup guide
- **[USAGE.md](USAGE.md)** - How to use in Path of Exile 2
- **[DEVELOPMENT.md](DEVELOPMENT.md)** - Developer documentation
- **[PLATFORM_NOTES.md](PLATFORM_NOTES.md)** - Platform-specific details

## Troubleshooting

### Linux: "OS is not supported" error

This is expected on Wayland. Run the setup script:

```bash
./setup-linux-hotkeys.sh
```

Or see [LINUX_SETUP.md](LINUX_SETUP.md) for manual configuration.

### Windows: Hotkeys not working

- Run as administrator
- Check for conflicting applications using the same hotkeys
- Ensure antivirus isn't blocking keyboard hooks

## Original Project

Based on [pgipte](https://github.com/phil-gh/pgipte) by phil-gh
