#!/usr/bin/env node

import { GlobalKeyboardListener } from 'node-global-key-listener';
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

function main() {
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
  console.log('Listening for hotkeys...\n');

  const keyboard = new GlobalKeyboardListener();

  keyboard.addListener((event, down) => {
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

// Start the application
main();
