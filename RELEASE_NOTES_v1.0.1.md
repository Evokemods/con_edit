# ConEdit v1.0.1 Release Notes

## 🎉 New Features

### Folder Picker for Config Analysis & Training
- **Analyze Configs** and **Train on Configs** now prompt you to select a folder
- No more hardcoded paths - choose your config directory dynamically
- Better flexibility when working with multiple config directories

## ✨ Improvements

### Code Quality & Performance
- Fixed all Flutter analyzer issues
- Improved widget performance with proper const usage
- Replaced Container with DecoratedBox where appropriate for better rendering
- Code now follows Flutter best practices

### User Experience
- Enhanced validation feedback with visual indicators
- Improved widget selection and metadata handling
- Better error handling and user feedback

## 🔧 Technical Changes

- Added `pickDirectory()` method to FileDialogService
- Updated config analysis and training handlers to use folder picker
- Fixed linter warnings across multiple files
- Added new widgets: image preview, Rust item autocomplete, expandable help card

## 📦 Files Changed

- Modified: 10 files
- Added: 3 new widget files
- Total: 13 files changed, 2005 insertions, 66 deletions

## 🚀 Installation

Download the latest release from the [Releases page](https://github.com/Evokemods/con_edit/releases).

---

**Full Changelog**: https://github.com/Evokemods/con_edit/compare/v1.0.0...v1.0.1

