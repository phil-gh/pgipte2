# Linux Setup Guide - Hotkey Configuration

Since you're running on Wayland, global hotkeys require desktop environment integration. This guide provides **automatic setup** and **manual instructions** for all major Linux DEs.

## Quick Setup (Automated)

We've created a setup script that detects your DE and configures hotkeys automatically:

```bash
cd ~/src/pgipte2
./setup-linux-hotkeys.sh
```

This script will:
- Detect your desktop environment
- Configure F2/F3/F4 hotkeys automatically (where possible)
- Provide manual instructions for DEs that require it

---

## Manual Setup Instructions

If the automatic script doesn't work, follow the instructions for your DE:

### 🔷 KDE Plasma

**Step-by-Step:**

1. Open **System Settings**
2. Navigate to **Shortcuts** → **Custom Shortcuts**
3. Click **Edit** → **New** → **Global Shortcut** → **Command/URL**

**Create 3 shortcuts:**

**Shortcut 1 - Settings (F2):**
- Name: `PGIPTE2 Settings`
- Trigger: Press **F2**
- Action: `node ~/src/pgipte2/dist/index.js --settings`

**Shortcut 2 - Reduce Price (F3):**
- Name: `PGIPTE2 Reduce Price`
- Trigger: Press **F3**
- Action: `node ~/src/pgipte2/dist/index.js --reduce`

**Shortcut 3 - Convert Currency (F4):**
- Name: `PGIPTE2 Convert Currency`
- Trigger: Press **F4**
- Action: `node ~/src/pgipte2/dist/index.js --convert`

4. Click **Apply**

**Or use this automated command:**
```bash
# Note: KDE shortcuts via CLI are complex, manual setup recommended
./setup-linux-hotkeys.sh
```

---

### 🟢 GNOME

**Automated Setup:**
```bash
cd ~/src/pgipte2
./setup-linux-hotkeys.sh
```

**Manual Setup:**

1. Open **Settings**
2. Go to **Keyboard** → **Keyboard Shortcuts**
3. Scroll to bottom and click **Custom Shortcuts**
4. Click **+** to add new shortcut

**Create 3 shortcuts:**

| Name | Command | Shortcut |
|------|---------|----------|
| PGIPTE2 Settings | `node ~/src/pgipte2/dist/index.js --settings` | F2 |
| PGIPTE2 Reduce Price | `node ~/src/pgipte2/dist/index.js --reduce` | F3 |
| PGIPTE2 Convert Currency | `node ~/src/pgipte2/dist/index.js --convert` | F4 |

**Or use gsettings commands:**

```bash
SCHEMA="org.gnome.settings-daemon.plugins.media-keys"

# F2 - Settings
gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f2/ name "PGIPTE2 Settings"
gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f2/ command "node $HOME/src/pgipte2/dist/index.js --settings"
gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f2/ binding "F2"

# F3 - Reduce
gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f3/ name "PGIPTE2 Reduce Price"
gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f3/ command "node $HOME/src/pgipte2/dist/index.js --reduce"
gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f3/ binding "F3"

# F4 - Convert
gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f4/ name "PGIPTE2 Convert Currency"
gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f4/ command "node $HOME/src/pgipte2/dist/index.js --convert"
gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f4/ binding "F4"

# Register the shortcuts
gsettings set $SCHEMA custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f3/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f4/']"
```

---

### 🔵 XFCE

**Automated Setup:**
```bash
cd ~/src/pgipte2
./setup-linux-hotkeys.sh
```

**Manual Setup:**

1. Open **Settings Manager**
2. Go to **Keyboard** → **Application Shortcuts**
3. Click **Add** button

**Add 3 shortcuts:**

| Command | Key |
|---------|-----|
| `node ~/src/pgipte2/dist/index.js --settings` | F2 |
| `node ~/src/pgipte2/dist/index.js --reduce` | F3 |
| `node ~/src/pgipte2/dist/index.js --convert` | F4 |

**Or use xfconf-query:**

```bash
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/F2" -n -t string -s "node $HOME/src/pgipte2/dist/index.js --settings"
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/F3" -n -t string -s "node $HOME/src/pgipte2/dist/index.js --reduce"
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/F4" -n -t string -s "node $HOME/src/pgipte2/dist/index.js --convert"
```

---

### ⬛ Sway (Wayland)

