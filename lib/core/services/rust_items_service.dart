import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Service for fetching Rust game items from API.
class RustItemsService {
  /// API URL for Rust items.
  static const String _apiUrl =
      'https://gist.githubusercontent.com/Marcuzz/9e01a39a8f5f83dc673bfc6f6fa4aacc/raw/items.json';

  static RustItemsService? _instance;
  List<RustItem>? _cachedItems;

  RustItemsService._();

  /// Singleton instance.
  static RustItemsService get instance {
    _instance ??= RustItemsService._();
    return _instance!;
  }

  /// Fetches all Rust items from API with fallback.
  Future<List<RustItem>> fetchItems() async {
    // Return cached if available
    if (_cachedItems != null) {
      return _cachedItems!;
    }

    try {
      // Try to fetch from API
      final http.Response response = await http
          .get(Uri.parse(_apiUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        // Parse the response
        _cachedItems = _parseApiResponse(data);
        return _cachedItems!;
      }
    } catch (e) {
      // Failed to fetch from API, using fallback
      debugPrint('Failed to fetch from API: $e');
    }

    // Fallback to embedded common items
    _cachedItems = _getCommonRustItems();
    return _cachedItems!;
  }

  /// Parses API response into RustItem list.
  List<RustItem> _parseApiResponse(dynamic data) {
    try {
      if (data is List) {
        // ignore: avoid_dynamic_calls
        return data.map((dynamic item) {
          return RustItem(
            // ignore: avoid_dynamic_calls
            shortname: item['shortName'] as String? ?? '',
            // ignore: avoid_dynamic_calls
            displayName: item['displayName'] as String? ?? '',
            // ignore: avoid_dynamic_calls
            category: item['category'] as String? ?? 'Unknown',
            // ignore: avoid_dynamic_calls
            imageUrl: item['image'] as String?,
          );
        }).toList();
      }
    } catch (e) {
      // Error parsing API response, using fallback
      debugPrint('Error parsing API response: $e');
    }
    return _getCommonRustItems();
  }

  /// Gets commonly used Rust items (fallback).
  List<RustItem> _getCommonRustItems() {
    return const <RustItem>[
      // Storage/Containers
      RustItem(
        shortname: 'box.wooden.large',
        displayName: 'Large Wood Box',
        category: 'Storage',
      ),
      RustItem(
        shortname: 'woodbox_deployed',
        displayName: 'Wood Storage Box',
        category: 'Storage',
      ),
      RustItem(
        shortname: 'coffinstorage',
        displayName: 'Coffin Storage',
        category: 'Storage',
      ),
      RustItem(
        shortname: 'fridge.deployed',
        displayName: 'Fridge',
        category: 'Storage',
      ),
      RustItem(
        shortname: 'locker.deployed',
        displayName: 'Locker',
        category: 'Storage',
      ),
      RustItem(
        shortname: 'small_stash_deployed',
        displayName: 'Small Stash',
        category: 'Storage',
      ),
      RustItem(
        shortname: 'cupboard.tool.deployed',
        displayName: 'Tool Cupboard',
        category: 'Storage',
      ),

      // Deployables
      RustItem(
        shortname: 'campfire',
        displayName: 'Camp Fire',
        category: 'Deployable',
      ),
      RustItem(
        shortname: 'furnace',
        displayName: 'Furnace',
        category: 'Deployable',
      ),
      RustItem(
        shortname: 'furnace.large',
        displayName: 'Large Furnace',
        category: 'Deployable',
      ),
      RustItem(
        shortname: 'refinery_small_deployed',
        displayName: 'Small Oil Refinery',
        category: 'Deployable',
      ),
      RustItem(
        shortname: 'workbench1.deployed',
        displayName: 'Workbench Level 1',
        category: 'Deployable',
      ),
      RustItem(
        shortname: 'workbench2.deployed',
        displayName: 'Workbench Level 2',
        category: 'Deployable',
      ),
      RustItem(
        shortname: 'workbench3.deployed',
        displayName: 'Workbench Level 3',
        category: 'Deployable',
      ),

      // Building
      RustItem(
        shortname: 'wall.external.high.wood',
        displayName: 'High External Wooden Wall',
        category: 'Building',
      ),
      RustItem(
        shortname: 'wall.external.high.stone',
        displayName: 'High External Stone Wall',
        category: 'Building',
      ),
      RustItem(
        shortname: 'door.hinged.wood',
        displayName: 'Wooden Door',
        category: 'Building',
      ),
      RustItem(
        shortname: 'door.hinged.metal',
        displayName: 'Sheet Metal Door',
        category: 'Building',
      ),
      RustItem(
        shortname: 'door.hinged.toptier',
        displayName: 'Armored Door',
        category: 'Building',
      ),

      // Weapons
      RustItem(
        shortname: 'rifle.ak',
        displayName: 'Assault Rifle',
        category: 'Weapon',
      ),
      RustItem(
        shortname: 'rifle.lr300',
        displayName: 'LR-300',
        category: 'Weapon',
      ),
      RustItem(
        shortname: 'rifle.bolt',
        displayName: 'Bolt Action Rifle',
        category: 'Weapon',
      ),
      RustItem(
        shortname: 'bow.hunting',
        displayName: 'Hunting Bow',
        category: 'Weapon',
      ),
      RustItem(
        shortname: 'crossbow',
        displayName: 'Crossbow',
        category: 'Weapon',
      ),
      RustItem(
        shortname: 'pistol.revolver',
        displayName: 'Revolver',
        category: 'Weapon',
      ),
      RustItem(
        shortname: 'pistol.python',
        displayName: 'Python Revolver',
        category: 'Weapon',
      ),
      RustItem(
        shortname: 'shotgun.pump',
        displayName: 'Pump Shotgun',
        category: 'Weapon',
      ),
      RustItem(
        shortname: 'smg.thompson',
        displayName: 'Thompson',
        category: 'Weapon',
      ),
      RustItem(
        shortname: 'smg.mp5',
        displayName: 'MP5A4',
        category: 'Weapon',
      ),

      // Resources
      RustItem(
        shortname: 'wood',
        displayName: 'Wood',
        category: 'Resource',
      ),
      RustItem(
        shortname: 'stones',
        displayName: 'Stones',
        category: 'Resource',
      ),
      RustItem(
        shortname: 'metal.ore',
        displayName: 'Metal Ore',
        category: 'Resource',
      ),
      RustItem(
        shortname: 'sulfur.ore',
        displayName: 'Sulfur Ore',
        category: 'Resource',
      ),
      RustItem(
        shortname: 'metal.fragments',
        displayName: 'Metal Fragments',
        category: 'Resource',
      ),
      RustItem(
        shortname: 'sulfur',
        displayName: 'Sulfur',
        category: 'Resource',
      ),
      RustItem(
        shortname: 'charcoal',
        displayName: 'Charcoal',
        category: 'Resource',
      ),
      RustItem(
        shortname: 'cloth',
        displayName: 'Cloth',
        category: 'Resource',
      ),
      RustItem(
        shortname: 'scrap',
        displayName: 'Scrap',
        category: 'Resource',
      ),

      // Ammo
      RustItem(
        shortname: 'ammo.rifle',
        displayName: '5.56 Rifle Ammo',
        category: 'Ammo',
      ),
      RustItem(
        shortname: 'ammo.rifle.explosive',
        displayName: 'Explosive 5.56 Rifle Ammo',
        category: 'Ammo',
      ),
      RustItem(
        shortname: 'ammo.pistol',
        displayName: 'Pistol Bullet',
        category: 'Ammo',
      ),
      RustItem(
        shortname: 'ammo.shotgun',
        displayName: '12 Gauge Buckshot',
        category: 'Ammo',
      ),
      RustItem(
        shortname: 'arrow.wooden',
        displayName: 'Wooden Arrow',
        category: 'Ammo',
      ),

      // Medical
      RustItem(
        shortname: 'syringe.medical',
        displayName: 'Medical Syringe',
        category: 'Medical',
      ),
      RustItem(
        shortname: 'largemedkit',
        displayName: 'Large Medkit',
        category: 'Medical',
      ),
      RustItem(
        shortname: 'bandage',
        displayName: 'Bandage',
        category: 'Medical',
      ),

      // Food
      RustItem(
        shortname: 'apple',
        displayName: 'Apple',
        category: 'Food',
      ),
      RustItem(
        shortname: 'corn',
        displayName: 'Corn',
        category: 'Food',
      ),
      RustItem(
        shortname: 'pumpkin',
        displayName: 'Pumpkin',
        category: 'Food',
      ),
      RustItem(
        shortname: 'fish.cooked',
        displayName: 'Cooked Fish',
        category: 'Food',
      ),
      RustItem(
        shortname: 'meat.cooked',
        displayName: 'Cooked Meat',
        category: 'Food',
      ),
    ];
  }

  /// Searches items by query.
  Future<List<RustItem>> searchItems(String query) async {
    final List<RustItem> items = await fetchItems();
    if (query.isEmpty) return items;

    final String lowerQuery = query.toLowerCase();
    return items.where((RustItem item) {
      return item.shortname.toLowerCase().contains(lowerQuery) ||
          item.displayName.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}

/// Rust item model.
class RustItem {
  /// Creates a new RustItem.
  const RustItem({
    required this.shortname,
    required this.displayName,
    required this.category,
    this.imageUrl,
  });

  /// Item shortname.
  final String shortname;

  /// Display name.
  final String displayName;

  /// Category.
  final String category;

  /// Optional image URL.
  final String? imageUrl;

  @override
  String toString() => '$displayName ($shortname)';
}
