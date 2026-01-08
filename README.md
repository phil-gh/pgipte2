# PGIPTE2 - Path of Exile 2 Price Tool

A TypeScript rewrite of the PoE price reduction tool, providing automated price management for Path of Exile 2 trading.

## Features

- **F3**: Percentage-based price reduction
- **F4**: Currency conversion with automatic UI navigation
- **F2**: Settings configuration

## Installation

```bash
npm install
```

## Usage

### Development
```bash
npm run dev
```

### Build
```bash
npm run build
npm start
```

## Configuration

Settings are stored in a JSON configuration file with the following options:
- `percent`: Percentage to reduce prices by (default: 10)
- `rate`: Currency conversion rate (default: 130)

## Hotkeys

- **F2**: Open settings
- **F3**: Reduce price by configured percentage
- **F4**: Convert currency and navigate UI

## Requirements

- Node.js 18+
- Windows/Linux/macOS (tested primarily on Windows for PoE2)

## Original Project

Based on [pgipte](https://github.com/phil-gh/pgipte) by phil-gh
