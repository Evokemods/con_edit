# ConEdit

A powerful, user-friendly configuration editor for Rust game server plugin JSON files. ConEdit provides an intuitive interface for editing plugin configurations with intelligent field detection, contextual help, and pattern recognition.

## Features

- **Intelligent Field Detection**: Automatically detects field types and suggests appropriate input widgets
- **Contextual Help**: Built-in documentation and tooltips for common Rust/Oxide plugin fields
- **Plugin-Specific Support**: Enhanced help for 20+ popular plugins including Skills, Economics, Shop, and more
- **Color Picker**: Visual color picker for hex color fields
- **Smart Array Editing**: Specialized widgets for editing arrays of strings, numbers, and objects
- **Pattern Learning**: Train the system on your config files to improve field recognition
- **Page-Based Navigation**: Organized multi-page editor for complex configurations
- **Undo/Redo**: Full command history support
- **Search**: Quick search across configuration fields

## Supported Plugins

ConEdit includes enhanced support for:

- Skills (OPSkill)
- Economics
- Shop
- BankSystem
- EpicLoot
- BetterTeams
- AdminMenu
- TruePVE
- StackSizeController
- VirtualQuarries
- FurnaceUpgrades
- MonumentPlus
- BetterTC
- IQChat
- ImageLibrary
- ZombieHorde
- AbsolutSorter
- Hud
- Vanish
- Whitelist

And many more through pattern recognition!

## Getting Started

### Quick Start (Windows Users)

**Download the latest release:**
1. Go to [Releases](https://github.com/Evokemods/con_edit/releases)
2. Download `ConEdit-Windows-v1.0.0.zip`
3. Extract the zip file to any folder
4. Double-click `ConEdit.exe` to run

No installation required! All dependencies are included.

### Building from Source

#### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK (3.9.2 or higher)

#### Installation

1. Clone the repository:
```bash
git clone https://github.com/Evokemods/con_edit.git
cd con_edit
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

#### Building Windows Release

To create a distributable Windows build:

**Using PowerShell:**
```powershell
.\scripts\build_windows_release.ps1
```

**Using Git Bash/WSL:**
```bash
chmod +x scripts/build_windows_release.sh
./scripts/build_windows_release.sh
```

This will create `ConEdit-Windows-v1.0.0.zip` in the project root, ready for distribution.

### Training on Your Configs

To improve field recognition and help, you can train the system on your config files:

1. Place your plugin JSON config files in the `config/` directory
2. Click the training icon (school icon) in the app bar
3. The system will analyze all configs and learn patterns

Alternatively, use the command-line tool:
```bash
dart run bin/train_configs.dart config
```

## Usage

1. **Open a Config File**: Click the folder icon or press `Ctrl+O` to open a JSON config file
2. **Navigate Pages**: Use the sidebar to navigate between configuration pages
3. **Edit Fields**: Click on any field to edit it. The editor will suggest appropriate widgets based on field type
4. **Get Help**: Hover over fields to see contextual help and examples
5. **Save**: Press `Ctrl+S` or click the save icon to save your changes

## Keyboard Shortcuts

- `Ctrl+O` - Open file
- `Ctrl+S` - Save file
- `Ctrl+Z` - Undo
- `Ctrl+Y` - Redo
- `Ctrl+F` - Search

## Project Structure

```
lib/
├── core/                    # Core utilities, theme, database
├── features/
│   ├── config_editor/      # Main config editing functionality
│   ├── metadata_management/ # Field metadata and help system
│   ├── pattern_recognition/ # Pattern learning and recognition
│   ├── file_management/     # File I/O operations
│   └── settings/            # Application settings
bin/
└── train_configs.dart       # Training script for config analysis
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with [Flutter](https://flutter.dev/)
- Uses [Drift](https://drift.simonbinder.eu/) for database management
- Inspired by the Rust/Oxide plugin ecosystem
