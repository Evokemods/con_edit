I want to build a Flutter desktop application that acts as a universal config editor for Rust game plugin JSON files. The app should:

1. Parse any JSON config into a generic tree structure (objects, arrays, values).
2. Dynamically render a modern UI based on the tree structure, mapping types to reusable base widgets:
- Numbers → numeric input or slider with validation
- Booleans → switches
- Strings (single-line) → text fields
- Strings (multi-line) → multi-line text areas / rich text
- Dropdowns / enums → dropdowns or autocomplete
- Arrays of simple values → list editor with add/remove
- Arrays of objects → table or list-of-cards editor
- Nested objects → collapsible sections or panels
- Vector3 / coordinates → 3-number input fields, optionally visualized on canvas
- Spatial / visual data (spawn points, anchors, zones) → canvas/map editor with drag-and-drop
- Conditional fields → dynamically show/hide based on other values
- Presets/templates → preset selector with apply functionality
- Metadata-driven hints → tooltips, inline help, min/max/recommended values
- External references (item IDs, prefabs, loot tables) → autocomplete + validation + optional image previews
3. Include a metadata system that is stored externally and extendable, providing:
- Descriptions, tooltips, hints
- Valid types, ranges, allowed values
- Autocomplete sources and images
- Optional plugin-specific overrides
4. Support plugin-specific custom editors by composing base widgets, so known configs (Skills, LootTables, NPCs, UI panels, etc.) get rich editing while unknown configs still render generically.
5. Implement a fallback renderer for unknown configs using only base widgets and metadata.
6. Save and optionally learn metadata so the editor improves over time for repeated or similar configs.
7. Provide a modular, maintainable, and scalable architecture ready for new plugins and question types without rewriting core logic.

Additionally:
- Include file open/save dialogs with proper error handling and support for both manual and auto-save
- Implement undo/redo functionality using a command pattern
- Add search/filter capability for navigating large configs with breadcrumb navigation
- Support keyboard shortcuts for common operations (Ctrl+S save, Ctrl+Z undo, Ctrl+Y redo, Ctrl+F search, Ctrl+O open, etc.)
- Implement light/dark theme support with system preference detection
- Store metadata in separate `.metadata.json` files alongside each config, with a global metadata repository for learned patterns
- Include validation that shows inline errors when values don't match metadata constraints
- Handle malformed JSON gracefully with clear error messages and recovery suggestions
- Remember window size/position between sessions using local storage
- Support multiple open configs with tabs or split view
- Target: Windows, macOS, and Linux desktop platforms
- Metadata file format: JSON
- Include version compatibility tracking in metadata files

Self-Learning & Intelligence Features:
- Implement a pattern recognition system that analyzes loaded configs to identify:
- Common field naming conventions (e.g., "damage", "cooldown", "position")
- Value ranges and typical patterns (min/max values, common enums)
- Structural patterns (configs that always have certain fields together)
- Relationship patterns (fields that correlate with each other)
- Build a local knowledge base that accumulates metadata from all opened configs:
- Track field frequency and usage patterns
- Infer data types and constraints from actual values
- Suggest metadata for unknown fields based on similar fields in other configs
- Store confidence scores for inferred metadata
- Include optional online documentation lookup:
- Allow users to configure documentation URLs for specific plugins (e.g., plugin GitHub repos, wikis)
- Scrape README files, wiki pages, or API docs when loading a new config
- Parse documentation for field descriptions, valid values, and examples
- Cache documentation locally with refresh capability
- Support multiple documentation sources per plugin
- Implement smart suggestions:
- When encountering an unknown field, suggest metadata based on name similarity to known fields
- Offer to apply learned patterns to similar configs
- Provide "Did you mean?" suggestions for enum values based on learned patterns
- Auto-complete suggestions that improve with usage
- Include a metadata review UI:
- Show confidence levels for inferred metadata
- Allow users to approve/reject/modify learned patterns
- Bulk apply learned metadata to multiple configs
- Export learned metadata as shareable templates
- Add feedback loop:
- Track which inferred metadata users accept or modify
- Use acceptance/rejection data to improve future pattern recognition
- Learn from user corrections to refine suggestions

Generate:

- The Flutter project folder structure
- Core classes for parsing JSON into a generic config tree (ConfigNode)
- Metadata schema definition and storage plan with confidence scoring
- Pattern recognition engine for analyzing configs
- Knowledge base system with SQLite or similar for storing learned patterns
- Documentation fetcher service with caching
- Base reusable widgets
- Dynamic UI renderer scaffold
- State management setup (preferably using Riverpod)
- Integration pattern for merging metadata with the config tree and choosing widgets
- Support for plugin-specific overrides and canvas/visual editors
- Command pattern implementation for undo/redo
- File handling service with dialogs
- Settings persistence service
- Keyboard shortcut handling
- Metadata suggestion and review UI components

Do not include example config data or fake items; keep everything fully generic, clean, and ready for real use.