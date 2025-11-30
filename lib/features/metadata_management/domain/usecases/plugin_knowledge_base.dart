import 'rust_field_knowledge_base.dart';

/// Plugin-specific knowledge base for enhanced field help.
///
/// Provides detailed, plugin-specific help for configuration fields
/// based on actual plugin documentation and config analysis.
class PluginKnowledgeBase {
  PluginKnowledgeBase._();

  /// Gets plugin-specific help for a field.
  ///
  /// Returns enhanced help information if available for the specific plugin,
  /// otherwise falls back to generic Rust field knowledge.
  static FieldHelpInfo? getPluginSpecificHelp(
    String? pluginName,
    String? fieldName,
    String? fieldPath,
  ) {
    if (pluginName == null || fieldName == null) {
      return null;
    }

    final String lowerPluginName = pluginName.toLowerCase();
    final String lowerFieldName = fieldName.toLowerCase();
    final String lowerFieldPath = (fieldPath ?? '').toLowerCase();

    // OPSkill / Skills plugin
    if (lowerPluginName.contains('skill') || lowerPluginName == 'opskill') {
      return _getSkillPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // Shop plugin
    if (lowerPluginName == 'shop') {
      return _getShopPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // BankSystem plugin
    if (lowerPluginName.contains('bank')) {
      return _getBankPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // EpicLoot plugin
    if (lowerPluginName.contains('epic') || lowerPluginName.contains('loot')) {
      return _getEpicLootPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // Hud plugin
    if (lowerPluginName == 'hud') {
      return _getHudPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // Economics plugin
    if (lowerPluginName.contains('economic')) {
      return _getEconomicsPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // BetterTeams plugin
    if (lowerPluginName.contains('team')) {
      return _getBetterTeamsPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // AdminMenu plugin
    if (lowerPluginName.contains('admin') && lowerPluginName.contains('menu')) {
      return _getAdminMenuPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // TruePVE plugin
    if (lowerPluginName.contains('pve') || lowerPluginName.contains('truepve')) {
      return _getTruePVEPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // Vanish plugin
    if (lowerPluginName == 'vanish') {
      return _getVanishPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // Whitelist plugin
    if (lowerPluginName == 'whitelist') {
      return _getWhitelistPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // StackSizeController plugin
    if (lowerPluginName.contains('stack') || lowerPluginName.contains('size')) {
      return _getStackSizeControllerPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // VirtualQuarries plugin
    if (lowerPluginName.contains('quarry') || lowerPluginName.contains('virtual')) {
      return _getVirtualQuarriesPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // FurnaceUpgrades plugin
    if (lowerPluginName.contains('furnace') || lowerPluginName.contains('upgrade')) {
      return _getFurnaceUpgradesPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // MonumentPlus plugin
    if (lowerPluginName.contains('monument')) {
      return _getMonumentPlusPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // BetterTC plugin
    if (lowerPluginName.contains('tc') || lowerPluginName.contains('tool')) {
      return _getBetterTCPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // IQChat plugin
    if (lowerPluginName.contains('chat') || lowerPluginName.contains('iq')) {
      return _getIQChatPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // ImageLibrary plugin
    if (lowerPluginName.contains('image') || lowerPluginName.contains('library')) {
      return _getImageLibraryPluginHelp(lowerFieldName, lowerFieldPath);
    }

    // ZombieHorde plugin
    if (lowerPluginName.contains('zombie') || lowerPluginName.contains('horde')) {
      return _getZombieHordePluginHelp(lowerFieldName, lowerFieldPath);
    }

    // AbsolutSorter plugin
    if (lowerPluginName.contains('sorter') || lowerPluginName.contains('absolut')) {
      return _getAbsolutSorterPluginHelp(lowerFieldName, lowerFieldPath);
    }

    return null;
  }

  /// Gets help for Skills/OPSkill plugin fields.
  static FieldHelpInfo? _getSkillPluginHelp(
    String fieldName,
    String fieldPath,
  ) {
    // Skill Type field
    if (fieldName == 'type' && fieldPath.contains('skill')) {
      return const FieldHelpInfo(
        description: 'Skill type classification',
        tooltip:
            'The type of skill effect. Common types:\n'
            '• "Wood", "Stone", "Sulfur", etc. - Gathering skills (affects resource gathering)\n'
            '• "Attack" - Combat skills (affects weapon damage)\n'
            '• "Defense" - Defense skills (reduces damage taken)\n'
            '• "Craft" - Crafting skills (affects crafting speed/cost)\n'
            '• "None" - Custom skill (uses ID field instead)\n\n'
            'The type determines what the skill affects in-game.',
        examples: <String>['Wood', 'Stone', 'Attack', 'Defense', 'Craft', 'None'],
      );
    }

    // Skill Category
    if (fieldName == 'category' && fieldPath.contains('skill')) {
      return const FieldHelpInfo(
        description: 'Skill category for UI organization',
        tooltip:
            'Groups skills in the UI menu. Common categories:\n'
            '• "Gathering" - Resource gathering skills\n'
            '• "Combat" - Combat-related skills\n'
            '• "Crafting" - Crafting and building skills\n'
            '• "Utility" - General utility skills\n\n'
            'Skills are organized by category in the skill tree interface.',
        examples: <String>['Gathering', 'Combat', 'Crafting', 'Utility'],
      );
    }

    // Skill ID (for None/Gather types)
    if (fieldName.contains('id') && 
        (fieldName.contains('none') || fieldName.contains('gather'))) {
      return const FieldHelpInfo(
        description: 'Item ID for skill effect',
        tooltip:
            'The item shortname ID that this skill affects. Used when Type is "None" or for specific gathering types.\n'
            'Example: For a wood gathering skill, this would be "wood".\n'
            'For custom skills, this identifies which item/entity the skill modifies.',
        examples: <String>['wood', 'stones', 'metal.ore', 'sulfur.ore'],
      );
    }

    // Skill Value
    if (fieldName == 'value' && fieldPath.contains('stage')) {
      return const FieldHelpInfo(
        description: 'Primary skill effect value',
        tooltip:
            'The main effect value for this skill stage. Meaning depends on skill type:\n'
            '• Gathering skills: Percentage increase (e.g., 200 = 200% = 2x gathering rate)\n'
            '• Attack skills: Damage percentage increase (e.g., 5 = +5% damage)\n'
            '• Defense skills: Damage reduction percentage\n'
            '• Craft skills: Speed multiplier or cost reduction\n\n'
            'Higher values = stronger effect.',
        examples: <String>['200.0', '5.0', '10.0', '50.0'],
      );
    }

    // Skill Value 2
    if (fieldName == 'value 2' && fieldPath.contains('stage')) {
      return const FieldHelpInfo(
        description: 'Secondary skill effect value',
        tooltip:
            'Optional secondary effect value. Used for skills with multiple effects.\n'
            'Example: A skill might increase both gathering rate (Value) and yield (Value 2).\n'
            'Set to 0.0 if not used.',
        examples: <String>['0.0', '10.0', '25.0'],
      );
    }

    // Skill Cost
    if (fieldName == 'cost' && fieldPath.contains('stage')) {
      return const FieldHelpInfo(
        description: 'Cost to unlock this skill stage',
        tooltip:
            'The price players must pay to unlock this skill stage.\n'
            'Uses the economy system configured in the Economy section.\n'
            'Can be in-game currency (scrap, etc.) or plugin economy.\n\n'
            'Higher stages typically cost more.',
        examples: <String>['1000.0', '3000.0', '5000.0', '10000.0'],
      );
    }

    // Required Skills
    if (fieldName.contains('required') && fieldName.contains('skill')) {
      return const FieldHelpInfo(
        description: 'Prerequisite skills',
        tooltip:
            'List of skill titles that must be unlocked before this skill.\n'
            'Creates a skill tree/dependency system.\n'
            'Example: ["LUMBERJACK", "MINER"] means both LUMBERJACK and MINER must be unlocked first.\n\n'
            'Leave empty [] for no prerequisites.',
        examples: <String>['["LUMBERJACK"]', '["LUMBERJACK", "MINER"]', '[]'],
      );
    }

    // Skill Stages
    if (fieldName == 'stages') {
      return const FieldHelpInfo(
        description: 'Skill progression stages',
        tooltip:
            'Defines the skill levels/upgrades. Each stage has:\n'
            '• Cost - Price to unlock\n'
            '• Value - Primary effect amount\n'
            '• Value 2 - Secondary effect (optional)\n'
            '• Permission - Optional permission granted\n'
            '• Commands - Commands to run when unlocked\n'
            '• Required Skills - Prerequisites\n\n'
            'Stages are numbered (1, 2, 3, etc.) and unlock in order.',
        examples: <String>['{"1": {...}, "2": {...}, "3": {...}}'],
      );
    }

    // Skill Title
    if (fieldName == 'title' && fieldPath.contains('skill')) {
      return const FieldHelpInfo(
        description: 'Skill display name',
        tooltip:
            'The name shown to players in the skill menu.\n'
            'Should be clear and descriptive (e.g., "LUMBERJACK", "STOPPING POWER").\n'
            'This is what appears on skill cards in the UI.',
        examples: <String>['LUMBERJACK', 'STOPPING POWER', 'FAST CRAFTER'],
      );
    }

    // Skill Description
    if (fieldName == 'description' && fieldPath.contains('skill')) {
      return const FieldHelpInfo(
        description: 'Skill description text',
        tooltip:
            'Explains what the skill does. Shown to players in the skill menu.\n'
            'Example: "Increase wood gathering rate" or "Increase weapon damage".\n'
            'Keep it concise but informative.',
        examples: <String>[
          'Increase wood gathering rate',
          'Increase weapon damage',
          'Reduce crafting time',
        ],
      );
    }

    // Skill Image
    if (fieldName == 'image' && fieldPath.contains('skill')) {
      return const FieldHelpInfo(
        description: 'Skill icon image URL',
        tooltip:
            'URL to an image file displayed as the skill icon.\n'
            'Should be a publicly accessible image (PNG, JPG, etc.).\n'
            'Recommended size: 64x64 to 128x128 pixels.\n\n'
            'Leave null to use default icon.',
        examples: <String>[
          'https://gspics.org/images/2020/09/02/xz6Fy.png',
        ],
      );
    }

    // Economy Type
    if (fieldName == 'type' && fieldPath.contains('economy')) {
      return const FieldHelpInfo(
        description: 'Economy system type',
        tooltip:
            'How players pay for skills:\n'
            '• "Plugin" - Uses another plugin\'s economy (Economics, ServerRewards, etc.)\n'
            '• "Item" - Uses an in-game item as currency (scrap, wood, etc.)\n\n'
            'If "Plugin", configure the plugin name and hooks.\n'
            'If "Item", configure ShortName and Display Name.',
        examples: <String>['Plugin', 'Item'],
      );
    }

    // Economy Plugin Name
    if (fieldName.contains('plugin name') && fieldPath.contains('economy')) {
      return const FieldHelpInfo(
        description: 'Economy plugin name',
        tooltip:
            'The name of the economy plugin to use (when Type is "Plugin").\n'
            'Common plugins:\n'
            '• "Economics" - Economics plugin\n'
            '• "ServerRewards" - Server Rewards plugin\n'
            '• "Kits" - Kits plugin economy\n\n'
            'Must match the exact plugin name as it appears in Oxide.',
        examples: <String>['Economics', 'ServerRewards', 'Kits'],
      );
    }

    // Economy Hooks
    if (fieldName.contains('hook') && fieldPath.contains('economy')) {
      return const FieldHelpInfo(
        description: 'Economy plugin hook name',
        tooltip:
            'The hook method name to call on the economy plugin.\n'
            'Common hooks:\n'
            '• "Deposit" - Add balance\n'
            '• "Withdraw" - Remove balance\n'
            '• "Balance" - Get balance\n\n'
            'These hooks allow the skill plugin to interact with economy plugins.',
        examples: <String>['Deposit', 'Withdraw', 'Balance'],
      );
    }

    // UI Settings - Opacity
    if (fieldName == 'opacity' || 
        (fieldName.contains('opacity') && fieldPath.contains('ui'))) {
      return const FieldHelpInfo(
        description: 'UI element opacity (0-100)',
        tooltip:
            'Transparency level for UI elements. Range: 0 to 100.\n'
            '• 0 = Fully transparent (invisible)\n'
            '• 100 = Fully opaque (solid)\n'
            '• 50 = Semi-transparent\n\n'
            'Used for backgrounds, overlays, and UI elements.',
        examples: <String>['0', '50', '80', '100'],
      );
    }

    // UI Settings - HEX Color
    if (fieldName == 'hex' || fieldName == 'heX') {
      return const FieldHelpInfo(
        description: 'Color in hexadecimal format',
        tooltip:
            'Color value in hex format (e.g., #FF8500 for orange).\n'
            'Format: #RRGGBB where RR, GG, BB are hex values (00-FF).\n'
            'Common colors:\n'
            '• #FF8500 - Orange\n'
            '• #0A0A0A - Dark gray/black\n'
            '• #FFFFFF - White\n'
            '• #FF0000 - Red\n\n'
            'Use with Opacity to control transparency.',
        examples: <String>['#FF8500', '#0A0A0A', '#FFFFFF', '#1a1a1a'],
      );
    }

    // Font Size
    if (fieldName.contains('font size')) {
      return const FieldHelpInfo(
        description: 'Text font size in pixels',
        tooltip:
            'The size of text in the UI. Larger numbers = bigger text.\n'
            'Typical ranges:\n'
            '• Titles: 26-40\n'
            '• Headers: 16-20\n'
            '• Body text: 12-16\n'
            '• Small text: 10-12',
        examples: <String>['12', '16', '26', '38'],
      );
    }

    // Show Time
    if (fieldName.contains('show time')) {
      return const FieldHelpInfo(
        description: 'Notification display duration (seconds)',
        tooltip:
            'How long to show a notification popup in seconds.\n'
            'Example: 0.9 = show for 0.9 seconds\n'
            'Range: 0.1 to 10.0 typically.\n\n'
            'Longer times = notification stays visible longer.',
        examples: <String>['0.5', '0.9', '2.0', '5.0'],
      );
    }

    // Auto wipe
    if (fieldName.contains('auto wipe') || fieldName.contains('wipe')) {
      return const FieldHelpInfo(
        description: 'Reset skills on server wipe',
        tooltip:
            'If true, all player skills are reset when the server wipes.\n'
            'If false, skills persist across wipes (stored in data files).\n\n'
            'Recommended: true for most servers.',
        examples: <String>['true', 'false'],
      );
    }

    // Work with Notify
    if (fieldName.contains('notify') && fieldName.contains('work')) {
      return const FieldHelpInfo(
        description: 'Integrate with Notify plugin',
        tooltip:
            'If true, uses the Notify plugin for skill notifications.\n'
            'If false, uses default notification system.\n\n'
            'Requires Notify plugin to be installed.',
        examples: <String>['true', 'false'],
      );
    }

    return null;
  }

  /// Gets help for Shop plugin fields.
  static FieldHelpInfo? _getShopPluginHelp(
    String fieldName,
    String fieldPath,
  ) {
    // Shop Price
    if (fieldName == 'price' && fieldPath.contains('shop')) {
      return const FieldHelpInfo(
        description: 'Item buy/sell price',
        tooltip:
            'The price players pay to buy this item, or receive when selling.\n'
            'Uses the economy system configured in Economy section.\n'
            'Can be currency amount (scrap, etc.) or plugin economy points.\n\n'
            'Buy price is typically higher than sell price.',
        examples: <String>['100.0', '500.0', '1000.0'],
      );
    }

    // Shop Categories
    if (fieldName.contains('categor') && fieldPath.contains('shop')) {
      return const FieldHelpInfo(
        description: 'Shop category filter',
        tooltip:
            'Categories that this item appears in. Use "*" for all categories.\n'
            'Categories organize items in the shop UI.\n'
            'Example: ["Weapons", "Resources", "*"]',
        examples: <String>['["Weapons"]', '["*"]', '["Weapons", "Resources"]'],
      );
    }

    // Cooldown
    if (fieldName.contains('cooldown')) {
      return const FieldHelpInfo(
        description: 'Action cooldown time (seconds)',
        tooltip:
            'Time in seconds players must wait between actions.\n'
            'Prevents spam/abuse of shop features.\n'
            'Example: 60.0 = 60 seconds = 1 minute cooldown.',
        examples: <String>['0.0', '60.0', '3600.0'],
      );
    }

    // Wipe Cooldown
    if (fieldName.contains('wipe cooldown')) {
      return const FieldHelpInfo(
        description: 'Cooldown after server wipe (seconds)',
        tooltip:
            'Time in seconds after server wipe before shop features are available.\n'
            'Prevents players from using shop immediately after wipe.\n'
            'Example: 3600.0 = 1 hour cooldown after wipe.',
        examples: <String>['0.0', '3600.0', '7200.0'],
      );
    }

    // Respawn Cooldown
    if (fieldName.contains('respawn cooldown')) {
      return const FieldHelpInfo(
        description: 'Cooldown after player respawn (seconds)',
        tooltip:
            'Time in seconds after respawning before shop can be used.\n'
            'Prevents shop use immediately after death/respawn.\n'
            'Example: 60.0 = 1 minute cooldown after respawn.',
        examples: <String>['0.0', '60.0', '300.0'],
      );
    }

    // Display Type
    if (fieldName.contains('display type')) {
      return const FieldHelpInfo(
        description: 'UI display method',
        tooltip:
            'How the shop interface is displayed:\n'
            '• "Overlay" - Full screen overlay (recommended)\n'
            '• "Hud" - HUD element (smaller, less intrusive)\n\n'
            'Overlay provides better UX for complex shops.',
        examples: <String>['Overlay', 'Hud'],
      );
    }

    return null;
  }

  /// Gets help for BankSystem plugin fields.
  static FieldHelpInfo? _getBankPluginHelp(
    String fieldName,
    String fieldPath,
  ) {
    // Starting Balance
    if (fieldName.contains('starting balance')) {
      return const FieldHelpInfo(
        description: 'Initial bank balance for new players',
        tooltip:
            'The amount of currency new players start with in their bank account.\n'
            'Only applies when they first create an account.\n'
            'Uses the currency configured in Currency Settings.',
        examples: <String>['0', '1000', '5000'],
      );
    }

    // Minimum Deposit/Withdrawal
    if (fieldName.contains('minimum') && 
        (fieldName.contains('deposit') || fieldName.contains('withdrawal'))) {
      return const FieldHelpInfo(
        description: 'Minimum transaction amount',
        tooltip:
            'The smallest amount players can deposit or withdraw in one transaction.\n'
            'Prevents very small transactions that clutter logs.\n'
            'Example: 1.0 = minimum 1 unit per transaction.',
        examples: <String>['1.0', '10.0', '100.0'],
      );
    }

    // Deposit/Withdrawal Fee
    if (fieldName.contains('fee') && 
        (fieldName.contains('deposit') || fieldName.contains('withdrawal'))) {
      return const FieldHelpInfo(
        description: 'Transaction fee percentage',
        tooltip:
            'Fee charged on deposits/withdrawals as a percentage.\n'
            'Range: 0.0 to 100.0 (0% to 100%).\n'
            'Example: 5.0 = 5% fee on each transaction.\n\n'
            'Fees can be permission-based for VIP players.',
        examples: <String>['0.0', '5.0', '10.0'],
      );
    }

    // Step Fee
    if (fieldName.contains('step') && fieldName.contains('fee')) {
      return const FieldHelpInfo(
        description: 'Fee adjustment step size',
        tooltip:
            'The increment size when adjusting fees in the UI.\n'
            'Example: 0.1 = fees can be adjusted in 0.1% increments.\n'
            'Smaller steps = more precise control.',
        examples: <String>['0.1', '0.5', '1.0'],
      );
    }

    // Breakage
    if (fieldName.contains('breakage')) {
      return const FieldHelpInfo(
        description: 'ATM breakage chance',
        tooltip:
            'Percentage chance the ATM breaks during use.\n'
            'Range: 0.0 to 100.0 (0% to 100%).\n'
            'When ATM breaks, players must repair it with items.\n\n'
            'Can be permission-based (VIP players have lower breakage).',
        examples: <String>['0.0', '1.0', '5.0'],
      );
    }

    // Card Expiry
    if (fieldName.contains('expir') || fieldName.contains('expiry')) {
      return const FieldHelpInfo(
        description: 'Bank card expiration (days)',
        tooltip:
            'Number of days before a bank card expires.\n'
            'After expiration, players must create a new card.\n'
            'Set to 0 or disable "Use card expiration date" for no expiration.',
        examples: <String>['7', '30', '90'],
      );
    }

    // Currency Short Name
    if (fieldName.contains('short name') && fieldPath.contains('currency')) {
      return const FieldHelpInfo(
        description: 'Currency item shortname',
        tooltip:
            'The item shortname used as bank currency.\n'
            'Example: "sticks" for sticks, "scrap" for scrap.\n'
            'This item is used for all bank transactions.',
        examples: <String>['sticks', 'scrap', 'wood'],
      );
    }

    return null;
  }

  /// Gets help for EpicLoot plugin fields.
  static FieldHelpInfo? _getEpicLootPluginHelp(
    String fieldName,
    String fieldPath,
  ) {
    // Chance Multiplier
    if (fieldName.contains('chance multiplier')) {
      return const FieldHelpInfo(
        description: 'Permission-based chance multiplier',
        tooltip:
            'Multiplies the chance of finding/creating EpicLoot items.\n'
            '• 1.0 = normal chance (100%)\n'
            '• 2.0 = double chance (200%)\n'
            '• 0.5 = half chance (50%)\n\n'
            'Higher values = more EpicLoot items.\n'
            'Can be set per permission group.',
        examples: <String>['1.0', '1.5', '2.0'],
      );
    }

    // Roll Chances
    if (fieldName.contains('roll chance')) {
      return const FieldHelpInfo(
        description: 'Probability for rolling item properties',
        tooltip:
            'Chance (0.0 to 1.0) of rolling specific item properties.\n'
            '• 0.0 = never (0%)\n'
            '• 1.0 = always (100%)\n'
            '• 0.3 = 30% chance\n\n'
            'Used for determining which bonuses/effects items get.',
        examples: <String>['0.0', '0.3', '0.5', '1.0'],
      );
    }

    // Craft Chance
    if (fieldName.contains('craft') && fieldName.contains('%')) {
      return const FieldHelpInfo(
        description: 'Craft enhancement chance percentage',
        tooltip:
            'Percentage chance that a crafted item becomes EpicLoot enhanced.\n'
            'Range: 0.0 to 100.0 (0% to 100%).\n'
            'Example: 5.0 = 5% chance each craft becomes enhanced.\n\n'
            'Higher values = more enhanced items from crafting.',
        examples: <String>['0.0', '5.0', '10.0', '25.0'],
      );
    }

    return null;
  }

  /// Gets combined help (plugin-specific + generic).
  ///
  /// First checks plugin-specific help, then falls back to generic Rust knowledge.
  static FieldHelpInfo? getCombinedHelp(
    String? pluginName,
    String? fieldName,
    String? fieldPath,
  ) {
    // Try plugin-specific first
    final FieldHelpInfo? pluginHelp =
        getPluginSpecificHelp(pluginName, fieldName, fieldPath);
    if (pluginHelp != null) {
      return pluginHelp;
    }

    // Fall back to generic Rust knowledge
    return RustFieldKnowledgeBase.getHelpForField(fieldName);
  }

  // ==================== Plugin-Specific Help Functions ====================

  /// Gets help for Hud plugin fields.
  static FieldHelpInfo? _getHudPluginHelp(String fieldName, String fieldPath) {
    // Auto reload
    if (fieldName.contains('auto reload')) {
      return const FieldHelpInfo(
        description: 'Auto-reload config on save',
        tooltip:
            'If enabled, the plugin automatically reloads when you save the config file.\n'
            'Useful for testing changes without restarting the server.',
        examples: <String>['true', 'false'],
      );
    }

    // Overall layer
    if (fieldName.contains('overall layer')) {
      return const FieldHelpInfo(
        description: 'Show HUD in inventory',
        tooltip:
            'If true, the HUD will be visible in your inventory screen.\n'
            'If false, it only shows in-game.',
        examples: <String>['true', 'false'],
      );
    }

    // Size settings
    if (fieldName.contains('size') && fieldPath.contains('main')) {
      return const FieldHelpInfo(
        description: 'HUD size multiplier (0% - inf)',
        tooltip:
            'Controls the overall size of the HUD elements.\n'
            '• 100 = 100% (normal size)\n'
            '• 50 = 50% (half size)\n'
            '• 200 = 200% (double size)\n\n'
            'Use this to scale the entire HUD interface.',
        examples: <String>['85', '100', '150'],
      );
    }

    // Background opacity
    if (fieldName.contains('background opacity') || fieldName.contains('opacity')) {
      return const FieldHelpInfo(
        description: 'Background transparency (0% - 100%)',
        tooltip:
            'Controls how transparent the background is.\n'
            '• 0 = Fully transparent (invisible)\n'
            '• 100 = Fully opaque (solid)\n'
            '• 85 = Slightly transparent (recommended)',
        examples: <String>['60', '85', '100'],
      );
    }

    // Position/Align
    if (fieldName == 'align' || fieldName.contains('position')) {
      return const FieldHelpInfo(
        description: 'HUD position on screen',
        tooltip:
            'Where the HUD appears on screen:\n'
            '• "TopLeft" - Top-left corner\n'
            '• "TopRight" - Top-right corner\n'
            '• "BottomLeft" - Bottom-left corner\n'
            '• "BottomRight" - Bottom-right corner',
        examples: <String>['TopLeft', 'TopRight', 'BottomLeft', 'BottomRight'],
      );
    }

    // Server name
    if (fieldName.contains('server name')) {
      return const FieldHelpInfo(
        description: 'Server name displayed in HUD',
        tooltip:
            'The server name shown in the HUD interface.\n'
            'This is what players see in the HUD display.',
        examples: <String>['Rustier PvE', 'My Server', 'Rust Server'],
      );
    }

    // Active players
    if (fieldName.contains('active player') || fieldPath.contains('active player')) {
      return const FieldHelpInfo(
        description: 'Show active player count',
        tooltip:
            'Displays the number of players currently online.\n'
            'Can optionally include or exclude admins from the count.',
        examples: <String>['true', 'false'],
      );
    }

    return null;
  }

  /// Gets help for Economics plugin fields.
  static FieldHelpInfo? _getEconomicsPluginHelp(String fieldName, String fieldPath) {
    // Starting balance
    if (fieldName.contains('starting') && fieldName.contains('balance')) {
      return const FieldHelpInfo(
        description: 'Initial account balance for new players',
        tooltip:
            'The amount of currency new players start with.\n'
            'Set to 0 to give players no starting money.\n'
            'Common values: 1000, 5000, 10000',
        examples: <String>['0', '1000', '5000'],
      );
    }

    // Balance limit
    if (fieldName.contains('balance limit')) {
      return const FieldHelpInfo(
        description: 'Maximum balance limit (0 = unlimited)',
        tooltip:
            'Maximum amount a player can have in their account.\n'
            'Set to 0 to disable the limit (unlimited).\n'
            'Prevents players from accumulating too much currency.',
        examples: <String>['0', '1000000', '10000000'],
      );
    }

    // Negative balance
    if (fieldName.contains('negative balance')) {
      return const FieldHelpInfo(
        description: 'Allow negative account balances',
        tooltip:
            'If true, players can go into negative balance (debt).\n'
            'If false, transactions that would cause negative balance are blocked.',
        examples: <String>['true', 'false'],
      );
    }

    // Remove unused accounts
    if (fieldName.contains('remove unused')) {
      return const FieldHelpInfo(
        description: 'Clean up inactive accounts',
        tooltip:
            'If true, accounts with zero balance that haven\'t been used are removed.\n'
            'Helps keep the database clean.',
        examples: <String>['true', 'false'],
      );
    }

    // Wipe balances
    if (fieldName.contains('wipe balance')) {
      return const FieldHelpInfo(
        description: 'Reset balances on server wipe',
        tooltip:
            'If true, all player balances are reset to starting balance on wipe.\n'
            'If false, balances persist across wipes.',
        examples: <String>['true', 'false'],
      );
    }

    return null;
  }

  /// Gets help for BetterTeams plugin fields.
  static FieldHelpInfo? _getBetterTeamsPluginHelp(String fieldName, String fieldPath) {
    // Team size limit
    if (fieldName.contains('team size') || fieldName.contains('max member')) {
      return const FieldHelpInfo(
        description: 'Maximum team members',
        tooltip:
            'Maximum number of players allowed in a team.\n'
            'Common values: 4, 8, 16, or unlimited (0).',
        examples: <String>['4', '8', '16', '0'],
      );
    }

    // Team creation cost
    if (fieldName.contains('team cost') || fieldName.contains('create cost')) {
      return const FieldHelpInfo(
        description: 'Cost to create a team',
        tooltip:
            'Amount of currency required to create a new team.\n'
            'Set to 0 to make team creation free.',
        examples: <String>['0', '1000', '5000'],
      );
    }

    return null;
  }

  /// Gets help for AdminMenu plugin fields.
  static FieldHelpInfo? _getAdminMenuPluginHelp(String fieldName, String fieldPath) {
    // Permission
    if (fieldName.contains('permission')) {
      return const FieldHelpInfo(
        description: 'Permission required to use admin menu',
        tooltip:
            'Oxide permission that players need to access the admin menu.\n'
            'Example: "adminmenu.use"',
        examples: <String>['adminmenu.use', 'admin.use'],
      );
    }

    // Command
    if (fieldName == 'command' || fieldName == 'commands') {
      return const FieldHelpInfo(
        description: 'Chat command to open admin menu',
        tooltip:
            'The command players/admins type to open the menu.\n'
            'Can be a single command or array of commands.',
        examples: <String>['admin', 'am', 'menu'],
      );
    }

    return null;
  }

  /// Gets help for TruePVE plugin fields.
  static FieldHelpInfo? _getTruePVEPluginHelp(String fieldName, String fieldPath) {
    // PvP enabled
    if (fieldName.contains('pvp') || fieldName.contains('pve')) {
      return const FieldHelpInfo(
        description: 'PvP/PvE mode settings',
        tooltip:
            'Controls player vs player combat.\n'
            'TruePVE typically disables PvP in certain areas or times.',
        examples: <String>['true', 'false'],
      );
    }

    return null;
  }

  /// Gets help for Vanish plugin fields.
  static FieldHelpInfo? _getVanishPluginHelp(String fieldName, String fieldPath) {
    // Vanish command
    if (fieldName == 'command' || fieldName == 'commands') {
      return const FieldHelpInfo(
        description: 'Command to toggle vanish',
        tooltip:
            'Command that admins use to become invisible.\n'
            'Common: "vanish", "v", "hide"',
        examples: <String>['vanish', 'v', 'hide'],
      );
    }

    // Permission
    if (fieldName.contains('permission')) {
      return const FieldHelpInfo(
        description: 'Permission to use vanish',
        tooltip:
            'Oxide permission required to use vanish command.\n'
            'Example: "vanish.use"',
        examples: <String>['vanish.use', 'admin.vanish'],
      );
    }

    return null;
  }

  /// Gets help for Whitelist plugin fields.
  static FieldHelpInfo? _getWhitelistPluginHelp(String fieldName, String fieldPath) {
    // Whitelist enabled
    if (fieldName.contains('enable') || fieldName.contains('whitelist')) {
      return const FieldHelpInfo(
        description: 'Enable whitelist system',
        tooltip:
            'If true, only players on the whitelist can join the server.\n'
            'All other players will be kicked.',
        examples: <String>['true', 'false'],
      );
    }

    return null;
  }

  /// Gets help for StackSizeController plugin fields.
  static FieldHelpInfo? _getStackSizeControllerPluginHelp(String fieldName, String fieldPath) {
    // Stack size
    if (fieldName.contains('stack size') || fieldName.contains('stacksize')) {
      return const FieldHelpInfo(
        description: 'Maximum stack size for items',
        tooltip:
            'Controls how many items can stack in one inventory slot.\n'
            'Can be set per-item or globally.\n'
            'Default Rust stack sizes vary by item type.',
        examples: <String>['1000', '5000', '10000'],
      );
    }

    return null;
  }

  /// Gets help for VirtualQuarries plugin fields.
  static FieldHelpInfo? _getVirtualQuarriesPluginHelp(String fieldName, String fieldPath) {
    // Quarry cost
    if (fieldName.contains('cost') || fieldName.contains('price')) {
      return const FieldHelpInfo(
        description: 'Cost to place/upgrade quarry',
        tooltip:
            'Amount of currency or items required to place or upgrade a virtual quarry.\n'
            'Higher tier quarries typically cost more.',
        examples: <String>['1000', '5000', '10000'],
      );
    }

    // Quarry production rate
    if (fieldName.contains('rate') || fieldName.contains('production')) {
      return const FieldHelpInfo(
        description: 'Resource production rate',
        tooltip:
            'How fast the quarry produces resources.\n'
            'Higher values = faster production.\n'
            'Can be set per resource type.',
        examples: <String>['1.0', '2.0', '5.0'],
      );
    }

    return null;
  }

  /// Gets help for FurnaceUpgrades plugin fields.
  static FieldHelpInfo? _getFurnaceUpgradesPluginHelp(String fieldName, String fieldPath) {
    // Upgrade cost
    if (fieldName.contains('upgrade cost') || fieldName.contains('cost')) {
      return const FieldHelpInfo(
        description: 'Cost to upgrade furnace',
        tooltip:
            'Amount of currency or items required to upgrade a furnace.\n'
            'Upgrades typically improve smelting speed or fuel efficiency.',
        examples: <String>['1000', '5000'],
      );
    }

    // Smelting speed
    if (fieldName.contains('speed') || fieldName.contains('smelt')) {
      return const FieldHelpInfo(
        description: 'Furnace smelting speed multiplier',
        tooltip:
            'How fast the furnace smelts items.\n'
            '• 1.0 = normal speed\n'
            '• 2.0 = double speed\n'
            '• 0.5 = half speed',
        examples: <String>['1.0', '2.0', '5.0'],
      );
    }

    return null;
  }

  /// Gets help for MonumentPlus plugin fields.
  static FieldHelpInfo? _getMonumentPlusPluginHelp(String fieldName, String fieldPath) {
    // Monument settings
    if (fieldName.contains('monument') || fieldPath.contains('monument')) {
      return const FieldHelpInfo(
        description: 'Monument configuration',
        tooltip:
            'Settings for monuments (dome, airfield, etc.).\n'
            'Can control spawn rates, loot, and other monument features.',
      );
    }

    return null;
  }

  /// Gets help for BetterTC plugin fields.
  static FieldHelpInfo? _getBetterTCPluginHelp(String fieldName, String fieldPath) {
    // TC settings
    if (fieldName.contains('tc') || fieldName.contains('tool cupboard')) {
      return const FieldHelpInfo(
        description: 'Tool Cupboard settings',
        tooltip:
            'Configuration for tool cupboards.\n'
            'Can control decay, authorization, and other TC features.',
      );
    }

    return null;
  }

  /// Gets help for IQChat plugin fields.
  static FieldHelpInfo? _getIQChatPluginHelp(String fieldName, String fieldPath) {
    // Chat format
    if (fieldName.contains('format') || fieldName.contains('chat')) {
      return const FieldHelpInfo(
        description: 'Chat message format',
        tooltip:
            'Format string for chat messages.\n'
            'Uses placeholders like {player}, {message}, etc.',
        examples: <String>['{player}: {message}', '[{time}] {player}: {message}'],
      );
    }

    return null;
  }

  /// Gets help for ImageLibrary plugin fields.
  static FieldHelpInfo? _getImageLibraryPluginHelp(String fieldName, String fieldPath) {
    // Image URL
    if (fieldName.contains('image') || fieldName.contains('url')) {
      return const FieldHelpInfo(
        description: 'Image URL or key',
        tooltip:
            'URL to an image file or a key reference to a stored image.\n'
            'Images are cached for performance.',
        examples: <String>['https://example.com/image.png', 'myimagekey'],
      );
    }

    return null;
  }

  /// Gets help for ZombieHorde plugin fields.
  static FieldHelpInfo? _getZombieHordePluginHelp(String fieldName, String fieldPath) {
    // Spawn settings
    if (fieldName.contains('spawn') || fieldName.contains('zombie')) {
      return const FieldHelpInfo(
        description: 'Zombie spawn configuration',
        tooltip:
            'Settings for zombie spawning.\n'
            'Controls spawn rates, locations, and zombie types.',
      );
    }

    return null;
  }

  /// Gets help for AbsolutSorter plugin fields.
  static FieldHelpInfo? _getAbsolutSorterPluginHelp(String fieldName, String fieldPath) {
    // Auto sort
    if (fieldName.contains('auto sort') || fieldName.contains('automatic')) {
      return const FieldHelpInfo(
        description: 'Automatic inventory sorting',
        tooltip:
            'If enabled, inventory is automatically sorted.\n'
            'Can be configured per container type.',
        examples: <String>['true', 'false'],
      );
    }

    // Sort rules
    if (fieldName.contains('sort') || fieldName.contains('rule')) {
      return const FieldHelpInfo(
        description: 'Sorting rules and priorities',
        tooltip:
            'Defines how items are sorted in containers.\n'
            'Can sort by type, name, value, etc.',
      );
    }

    return null;
  }
}

