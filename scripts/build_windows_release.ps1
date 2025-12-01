# Windows Release Build Script for ConEdit
# This script builds a release version of ConEdit for Windows and packages it into a zip file

Write-Host "Building ConEdit for Windows Release..." -ForegroundColor Green

# Clean previous builds
Write-Host "Cleaning previous builds..." -ForegroundColor Yellow
flutter clean

# Get dependencies
Write-Host "Getting dependencies..." -ForegroundColor Yellow
flutter pub get

# Build Windows release
Write-Host "Building Windows release..." -ForegroundColor Yellow
flutter build windows --release

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

# Create release directory
$releaseDir = "release"
$buildDir = "build\windows\x64\runner\Release"
$zipName = "ConEdit-Windows-v1.0.1.zip"

if (Test-Path $releaseDir) {
    Remove-Item -Recurse -Force $releaseDir
}
New-Item -ItemType Directory -Path $releaseDir | Out-Null

Write-Host "Copying files to release directory..." -ForegroundColor Yellow

# Copy executable and required files
Copy-Item "$buildDir\con_edit.exe" -Destination "$releaseDir\ConEdit.exe"
Copy-Item "$buildDir\*.dll" -Destination $releaseDir
Copy-Item "$buildDir\data" -Destination $releaseDir -Recurse -ErrorAction SilentlyContinue

# Copy Flutter dependencies
if (Test-Path "$buildDir\flutter") {
    Copy-Item "$buildDir\flutter" -Destination $releaseDir -Recurse
}

# Create README for users
$readmeContent = @"
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
"@

Set-Content -Path "$releaseDir\README.txt" -Value $readmeContent

# Create zip file
Write-Host "Creating zip file..." -ForegroundColor Yellow
if (Test-Path $zipName) {
    Remove-Item $zipName
}

Compress-Archive -Path "$releaseDir\*" -DestinationPath $zipName -Force

Write-Host "`nBuild complete!" -ForegroundColor Green
Write-Host "Release package: $zipName" -ForegroundColor Cyan
Write-Host "Size: $((Get-Item $zipName).Length / 1MB) MB" -ForegroundColor Cyan

