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
        
        # Create kglobalshortcutsrc entries
        KCONFIG="$HOME/.config/kglobalshortcutsrc"
        
        # Backup existing config
        if [ -f "$KCONFIG" ]; then
            cp "$KCONFIG" "$KCONFIG.backup.$(date +%s)"
            echo "✓ Backed up existing config"
        fi
        
        # Check if kwriteconfig5 is available
        if command -v kwriteconfig5 &> /dev/null; then
            echo "Using kwriteconfig5 to set shortcuts..."
            
            # Note: KDE shortcuts are complex and usually need manual setup
            echo ""
            echo "⚠️  KDE shortcuts require manual configuration."
            echo ""
            echo "Please follow these steps:"
            echo "1. Open System Settings"
            echo "2. Go to Shortcuts → Custom Shortcuts"
            echo "3. Click 'Edit' → 'New' → 'Global Shortcut' → 'Command/URL'"
            echo "4. Create three shortcuts:"
            echo ""
            echo "   Shortcut 1:"
            echo "   - Trigger: F2"
            echo "   - Command: $CMD_F2"
            echo ""
            echo "   Shortcut 2:"
            echo "   - Trigger: F3"
            echo "   - Command: $CMD_F3"
            echo ""
            echo "   Shortcut 3:"
            echo "   - Trigger: F4"
            echo "   - Command: $CMD_F4"
            echo ""
        else
            echo "kwriteconfig5 not found. Manual configuration required."
        fi
        ;;
        
    gnome)
        echo "Setting up GNOME shortcuts..."
        echo ""
        
        if command -v gsettings &> /dev/null; then
            # GNOME custom shortcuts
            SCHEMA="org.gnome.settings-daemon.plugins.media-keys"
            
            # Get current custom keybindings
            CUSTOM_KEYS=$(gsettings get $SCHEMA custom-keybindings)
            
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
        
        XFCE_CONFIG="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"
        
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
