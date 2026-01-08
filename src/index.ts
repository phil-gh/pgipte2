#!/usr/bin/env node

import { handlePercentageReduction, handleCurrencyConversion } from './actions.js';
import { showSettings } from './settings-ui.js';
import { configManager } from './config.js';

// Track if an action is currently running to prevent overlapping executions
let isProcessing = false;

async function safeExecute(fn: () => Promise<void>, name: string): Promise<void> {
  if (isProcessing) {
    console.log(`${name} skipped - another action is in progress`);
    return;
  }

  isProcessing = true;
  try {
    await fn();
  } catch (error) {
    console.error(`Error in ${name}:`, error);
  } finally {
    isProcessing = false;
  }
}

async function setupHotkeysLinux() {
  console.log('⚠️  Linux/Wayland Global Hotkey Limitation');
  console.log('═══════════════════════════════════════════\n');
  console.log('Global hotkeys on Wayland require system-level integration.');
  console.log('Please choose one of these options:\n');
  console.log('Option 1: Use your desktop environment\'s keyboard shortcuts:');
  console.log('  - Bind F2 to: node ~/src/pgipte2/dist/index.js --settings');
  console.log('  - Bind F3 to: node ~/src/pgipte2/dist/index.js --reduce');
  console.log('  - Bind F4 to: node ~/src/pgipte2/dist/index.js --convert\n');
  console.log('Option 2: Run on Windows (where PoE2 actually runs)\n');
  console.log('Option 3: Use X11 instead of Wayland\n');
  console.log('For now, you can test individual functions:\n');
  console.log('  npm start -- --settings   # Open settings');
  console.log('  npm start -- --reduce     # Test F3 reduction');
  console.log('  npm start -- --convert    # Test F4 conversion');
  console.log('');
  
  process.exit(1);
}

async function setupHotkeysWindows() {
  // Dynamic import only on Windows
  const { GlobalKeyboardListener } = await import('node-global-key-listener');
  
  const keyboard = new GlobalKeyboardListener();

  keyboard.addListener((event: any, down: any) => {
    // Only trigger on key down
    if (event.state !== 'DOWN') {
      return;
    }

    const key = event.name;

    switch (key) {
      case 'F2':
        safeExecute(showSettings, 'Settings');
        break;
      case 'F3':
        safeExecute(handlePercentageReduction, 'F3 - Percentage Reduction');
        break;
      case 'F4':
        safeExecute(handleCurrencyConversion, 'F4 - Currency Conversion');
        break;
    }
  });

  // Handle graceful shutdown
  process.on('SIGINT', () => {
    console.log('\n\nShutting down...');
    keyboard.kill();
    process.exit(0);
  });

  process.on('SIGTERM', () => {
    console.log('\n\nShutting down...');
    keyboard.kill();
    process.exit(0);
  });
}

async function main() {
  const args = process.argv.slice(2);
  
  // Handle command-line modes for Linux
  if (args.includes('--settings')) {
    await showSettings();
    process.exit(0);
  }
  
  if (args.includes('--reduce')) {
    console.log('Testing F3 - Percentage Reduction');
    console.log('Make sure your cursor is positioned correctly...');
    await new Promise(resolve => setTimeout(resolve, 2000));
    await handlePercentageReduction();
    process.exit(0);
  }
  
  if (args.includes('--convert')) {
    console.log('Testing F4 - Currency Conversion');
    console.log('Make sure your cursor is positioned correctly...');
    await new Promise(resolve => setTimeout(resolve, 2000));
    await handleCurrencyConversion();
    process.exit(0);
  }
  
  console.log('=================================');
  console.log('PGIPTE2 - PoE Price Tool');
  console.log('=================================');
  console.log('');
  console.log('Hotkeys:');
  console.log('  F2 - Settings');
  console.log('  F3 - Reduce price by percentage');
  console.log('  F4 - Convert currency');
  console.log('  Ctrl+C - Exit');
  console.log('');
  
  const config = configManager.getAll();
  console.log('Current configuration:');
  console.log(`  Reduction: ${config.percent}%`);
  console.log(`  Rate: ${config.rate}`);
  console.log('');

  // Platform-specific hotkey setup
  if (process.platform === 'win32') {
    console.log('Listening for hotkeys...\n');
    await setupHotkeysWindows();
  } else {
    await setupHotkeysLinux();
  }
}

// Start the application
main().catch(console.error);
