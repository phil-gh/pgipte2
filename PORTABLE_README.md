# Building Standalone Executable

## Build Command

```cmd
npm run package
```

This will create a standalone `pgipte2.exe` file (~41 MB) that includes:
- Node.js runtime
- TypeScript executor (tsx)
- All dependencies
- Application source code

## What the Build Does

1. Removes Mac binaries from node-global-key-listener (incompatible with caxa)
2. Removes any existing pgipte2.exe
3. Uses caxa to bundle everything into a single executable

## Requirements

- All npm dependencies must be installed (`npm install`)
- tsx must be in regular dependencies (not devDependencies)

## Technical Notes

The executable is built with [caxa](https://github.com/leafac/caxa), which:
- Creates a self-extracting archive
- Extracts to temp directory on first run
- Includes the full Node.js runtime
- Supports native modules (like robotjs)
