#!/bin/bash
# Setup script for Linux desktop environment hotkeys
# This script helps configure F2/F3/F4 hotkeys for pgipte2

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NODE_BIN="$(which node)"

# Commands to bind
CMD_F2="$NODE_BIN $SCRIPT_DIR/dist/index.js --settings"
CMD_F3="$NODE_BIN $SCRIPT_DIR/dist/index.js --reduce"
CMD_F4="$NODE_BIN $SCRIPT_DIR/dist/index.js --convert"

echo "================================================"
echo "PGIPTE2 - Linux Hotkey Setup"
echo "================================================"
echo ""
echo "This script will help you set up F2/F3/F4 hotkeys"
echo "for your desktop environment."
echo ""

# Detect desktop environment
detect_de() {
    if [ -n "$KDE_FULL_SESSION" ] || [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
        echo "kde"
    elif [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        echo "gnome"
    elif [ "$XDG_CURRENT_DESKTOP" = "XFCE" ]; then
        echo "xfce"
    elif [ -n "$SWAYSOCK" ]; then
        echo "sway"
    elif command -v i3-msg &> /dev/null; then
        echo "i3"
    else
        echo "unknown"
    fi
}

DE=$(detect_de)

echo "Detected Desktop Environment: $DE"
echo ""

case "$DE" in
    kde)
        echo "Setting up KDE Plasma shortcuts..."
        echo ""
        
        # Detect which kwriteconfig version is available
        KWRITE_CMD=""
        if command -v kwriteconfig6 &> /dev/null; then
            KWRITE_CMD="kwriteconfig6"
            echo "✓ Found kwriteconfig6"
        elif command -v kwriteconfig5 &> /dev/null; then
            KWRITE_CMD="kwriteconfig5"
            echo "✓ Found kwriteconfig5"
        fi
        
        if [ -n "$KWRITE_CMD" ]; then
            echo "Attempting to configure KDE shortcuts..."
            echo ""
            
            # KDE uses kglobalshortcutsrc for shortcuts
            # We'll create custom shortcuts using kwriteconfig
            
            # Create a custom shortcuts group
            $KWRITE_CMD --file kglobalshortcutsrc --group "pgipte2.desktop" --key "_k_friendly_name" "PGIPTE2"
            
            # F2 - Settings
            $KWRITE_CMD --file kglobalshortcutsrc --group "pgipte2.desktop" --key "pgipte2-settings" "F2,none,PGIPTE2 Settings"
            
            # F3 - Reduce
            $KWRITE_CMD --file kglobalshortcutsrc --group "pgipte2.desktop" --key "pgipte2-reduce" "F3,none,PGIPTE2 Reduce Price"
            
            # F4 - Convert
            $KWRITE_CMD --file kglobalshortcutsrc --group "pgipte2.desktop" --key "pgipte2-convert" "F4,none,PGIPTE2 Convert Currency"
            
            # Create desktop file for the actions
            DESKTOP_FILE="$HOME/.local/share/applications/pgipte2.desktop"
            mkdir -p "$HOME/.local/share/applications"
            
            cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Type=Application
Name=PGIPTE2
Exec=$NODE_BIN $SCRIPT_DIR/dist/index.js
Icon=utilities-terminal
Categories=Utility;
NoDisplay=true

[Desktop Action settings]
Name=Settings
Exec=$CMD_F2

[Desktop Action reduce]
Name=Reduce Price
Exec=$CMD_F3

[Desktop Action convert]
Name=Convert Currency
Exec=$CMD_F4
EOF
            
            echo "✓ Created desktop file: $DESKTOP_FILE"
            echo ""
            echo "⚠️  KDE shortcut configuration attempted, but manual setup recommended."
            echo ""
            echo "To complete setup in KDE:"
            echo "1. Open System Settings"
            echo "2. Go to Shortcuts → Custom Shortcuts"
            echo "3. Click 'Edit' → 'New' → 'Global Shortcut' → 'Command/URL'"
            echo "4. Create three shortcuts:"
            echo ""
            echo "   Shortcut 1 (F2 - Settings):"
            echo "   - Name: PGIPTE2 Settings"
            echo "   - Trigger: F2"
            echo "   - Command: $CMD_F2"
            echo ""
            echo "   Shortcut 2 (F3 - Reduce):"
            echo "   - Name: PGIPTE2 Reduce Price"
            echo "   - Trigger: F3"
            echo "   - Command: $CMD_F3"
            echo ""
            echo "   Shortcut 3 (F4 - Convert):"
            echo "   - Name: PGIPTE2 Convert Currency"
            echo "   - Trigger: F4"
            echo "   - Command: $CMD_F4"
            echo ""
            echo "Alternative: Use Meta+F2, Meta+F3, Meta+F4 if F-keys conflict"
            echo ""
        else
            echo "⚠️  Neither kwriteconfig5 nor kwriteconfig6 found."
            echo ""
            echo "Manual configuration required:"
            echo "1. Open System Settings"
            echo "2. Go to Shortcuts → Custom Shortcuts"
            echo "3. Click 'Edit' → 'New' → 'Global Shortcut' → 'Command/URL'"
            echo "4. Create shortcuts for F2, F3, F4 with the commands shown below"
            echo ""
            echo "Commands:"
            echo "  F2: $CMD_F2"
            echo "  F3: $CMD_F3"
            echo "  F4: $CMD_F4"
            echo ""
        fi
        ;;
        
    gnome)
        echo "Setting up GNOME shortcuts..."
        echo ""
        
        if command -v gsettings &> /dev/null; then
            # GNOME custom shortcuts
            SCHEMA="org.gnome.settings-daemon.plugins.media-keys"
            
            # Get current custom keybindings
            CURRENT_KEYS=$(gsettings get $SCHEMA custom-keybindings)
            
            # Add our custom shortcuts
            gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f2/ name "PGIPTE2 Settings"
            gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f2/ command "$CMD_F2"
            gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f2/ binding "F2"
            
            gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f3/ name "PGIPTE2 Reduce Price"
            gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f3/ command "$CMD_F3"
            gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f3/ binding "F3"
            
            gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f4/ name "PGIPTE2 Convert Currency"
            gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f4/ command "$CMD_F4"
            gsettings set $SCHEMA.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f4/ binding "F4"
            
            # Update the list of custom keybindings
            gsettings set $SCHEMA custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f3/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/pgipte2-f4/']"
            
            echo "✓ GNOME shortcuts configured!"
            echo ""
            echo "Your hotkeys are now active:"
            echo "  F2 → Settings"
            echo "  F3 → Reduce Price"
            echo "  F4 → Convert Currency"
            echo ""
            echo "To verify, check: Settings → Keyboard → Keyboard Shortcuts → Custom Shortcuts"
        else
            echo "gsettings not found. Cannot auto-configure."
            echo "Please set up manually in GNOME Settings."
        fi
        ;;
        
    xfce)
        echo "Setting up XFCE shortcuts..."
        echo ""
        
        if command -v xfconf-query &> /dev/null; then
            xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/F2" -n -t string -s "$CMD_F2"
            xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/F3" -n -t string -s "$CMD_F3"
            xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/F4" -n -t string -s "$CMD_F4"
            
            echo "✓ XFCE shortcuts configured!"
            echo ""
            echo "Your hotkeys are now active:"
            echo "  F2 → Settings"
            echo "  F3 → Reduce Price"
            echo "  F4 → Convert Currency"
            echo ""
            echo "To verify, check: Settings → Keyboard → Application Shortcuts"
        else
            echo "xfconf-query not found. Manual configuration required."
            echo ""
            echo "Please add these shortcuts in XFCE Settings → Keyboard → Application Shortcuts:"
            echo "  F2 → $CMD_F2"
            echo "  F3 → $CMD_F3"
            echo "  F4 → $CMD_F4"
        fi
        ;;
        
    sway)
        echo "Setting up Sway shortcuts..."
        echo ""
        
        SWAY_CONFIG="$HOME/.config/sway/config"
        
        # Backup config
        if [ -f "$SWAY_CONFIG" ]; then
            cp "$SWAY_CONFIG" "$SWAY_CONFIG.backup.$(date +%s)"
            echo "✓ Backed up sway config"
        fi
        
        # Create config snippet
        cat >> "$SWAY_CONFIG" << EOF