**Automated Setup:**
```bash
cd ~/src/pgipte2
./setup-linux-hotkeys.sh
```

**Manual Setup:**

Edit `~/.config/sway/config` and add:

```
# PGIPTE2 hotkeys
bindsym F2 exec node ~/src/pgipte2/dist/index.js --settings
bindsym F3 exec node ~/src/pgipte2/dist/index.js --reduce
bindsym F4 exec node ~/src/pgipte2/dist/index.js --convert
```

Then reload Sway:
```bash
swaymsg reload
```

---

### ⬜ i3

**Automated Setup:**
```bash
cd ~/src/pgipte2
./setup-linux-hotkeys.sh
```

**Manual Setup:**

Edit `~/.config/i3/config` and add:

```
# PGIPTE2 hotkeys
bindsym F2 exec node ~/src/pgipte2/dist/index.js --settings
bindsym F3 exec node ~/src/pgipte2/dist/index.js --reduce
bindsym F4 exec node ~/src/pgipte2/dist/index.js --convert
```

Then reload i3:
```bash
i3-msg reload
```

---

### 🟣 Hyprland

Edit `~/.config/hypr/hyprland.conf` and add:

```
# PGIPTE2 hotkeys
bind = , F2, exec, node ~/src/pgipte2/dist/index.js --settings
bind = , F3, exec, node ~/src/pgipte2/dist/index.js --reduce
bind = , F4, exec, node ~/src/pgipte2/dist/index.js --convert
```

Then reload:
```bash
hyprctl reload
```

---

### 🟠 Other Desktop Environments

For other DEs (Cinnamon, MATE, Budgie, etc.), the general approach is:

1. Find your DE's keyboard shortcuts settings
2. Add custom shortcuts for F2, F3, F4
3. Use these commands:
   - F2: `node ~/src/pgipte2/dist/index.js --settings`
   - F3: `node ~/src/pgipte2/dist/index.js --reduce`
   - F4: `node ~/src/pgipte2/dist/index.js --convert`

---

## Testing Your Setup

After configuration, test each hotkey:

```bash
# Test F2 (settings)
# Should open an interactive prompt

# Test F3 (reduce price)
# Position cursor, wait 2 seconds, simulates price reduction

# Test F4 (convert currency)
# Position cursor, wait 2 seconds, simulates currency conversion
```

---

## Troubleshooting

### Shortcuts Not Working

1. **Check if F-keys are mapped to media functions:**
   - You may need to press `Fn+F2` instead of just `F2`
   - Or configure your keyboard to use F-keys directly

2. **Check for conflicts:**
   ```bash
   # GNOME
   gsettings list-recursively | grep F2
   
   # KDE
   kreadconfig5 --file kglobalshortcutsrc --group kwin
   ```

3. **Verify commands work:**
   ```bash
   node ~/src/pgipte2/dist/index.js --settings
   ```

4. **Check Node.js path:**
   ```bash
   which node
   # Update commands if path differs from /usr/bin/node
   ```

### Permission Issues

If you get permission errors:

```bash
cd ~/src/pgipte2
chmod +x dist/index.js
chmod +x setup-linux-hotkeys.sh
```

---

## Alternative: Use Different Keys

If F2/F3/F4 conflict with your system, you can use different keys:

**For Sway/i3:**
```
bindsym Mod4+F2 exec node ~/src/pgipte2/dist/index.js --settings
bindsym Mod4+F3 exec node ~/src/pgipte2/dist/index.js --reduce
bindsym Mod4+F4 exec node ~/src/pgipte2/dist/index.js --convert
```

**For GNOME/KDE/XFCE:**
Use the same GUI but choose different key combinations like:
- `Super+F2` (Windows key + F2)
- `Ctrl+Alt+F2`
- Any other preferred combination

---

## Summary

| Desktop Environment | Setup Method | Difficulty |
|---------------------|--------------|------------|
| GNOME | Automated | ⭐ Easy |
| XFCE | Automated | ⭐ Easy |
| Sway | Automated | ⭐ Easy |
| i3 | Automated | ⭐ Easy |
| KDE Plasma | Manual | ⭐⭐ Medium |
| Hyprland | Manual | ⭐⭐ Medium |
| Others | Manual | ⭐⭐ Medium |

**Recommended:** Run `./setup-linux-hotkeys.sh` first, then verify in your DE's settings.
