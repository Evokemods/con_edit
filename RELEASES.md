# Release Builds

## Windows Release

To create a Windows release build, run:

**PowerShell:**
```powershell
.\scripts\build_windows_release.ps1
```

**Git Bash/WSL:**
```bash
chmod +x scripts/build_windows_release.sh
./scripts/build_windows_release.sh
```

This will create `ConEdit-Windows-v1.0.0.zip` containing:
- `ConEdit.exe` - The main executable
- All required DLL files
- Flutter runtime dependencies
- README.txt with usage instructions

The zip file is ready for distribution - users can simply extract and run!

## Version Numbering

Update the version in:
- `pubspec.yaml` - Update the version field
- `scripts/build_windows_release.ps1` - Update `$zipName` variable
- `scripts/build_windows_release.sh` - Update `ZIP_NAME` variable

## GitHub Releases

To publish a release:
1. Build the Windows release using the script above
2. Go to GitHub repository → Releases → Draft a new release
3. Tag the release (e.g., `v1.0.0`)
4. Upload `ConEdit-Windows-v1.0.0.zip` as an asset
5. Add release notes describing changes