# PGIPTE2 hotkeys
bindsym F2 exec $CMD_F2
bindsym F3 exec $CMD_F3
bindsym F4 exec $CMD_F4
EOF
        
        echo "✓ Sway config updated!"
        echo ""
        echo "Added to $SWAY_CONFIG:"
        echo "  bindsym F2 exec $CMD_F2"
        echo "  bindsym F3 exec $CMD_F3"
        echo "  bindsym F4 exec $CMD_F4"
        echo ""
        echo "Run 'swaymsg reload' to apply changes"
        ;;
        
    i3)
        echo "Setting up i3 shortcuts..."
        echo ""
        
        I3_CONFIG="$HOME/.config/i3/config"
        
        # Backup config
        if [ -f "$I3_CONFIG" ]; then
            cp "$I3_CONFIG" "$I3_CONFIG.backup.$(date +%s)"
            echo "✓ Backed up i3 config"
        fi
        
        # Create config snippet
        cat >> "$I3_CONFIG" << EOF

# PGIPTE2 hotkeys
bindsym F2 exec $CMD_F2
bindsym F3 exec $CMD_F3
bindsym F4 exec $CMD_F4
EOF
        
        echo "✓ i3 config updated!"
        echo ""
        echo "Added to $I3_CONFIG:"
        echo "  bindsym F2 exec $CMD_F2"
        echo "  bindsym F3 exec $CMD_F3"
        echo "  bindsym F4 exec $CMD_F4"
        echo ""
        echo "Run 'i3-msg reload' to apply changes"
        ;;
        
    *)
        echo "⚠️  Unknown or unsupported desktop environment"
        echo ""
        echo "Please manually configure these keyboard shortcuts:"
        echo ""
        echo "F2 → $CMD_F2"
        echo "F3 → $CMD_F3"
        echo "F4 → $CMD_F4"
        echo ""
        echo "Check your DE's keyboard shortcut settings."
        ;;
esac

echo ""
echo "================================================"
echo "Setup Complete!"
echo "================================================"
echo ""
echo "Test your shortcuts:"
echo "  Press F2 to open settings"
echo "  Press F3 to test price reduction"
echo "  Press F4 to test currency conversion"
echo ""
