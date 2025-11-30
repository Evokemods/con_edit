/// Knowledge base for common Rust/Oxide plugin configuration fields.
///
/// Provides contextual help, descriptions, and examples for fields commonly
/// found in Rust plugin configurations. Based on documentation from:
/// - Corrosion Hour (corrosionhour.com)
/// - uMod/Oxide documentation (umod.org)
/// - Rust Wiki (wiki.facepunch.com)
class RustFieldKnowledgeBase {
  RustFieldKnowledgeBase._();

  /// Map of field name patterns to their descriptions and help text.
  static final Map<String, FieldHelpInfo> _fieldPatterns = <String, FieldHelpInfo>{
    // Item/Shortname fields
    'shortname': const FieldHelpInfo(
      description: 'Item shortname identifier',
      tooltip:
          'The unique shortname for a Rust item (e.g., "rifle.ak", "campfire", "wood"). '
          'Shortnames are used in commands and configurations. '
          'Find items at: corrosionhour.com/rust-items-database',
      examples: <String>['rifle.ak', 'campfire', 'wood', 'stones', 'metal.refined'],
      documentationUrl: 'https://www.corrosionhour.com/rust-items-database/',
    ),

    'shortnames': const FieldHelpInfo(
      description: 'List of item shortname identifiers',
      tooltip:
          'Array of item shortnames. Each shortname uniquely identifies a Rust item. '
          'Example: ["rifle.ak", "campfire", "wood"]',
      examples: <String>['rifle.ak', 'campfire', 'wood'],
    ),

    'item': const FieldHelpInfo(
      description: 'Item identifier (shortname)',
      tooltip:
          'The shortname of a Rust item. Shortnames are lowercase identifiers '
          'with dots or underscores (e.g., "rifle.ak", "box.wooden.large").',
      examples: <String>['rifle.ak', 'campfire', 'wood'],
    ),

    'items': const FieldHelpInfo(
      description: 'List of item identifiers',
      tooltip: 'Array of item shortnames. Each entry should be a valid Rust item shortname.',
      examples: <String>['rifle.ak', 'campfire'],
    ),

    // Prefab fields
    'prefab': const FieldHelpInfo(
      description: 'Prefab path identifier',
      tooltip:
          'The full prefab path for a Rust entity (e.g., "assets/prefabs/npc/patrol helicopter/heli_crate.prefab"). '
          'Prefabs define deployable objects, NPCs, and world entities. '
          'Common paths: assets/prefabs/, assets/bundled/prefabs/',
      examples: <String>[
        'assets/prefabs/npc/patrol helicopter/heli_crate.prefab',
        'assets/bundled/prefabs/radtown/crate_elite.prefab',
        'assets/prefabs/deployable/campfire/campfire.prefab',
      ],
      documentationUrl: 'https://wiki.facepunch.com/rust/Prefabs',
    ),

    'prefabs': const FieldHelpInfo(
      description: 'List of prefab paths',
      tooltip:
          'Array of prefab paths. Each path points to a Rust entity prefab file. '
          'Prefabs are located in assets/prefabs/ or assets/bundled/prefabs/',
      examples: <String>[
        'assets/prefabs/npc/patrol helicopter/heli_crate.prefab',
      ],
    ),

    // Type fields
    'type': const FieldHelpInfo(
      description: 'Entity or item type identifier',
      tooltip:
          'The type classification for an entity or item. Can be: '
          'ItemDefinition (for items), BaseEntity (for deployables), '
          'or specific entity types. Often used with shortname or prefab.',
      examples: <String>['ItemDefinition', 'BaseEntity', 'BasePlayer'],
      documentationUrl: 'https://umod.org/documentation/rust',
    ),

    'types': const FieldHelpInfo(
      description: 'List of type identifiers',
      tooltip: 'Array of type classifications for entities or items.',
      examples: <String>['ItemDefinition', 'BaseEntity'],
    ),

    // Permission fields
    'permission': const FieldHelpInfo(
      description: 'Permission node identifier',
      tooltip:
          'A permission node string (e.g., "pluginname.use", "pluginname.admin"). '
          'Permissions control access to plugin features. '
          'Format: usually "pluginname.action" or "pluginname.feature"',
      examples: <String>['pluginname.use', 'pluginname.admin', 'betterteams.marker'],
      documentationUrl: 'https://umod.org/guides/the-basics/permissions',
    ),

    'permissions': const FieldHelpInfo(
      description: 'List of permission nodes',
      tooltip: 'Array of permission node strings. Each permission controls access to specific features.',
      examples: <String>['pluginname.use', 'pluginname.admin'],
    ),

    // Command fields
    'command': const FieldHelpInfo(
      description: 'Chat command identifier',
      tooltip:
          'A chat command that players can type (e.g., "/shop", "/bank", "/home"). '
          'Commands usually start with "/" and are case-insensitive. '
          'See: umod.org/guides/the-basics/commands',
      examples: <String>['/shop', '/bank', '/home', '/tp'],
      documentationUrl: 'https://umod.org/guides/the-basics/commands',
    ),

    'commands': const FieldHelpInfo(
      description: 'List of chat commands',
      tooltip:
          'Array of chat command strings. Players can use these commands in-game. '
          'Commands typically start with "/" (e.g., ["/shop", "/bank"]).',
      examples: <String>['/shop', '/bank'],
    ),

    // Skin fields
    'skin': const FieldHelpInfo(
      description: 'Item skin ID',
      tooltip:
          'The numeric skin ID for an item. Skins change the appearance of items. '
          'Skin ID 0 means default/no skin. Find skins at: steamcommunity.com/market',
      examples: <String>['0', '13076', '10135'],
      documentationUrl: 'https://steamcommunity.com/market/search?appid=252490',
    ),

    'skins': const FieldHelpInfo(
      description: 'List of skin IDs',
      tooltip: 'Array of numeric skin IDs. Each ID corresponds to a specific item skin.',
      examples: <String>['0', '13076', '10135'],
    ),

    'skin id': const FieldHelpInfo(
      description: 'Item skin identifier',
      tooltip:
          'Numeric identifier for an item skin. 0 = default skin. '
          'Higher numbers are workshop skins from Steam.',
      examples: <String>['0', '13076'],
    ),

    // Category fields
    'category': const FieldHelpInfo(
      description: 'Item category classification',
      tooltip:
          'The category an item belongs to (e.g., "Weapon", "Resource", "Medical", "Food", "Construction"). '
          'Common categories: Weapon, Resource, Medical, Food, Construction, Tool, Attire, Ammunition',
      examples: <String>['Weapon', 'Resource', 'Medical', 'Food', 'Construction'],
    ),

    'categories': const FieldHelpInfo(
      description: 'List of item categories',
      tooltip: 'Array of category names. Used to group items by type.',
      examples: <String>['Weapon', 'Resource', 'Medical'],
    ),

    // Chance/Probability fields
    'chance': const FieldHelpInfo(
      description: 'Probability percentage (0-100)',
      tooltip:
          'A percentage value representing probability (0-100). '
          '0 = never happens, 100 = always happens. '
          'Can be a decimal (e.g., 12.5 for 12.5% chance).',
      examples: <String>['0', '50', '100', '12.5'],
    ),

    'drop_weight': const FieldHelpInfo(
      description: 'Drop weight for loot tables',
      tooltip:
          'Relative weight for item drops in loot tables. Higher values = more likely to drop. '
          'Used in weighted random selection. Not a percentage.',
      examples: <String>['1', '10', '100', '1000'],
    ),

    // Quantity fields
    'quantity': const FieldHelpInfo(
      description: 'Item quantity or amount',
      tooltip: 'The number of items. Can be a whole number or decimal depending on item type.',
      examples: <String>['1', '10', '100', '250'],
    ),

    'min_quantity': const FieldHelpInfo(
      description: 'Minimum item quantity',
      tooltip: 'The minimum number of items that can be given/spawned.',
      examples: <String>['1', '10'],
    ),

    'max_quantity': const FieldHelpInfo(
      description: 'Maximum item quantity',
      tooltip: 'The maximum number of items that can be given/spawned.',
      examples: <String>['10', '100', '250'],
    ),

    // Name/Display fields
    'name': const FieldHelpInfo(
      description: 'Display name or identifier',
      tooltip:
          'A human-readable name. Can be an item display name, player name, or custom identifier. '
          'For items, this is usually the display name shown to players.',
      examples: <String>['Assault Rifle', 'Camp Fire', 'Wood'],
    ),

    'display name': const FieldHelpInfo(
      description: 'Item display name',
      tooltip:
          'The name shown to players in-game. Different from shortname which is the identifier. '
          'Example: shortname "rifle.ak" has display name "Assault Rifle".',
      examples: <String>['Assault Rifle', 'Camp Fire', 'Wood'],
    ),

    // URL/Image fields
    'url': const FieldHelpInfo(
      description: 'Web URL or image URL',
      tooltip:
          'A web URL, typically for images, API endpoints, or external resources. '
          'Common formats: https://example.com/image.png or http://example.com/api',
      examples: <String>[
        'https://i.ibb.co/wBn7JzM/image.png',
        'https://example.com/api',
      ],
    ),

    'image url': const FieldHelpInfo(
      description: 'Image URL for display',
      tooltip:
          'URL to an image file (PNG, JPG, etc.). Used for UI elements, item previews, or notifications. '
          'Should be a publicly accessible URL.',
      examples: <String>['https://i.ibb.co/wBn7JzM/image.png'],
    ),

    // Hook fields
    'hook': const FieldHelpInfo(
      description: 'Plugin hook identifier',
      tooltip:
          'A hook name that connects to other plugins or game events. '
          'Hooks allow plugins to interact with each other. '
          'Format: usually "PluginName.HookName" or just "HookName"',
      examples: <String>['Deposit', 'Withdraw', 'Balance'],
      documentationUrl: 'https://umod.org/documentation/rust/hooks',
    ),

    'hooks': const FieldHelpInfo(
      description: 'List of hook identifiers',
      tooltip: 'Array of hook names for plugin integration.',
      examples: <String>['Deposit', 'Withdraw'],
    ),

    // Version fields (read-only)
    'version': const FieldHelpInfo(
      description: 'Plugin version (read-only)',
      tooltip:
          'The plugin version number. This is set by the developer and should not be edited. '
          'Format: Major.Minor.Patch (e.g., 2.0.31)',
      examples: <String>['2.0.31', '1.5.0'],
      isReadOnly: true,
    ),

    // Cost/Price fields
    'cost': const FieldHelpInfo(
      description: 'Purchase or unlock cost',
      tooltip:
          'The price or cost to purchase/unlock something. '
          'Uses the economy system (currency, plugin economy, etc.). '
          'Can be a number (scrap amount) or economy points.',
      examples: <String>['1000', '5000', '10000'],
    ),

    'price': const FieldHelpInfo(
      description: 'Item or service price',
      tooltip:
          'The price players pay for items or services. '
          'Buy prices are typically higher than sell prices. '
          'Uses configured economy system.',
      examples: <String>['100', '500', '1000'],
    ),

    // Value fields
    'value': const FieldHelpInfo(
      description: 'Effect or modifier value',
      tooltip:
          'A numeric value representing an effect, multiplier, or modifier. '
          'Meaning depends on context (skill effect, price modifier, etc.). '
          'Can be percentage, multiplier, or absolute value.',
      examples: <String>['1.0', '10.0', '100.0', '200.0'],
    ),

    'value 2': const FieldHelpInfo(
      description: 'Secondary effect value',
      tooltip:
          'Optional secondary effect or modifier value. '
          'Used when there are multiple effects. '
          'Set to 0.0 if not used.',
      examples: <String>['0.0', '10.0'],
    ),

    // Enabled fields
    'enabled': const FieldHelpInfo(
      description: 'Enable or disable feature',
      tooltip:
          'If true, this feature/item/skill is active and available. '
          'If false, it is disabled and hidden from players.',
      examples: <String>['true', 'false'],
    ),

    // Groups fields
    'groups': const FieldHelpInfo(
      description: 'Permission groups',
      tooltip:
          'List of permission groups that have access or are affected. '
          'Groups are defined in Oxide/ServerRewards. '
          'Example: ["vip", "premium"]',
      examples: <String>['["vip"]', '["vip", "premium"]', '[]'],
    ),

    // Localization fields
    'localization': const FieldHelpInfo(
      description: 'Localized text translations',
      tooltip:
          'Text translations for different languages. '
          'Format: {"en": "English text", "fr": "French text"}. '
          'Used with LangAPI plugin for multi-language support.',
      examples: <String>['{"en": "Balance", "fr": "Solde"}'],
    ),

    // Image Key
    'image key': const FieldHelpInfo(
      description: 'Image identifier key',
      tooltip:
          'A key/identifier for an image in the ImageLibrary plugin. '
          'Used to reference pre-loaded images. '
          'Example: "warning", "success", "error"',
      examples: <String>['warning', 'success', 'error', 'info'],
    ),

    // Blacklist fields
    'blacklist': const FieldHelpInfo(
      description: 'List of blocked items/entities',
      tooltip:
          'Array of item shortnames, prefabs, or entities that are blocked/disabled. '
          'Items in blacklist cannot be used/affected by the plugin feature.',
      examples: <String>['["keycard_blue", "keycard_red"]', '[]'],
    ),

    'whitelist': const FieldHelpInfo(
      description: 'List of allowed items/entities',
      tooltip:
          'Array of item shortnames, prefabs, or entities that are allowed. '
          'Only items in whitelist can be used/affected. '
          'Empty array = all items allowed.',
      examples: <String>['["rifle.ak", "campfire"]', '[]'],
    ),

    // UI Layout fields
    'offset': const FieldHelpInfo(
      description: 'UI element position offset',
      tooltip:
          'Distance in pixels to offset a UI element from its default position. '
          'Can be horizontal (X) or vertical (Y) offset. '
          'Positive values move right/down, negative move left/up.',
      examples: <String>['0.0', '5.0', '10.0', '-5.0'],
    ),

    'margin': const FieldHelpInfo(
      description: 'Spacing between UI elements',
      tooltip:
          'Space in pixels between UI elements or around content. '
          'Larger margins = more spacing. '
          'Used for card spacing, button gaps, etc.',
      examples: <String>['0.0', '5.0', '10.0'],
    ),

    'size': const FieldHelpInfo(
      description: 'UI element size',
      tooltip:
          'Size of a UI element in pixels. Can be width, height, or both. '
          'Larger values = bigger elements. '
          'Example: 60.0 = 60 pixels wide/tall.',
      examples: <String>['30.0', '60.0', '120.0', '180.0'],
    ),

    'scale': const FieldHelpInfo(
      description: 'UI scale multiplier',
      tooltip:
          'Multiplier for UI element size. '
          '• 1.0 = normal size (100%)\n'
          '• 2.0 = double size (200%)\n'
          '• 0.5 = half size (50%)\n\n'
          'Affects all UI elements proportionally.',
      examples: <String>['0.5', '1.0', '1.5', '2.0'],
    ),

    // Anchor fields (UI positioning)
    'anchormin': const FieldHelpInfo(
      description: 'UI anchor minimum position',
      tooltip:
          'Bottom-left anchor point for UI element (0-1 range). '
          'Format: "X Y" where X and Y are 0.0 to 1.0. '
          'Example: "0 0" = bottom-left, "0.5 0.5" = center.',
      examples: <String>['0 0', '0.5 0.5', '0 1'],
    ),

    'anchormax': const FieldHelpInfo(
      description: 'UI anchor maximum position',
      tooltip:
          'Top-right anchor point for UI element (0-1 range). '
          'Format: "X Y" where X and Y are 0.0 to 1.0. '
          'Example: "1 1" = top-right, "0.5 0.5" = center point.',
      examples: <String>['1 1', '0.5 0.5', '1 0'],
    ),

    // Font fields
    'font': const FieldHelpInfo(
      description: 'Font file name',
      tooltip:
          'Name of the font file to use for text. '
          'Font files must be in the plugin\'s font directory. '
          'Example: "robotocondensed-bold.ttf"',
      examples: <String>['robotocondensed-bold.ttf', 'arial.ttf'],
    ),

    'align': const FieldHelpInfo(
      description: 'Text alignment',
      tooltip:
          'How text is aligned within its container. '
          'Common values:\n'
          '• "MiddleCenter" - Centered horizontally and vertically\n'
          '• "UpperLeft" - Top-left corner\n'
          '• "LowerRight" - Bottom-right corner\n\n'
          'Format: VerticalHorizontal (e.g., MiddleCenter).',
      examples: <String>['MiddleCenter', 'UpperLeft', 'LowerRight'],
    ),

    // Multiplier fields
    'multiplier': const FieldHelpInfo(
      description: 'Effect multiplier',
      tooltip:
          'A multiplier that affects rates, speeds, or amounts. '
          '• 1.0 = normal (100%, no change)\n'
          '• 2.0 = double (200%, 2x effect)\n'
          '• 0.5 = half (50%, 0.5x effect)\n\n'
          'Used for gathering rates, craft speeds, etc.',
      examples: <String>['0.5', '1.0', '2.0', '5.0'],
    ),
  };

