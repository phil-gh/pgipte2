#!/usr/bin/env node

// Test if robotjs keyboard simulation works
import robot from '@jitsi/robotjs';
import clipboardy from 'clipboardy';

console.log('Testing robotjs keyboard/mouse functionality...\n');

// Test 1: Mouse click
console.log('Test 1: Mouse position');
const pos = robot.getMousePos();
console.log(`  Current mouse position: x=${pos.x}, y=${pos.y}`);

// Test 2: Write to clipboard directly
console.log('\nTest 2: Clipboard write');
await clipboardy.write('test-value-123');
const clipContent = await clipboardy.read();
console.log(`  Wrote and read: "${clipContent}"`);

// Test 3: Try keyboard simulation
console.log('\nTest 3: Keyboard simulation (Ctrl+C)');
console.log('  This will attempt to simulate Ctrl+C...');
console.log('  Note: On Wayland, keyboard simulation may not work!');

try {
    robot.keyTap('c', ['control']);
    console.log('  ✓ Command executed (but may not work on Wayland)');
} catch (error) {
    console.log(`  ✗ Error: ${error.message}`);
}

// Test 4: Check platform
console.log('\nTest 4: Platform info');
console.log(`  Platform: ${process.platform}`);
console.log(`  Display: ${process.env.DISPLAY || 'not set'}`);
console.log(`  Wayland: ${process.env.WAYLAND_DISPLAY || 'not set'}`);
console.log(`  XDG_SESSION_TYPE: ${process.env.XDG_SESSION_TYPE || 'not set'}`);

console.log('\n⚠️  Important:');
console.log('On Wayland, robotjs keyboard simulation does NOT work.');
console.log('Mouse clicks work, but Ctrl+C/Ctrl+V do not.');
console.log('\nThis tool requires X11 or Windows for full functionality.');
