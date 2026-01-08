# PGIPTE2 - Quick Start Guide

## 🚀 For Windows Users (Path of Exile 2)

```bash
# 1. Install
cd ~/src/pgipte2
npm install
npm run build

# 2. Run
npm start

# 3. Use
Press F2 - Settings
Press F3 - Reduce price
Press F4 - Convert currency
```

That's it! The tool runs in the background.

---

## 🐧 For Linux Users

### One-Command Setup

```bash
cd ~/src/pgipte2
npm install
npm run build
./setup-linux-hotkeys.sh
```

This automatically configures F2/F3/F4 for your DE.

### Manual Setup

If automatic setup doesn't work, add these commands to your DE shortcuts:

```bash
# F2 (Settings)
node ~/src/pgipte2/dist/index.js --settings

# F3 (Reduce Price)  
node ~/src/pgipte2/dist/index.js --reduce

# F4 (Convert Currency)
node ~/src/pgipte2/dist/index.js --convert
```

**Where to add:**
- **GNOME**: Settings → Keyboard → Custom Shortcuts
- **KDE**: System Settings → Shortcuts → Custom Shortcuts
- **XFCE**: Settings → Keyboard → Application Shortcuts
- **Sway/i3**: Edit `~/.config/sway/config` or `~/.config/i3/config`

See [LINUX_SETUP.md](LINUX_SETUP.md) for detailed instructions.

---

## 🎮 How It Works

### F3 - Reduce Price
1. Hover over item in PoE2
2. Press F3
3. Price automatically reduced by configured %

### F4 - Convert Currency
1. Hover over item
2. Press F4
3. Currency converted and UI navigated

### F2 - Change Settings
1. Press F2
2. Set reduction % (1-99)
3. Set conversion rate (e.g., 130 for chaos→divine)

---

## ⚙️ Configuration

Default settings:
- **Reduction**: 10% off
- **Conversion Rate**: 130 (chaos to divine)

Change via F2 or edit directly:
- **Windows**: `%APPDATA%\pgipte2-nodejs\Config\config.json`
- **Linux**: `~/.config/pgipte2-nodejs/config.json`

---

## 🔧 Troubleshooting

### Command not found
```bash
cd ~/src/pgipte2
npm install
npm run build
```

### Hotkeys don't work (Linux)
```bash
./setup-linux-hotkeys.sh
# Or see LINUX_SETUP.md
```

### Permission denied
```bash
chmod +x setup-linux-hotkeys.sh
chmod +x dist/index.js
```

### Test individual functions
```bash
npm start -- --settings  # Test settings
npm start -- --reduce    # Test F3
npm start -- --convert   # Test F4
```

---

## 📚 Full Documentation

- **[README.md](README.md)** - Main documentation
- **[LINUX_SETUP.md](LINUX_SETUP.md)** - Linux hotkey setup
- **[USAGE.md](USAGE.md)** - Detailed usage guide
- **[PLATFORM_NOTES.md](PLATFORM_NOTES.md)** - Platform details

---

## 💡 Tips

1. **Start simple**: Use default settings first
2. **Test on cheap items**: Before using on valuable items
3. **Adjust timing**: Edit `src/actions.ts` if too fast/slow
4. **Multiple currencies**: Change rate in F2 for different pairs
5. **Backup important prices**: Tool modifies directly

---

## ✅ Verification

After setup, verify everything works:

```bash
# 1. Check build
ls dist/*.js

# 2. Test settings
npm start -- --settings
# Should show interactive prompt

# 3. Check hotkeys (Linux)
# Press your configured hotkey (F2/F3/F4)
# Should trigger the tool

# 4. Windows - just run
npm start
# Should say "Listening for hotkeys..."
```

---

**You're ready to use PGIPTE2!** 🎉
