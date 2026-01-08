#!/usr/bin/env node

// Simple test for price parsing
import { parsePrice } from './dist/clipboard.js';

console.log('Testing price parsing...\n');

const tests = [
  { input: '100', expected: 100 },
  { input: '100.5', expected: 100.5 },
  { input: '100,5', expected: 100.5 },
  { input: '1234', expected: 1234 },
  { input: '1234.56', expected: 1234.56 },
  { input: '1234,56', expected: 1234.56 },
  { input: '  42  ', expected: 42 },
  { input: 'invalid', expected: null },
  { input: '12.34.56', expected: null },
  { input: '', expected: null },
  { input: 'abc123', expected: null },
];

let passed = 0;
let failed = 0;

tests.forEach(test => {
  const result = parsePrice(test.input);
  const success = result === test.expected;
  
  if (success) {
    passed++;
    console.log(`✓ "${test.input}" → ${result}`);
  } else {
    failed++;
    console.log(`✗ "${test.input}" → ${result} (expected ${test.expected})`);
  }
});

console.log(`\n${passed} passed, ${failed} failed`);
process.exit(failed > 0 ? 1 : 0);
