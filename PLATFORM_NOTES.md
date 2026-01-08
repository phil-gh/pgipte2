# Platform-Specific Notes

## Overview

This tool was developed to be cross-platform, but global hotkey support varies by OS due to security and architecture differences.

## Platform Status

### ✅ Windows (Recommended)

**Status**: Fully supported  
**Global Hotkeys**: Native support via `node-global-key-listener`

Since Path of Exile 2 runs on Windows, this is the primary target platform.

#### Usage
```bash
npm start
```

The tool will run in the background and respond to F2/F3/F4 keypresses globally.

#### Permissions
- May require running as Administrator
- Some antivirus software may flag keyboard hooks

---

### ⚠️ Linux

**Status**: Functional with limitations  
**Global Hotkeys**: Platform-dependent

#### X11 (✅ Should work)

On X11 systems, `node-global-key-listener` should work natively.

```bash
npm start  # Should work on X11
```

#### Wayland (⚠️ Limited)

Wayland's security model prevents applications from registering global hotkeys without system integration.

**Workaround 1: CLI Mode**

Use command-line flags for testing:

```bash
# Test individual functions
npm start -- --settings
npm start -- --reduce
npm start -- --convert
```

**Workaround 2: Desktop Environment Integration**

Configure your DE to bind hotkeys to these commands:

```bash
# F2
node ~/src/pgipte2/dist/index.js --settings

# F3
node ~/src/pgipte2/dist/index.js --reduce

# F4
node ~/src/pgipte2/dist/index.js --convert
```

**Desktop Environment Instructions:**

**KDE Plasma:**
1. System Settings → Shortcuts → Custom Shortcuts
2. Edit → New → Global Shortcut → Command/URL
3. Trigger: F2/F3/F4
4. Action: command from above

**GNOME:**
1. Settings → Keyboard → Keyboard Shortcuts
2. Scroll to "Custom Shortcuts"
3. Click "+" to add new shortcut
4. Name, Command, Shortcut key

**XFCE:**
1. Settings → Keyboard → Application Shortcuts
2. Add → Enter command → Press key

**i3/sway:**
Add to config:
```
bindsym F2 exec node ~/src/pgipte2/dist/index.js --settings
bindsym F3 exec node ~/src/pgipte2/dist/index.js --reduce
bindsym F4 exec node ~/src/pgipte2/dist/index.js --convert
```

**Workaround 3: Switch to X11**

Log out and select "X11" or "Xorg" session instead of Wayland at login screen.

---

### ❓ macOS

**Status**: Untested  
**Global Hotkeys**: May work with accessibility permissions

The tool should theoretically work on macOS but requires:
- Accessibility permissions for keyboard monitoring
- Testing needed

---

## Why These Limitations?

### Windows
- Has Win32 API for global keyboard hooks
- `node-global-key-listener` uses native bindings

### Linux X11
- Provides XGrabKey for global hotkeys
- Applications can register system-wide hooks

### Linux Wayland
- Security model prevents apps from grabbing global input
- Requires compositor/DE integration
- Intentional design decision for security

### macOS
- Requires accessibility permissions
- Stricter security model
- May need additional configuration

---

## Recommendations

1. **For actual use**: Run on Windows where PoE2 is played
2. **For development on Linux**: Use CLI mode or DE shortcuts
3. **For testing**: Use the `--reduce`, `--convert`, `--settings` flags

---

## Technical Details

The tool attempts to import `node-global-key-listener` dynamically only on Windows:

```typescript
if (process.platform === 'win32') {
  const { GlobalKeyboardListener } = await import('node-global-key-listener');
  // Set up hotkeys
} else {
  // Show Linux instructions
}
```

This allows the package to install and run on Linux without crashing, while providing full functionality on Windows.

---

## Future Improvements

Potential solutions for better Linux support:

1. **Implement native Wayland support**
   - Would require compositor-specific protocols
   - Complex and not standardized

2. **Create systemd service + DBus**
   - Integrate with DE more deeply
   - Requires root/system configuration

3. **Use platform-specific solutions**
   - `xbindkeys` wrapper for X11
   - `swhkd` for Wayland
   - Adds external dependencies

4. **HTTP/WebSocket server**
   - Tool runs as background service
   - Web interface or companion app triggers actions
   - More complex architecture

For now, the DE integration approach is the most practical for Linux users.
