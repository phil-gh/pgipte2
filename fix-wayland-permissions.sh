#!/bin/bash
# Fix Wayland/X11 permissions for robotjs

echo "================================================"
echo "Fixing robotjs Wayland/X11 Permissions"
echo "================================================"
echo ""

# Check current session type
SESSION_TYPE=${XDG_SESSION_TYPE:-unknown}
echo "Session type: $SESSION_TYPE"
echo ""

if [ "$SESSION_TYPE" = "wayland" ]; then
    echo "Running on Wayland..."
    echo ""
    
    # Option 1: Grant xhost permissions (temporary, for this session)
    echo "Option 1: Grant X11 access (temporary)"
    echo "This allows robotjs to control input via XWayland."
    echo ""
    read -p "Grant X11 access now? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        xhost +local:
        echo "✓ X11 access granted for local connections"
        echo "  This will reset on logout/reboot"
        echo ""
    fi
    
    echo "Option 2: Add to xinit/session startup (permanent)"
    echo "Add 'xhost +local:' to your session startup:"
    echo "  KDE: System Settings → Startup and Shutdown → Autostart"
    echo "  Or add to: ~/.config/plasma-workspace/env/xhost.sh"
    echo ""
    
    # Check if we should create autostart
    read -p "Create KDE autostart script? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p ~/.config/autostart-scripts
        cat > ~/.config/autostart-scripts/xhost-pgipte2.sh << 'EOF'
#!/bin/bash
# Allow local X11 connections for automation tools
xhost +local: 2>/dev/null
EOF
        chmod +x ~/.config/autostart-scripts/xhost-pgipte2.sh
        
        # Create desktop file
        mkdir -p ~/.config/autostart
        cat > ~/.config/autostart/xhost-pgipte2.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=PGIPTE2 X11 Permissions
Exec=/bin/bash -c "xhost +local: 2>/dev/null"
X-KDE-autostart-phase=1
EOF
        
        echo "✓ Created autostart script"
        echo "  Location: ~/.config/autostart-scripts/xhost-pgipte2.sh"
        echo "  Desktop entry: ~/.config/autostart/xhost-pgipte2.desktop"
        echo "  This will run on every login"
        echo ""
    fi
    
    echo "Option 3: Run with specific permissions"
    echo "You can also run the tool with xhost enabled just for that session:"
    echo "  xhost +local: && npm start"
    echo ""
    
else
    echo "Running on X11..."
    echo "You may still see authorization warnings."
    echo ""
    echo "Fix with:"
    echo "  xhost +local:"
    echo ""
fi

echo "================================================"
echo "Testing current permissions..."
echo "================================================"
echo ""

# Test if xhost is accessible
if command -v xhost &> /dev/null; then
    echo "Current xhost access control:"
    xhost 2>&1 | head -5
    echo ""
else
    echo "⚠️  xhost command not found"
    echo "Install with: sudo pacman -S xorg-xhost"
    echo ""
fi

echo "================================================"
echo "Recommendation"
echo "================================================"
echo ""
echo "For PGIPTE2 to work without popups:"
echo "1. Run: xhost +local:"
echo "2. Or add to KDE autostart (option above)"
echo "3. Then run: npm start"
echo ""
echo "Note: This only affects X11/XWayland access."
echo "      Your system security is not compromised."
echo ""
