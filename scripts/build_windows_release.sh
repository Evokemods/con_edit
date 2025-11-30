#!/bin/bash
# Windows Release Build Script for ConEdit (for Git Bash/WSL)
# This script builds a release version of ConEdit for Windows and packages it into a zip file

echo "Building ConEdit for Windows Release..."

# Clean previous builds
echo "Cleaning previous builds..."
flutter clean

# Get dependencies
echo "Getting dependencies..."
flutter pub get

# Build Windows release
echo "Building Windows release..."
flutter build windows --release

if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

# Create release directory
RELEASE_DIR="release"
BUILD_DIR="build/windows/x64/runner/Release"
ZIP_NAME="ConEdit-Windows-v1.0.0.zip"

rm -rf "$RELEASE_DIR"
mkdir -p "$RELEASE_DIR"

echo "Copying files to release directory..."

# Copy executable and required files
cp "$BUILD_DIR/con_edit.exe" "$RELEASE_DIR/ConEdit.exe"
cp "$BUILD_DIR"/*.dll "$RELEASE_DIR/" 2>/dev/null || true
cp -r "$BUILD_DIR/data" "$RELEASE_DIR/" 2>/dev/null || true

# Copy Flutter dependencies
if [ -d "$BUILD_DIR/flutter" ]; then
    cp -r "$BUILD_DIR/flutter" "$RELEASE_DIR/"
fi

# Create README for users
cat > "$RELEASE_DIR/README.txt" << 'EOF'
ConEdit - Rust Plugin Config Editor
===================================

INSTALLATION:
1. Extract this zip file to any folder
2. Double-click ConEdit.exe to run

SYSTEM REQUIREMENTS:
- Windows 10 or later
- No additional software required (all dependencies included)

USAGE:
1. Click the folder icon or press Ctrl+O to open a JSON config file
2. Edit your configuration using the intuitive interface
3. Press Ctrl+S or click the save icon to save your changes

KEYBOARD SHORTCUTS:
- Ctrl+O: Open file
- Ctrl+S: Save file
- Ctrl+Z: Undo
- Ctrl+Y: Redo
- Ctrl+F: Search

For more information, visit: https://github.com/Evokemods/con_edit

Enjoy editing your Rust plugin configs!
EOF

# Create zip file
echo "Creating zip file..."
rm -f "$ZIP_NAME"
cd "$RELEASE_DIR"
zip -r "../$ZIP_NAME" .
cd ..

echo ""
echo "Build complete!"
echo "Release package: $ZIP_NAME"
echo "Size: $(du -h "$ZIP_NAME" | cut -f1)"