  /// Gets help information for a field name.
  ///
  /// Checks for exact matches and partial matches (case-insensitive).
  static FieldHelpInfo? getHelpForField(String? fieldName) {
    if (fieldName == null) return null;

    final String lowerFieldName = fieldName.toLowerCase().trim();

    // Try exact match first
    if (_fieldPatterns.containsKey(lowerFieldName)) {
      return _fieldPatterns[lowerFieldName];
    }

    // Try partial match (field name contains the pattern)
    for (final MapEntry<String, FieldHelpInfo> entry in _fieldPatterns.entries) {
      if (lowerFieldName.contains(entry.key) || entry.key.contains(lowerFieldName)) {
        return entry.value;
      }
    }

    return null;
  }

  /// Gets all known field patterns.
  static Map<String, FieldHelpInfo> getAllPatterns() => Map<String, FieldHelpInfo>.from(_fieldPatterns);
}

/// Help information for a field.
class FieldHelpInfo {
  /// Creates new field help information.
  const FieldHelpInfo({
    required this.description,
    this.tooltip,
    this.examples = const <String>[],
    this.documentationUrl,
    this.isReadOnly = false,
  });

  /// Short description of the field.
  final String description;

  /// Detailed tooltip/help text.
  final String? tooltip;

  /// Example values for this field.
  final List<String> examples;

  /// URL to relevant documentation.
  final String? documentationUrl;

  /// Whether this field should be read-only.
  final bool isReadOnly;

  /// Gets formatted examples as a string.
  String get examplesText {
    if (examples.isEmpty) return '';
    if (examples.length == 1) return 'Example: ${examples.first}';
    return 'Examples: ${examples.join(', ')}';
  }
}

