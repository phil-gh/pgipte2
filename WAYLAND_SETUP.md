# Wayland Setup - Quick Fix for Authorization Popup

## The Issue

You're seeing: `Authorization required, but no authorization protocol specified`

This happens because robotjs needs X11 access (via XWayland) to simulate keyboard/mouse input.

## Quick Fix (This Session Only)

Run this once per login session:

```bash
xhost +local:
```

Then run your tool normally:
```bash
npm start -- --reduce
```

The authorization message will still appear in console but **no popup** will show!

---

## Permanent Fix (Recommended)

Add to KDE autostart so it runs on every login:

### Method 1: Using the Helper Script

```bash
cd ~/src/pgipte2
./fix-wayland-permissions.sh
```

Follow the prompts to create autostart entries.

### Method 2: Manual Setup

**Create autostart script:**

```bash
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/xhost-permissions.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Allow Local X11 Access
Exec=/bin/bash -c "xhost +local: 2>/dev/null"
X-KDE-autostart-phase=1
Hidden=false
EOF
```

**Verify:**
```bash
cat ~/.config/autostart/xhost-permissions.desktop
```

**Activate now:**
```bash
xhost +local:
```

**Test:**
```bash
echo -n "100" | wl-copy
npm start -- --reduce
# Should work without popup!
```

---

## What This Does

`xhost +local:` allows local applications (like robotjs via XWayland) to access X11 display server.

**Is this safe?**
✅ **Yes** - Only allows LOCAL connections (same machine)  
✅ **No network access** - Remote connections still blocked  
✅ **Standard practice** - Required for automation tools on Wayland  

---

## Alternative: Suppress Console Message

If you just want to hide the console message:

```bash
npm start -- --reduce 2>/dev/null
```

Or update `~/.bashrc` or `~/.zshrc`:
```bash
alias pgipte2-reduce='npm start --prefix ~/src/pgipte2 -- --reduce 2>/dev/null'
alias pgipte2-convert='npm start --prefix ~/src/pgipte2 -- --convert 2>/dev/null'
alias pgipte2-settings='npm start --prefix ~/src/pgipte2 -- --settings 2>/dev/null'
```

---

## Troubleshooting

### "xhost: command not found"

Install xorg-xhost:
```bash
sudo pacman -S xorg-xhost  # Arch/Manjaro
sudo apt install x11-xserver-utils  # Debian/Ubuntu
```

### Still getting popups?

1. Make sure you ran `xhost +local:`
2. Check it's active: `xhost` (should show "local:" in the list)
3. Logout and login again if you added autostart

### Want to revert?

Remove permission:
```bash
xhost -local:
```

Remove autostart:
```bash
rm ~/.config/autostart/xhost-permissions.desktop
```

---

## Summary

**Quick solution:**
```bash
xhost +local: && npm start -- --reduce
```

**Permanent solution:**
```bash
./fix-wayland-permissions.sh
```

**The tool works fine either way!** The message is just a warning, not an error.
