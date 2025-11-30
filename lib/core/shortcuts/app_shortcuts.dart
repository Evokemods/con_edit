import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Application keyboard shortcuts.
///
/// Defines keyboard shortcuts and actions for the config editor.
class AppShortcuts {
  AppShortcuts._();

  /// Shortcuts for the config editor.
  static final Set<ShortcutActivator> editorShortcuts = <ShortcutActivator>{
    // Save
    const SingleActivator(LogicalKeyboardKey.keyS, control: true),
    // Open
    const SingleActivator(LogicalKeyboardKey.keyO, control: true),
    // Undo
    const SingleActivator(LogicalKeyboardKey.keyZ, control: true),
    // Redo
    const SingleActivator(LogicalKeyboardKey.keyY, control: true),
    // Search
    const SingleActivator(LogicalKeyboardKey.keyF, control: true),
  };

  /// Actions for the config editor.
  static final Map<Type, Action<Intent>> editorActions = <Type, Action<Intent>>{
    SaveIntent: SaveAction(),
    OpenIntent: OpenAction(),
    UndoIntent: UndoAction(),
    RedoIntent: RedoAction(),
    SearchIntent: SearchAction(),
  };
}

/// Intent for save action.
class SaveIntent extends Intent {
  /// Creates a new SaveIntent.
  const SaveIntent();
}

/// Intent for open action.
class OpenIntent extends Intent {
  /// Creates a new OpenIntent.
  const OpenIntent();
}

/// Intent for undo action.
class UndoIntent extends Intent {
  /// Creates a new UndoIntent.
  const UndoIntent();
}

/// Intent for redo action.
class RedoIntent extends Intent {
  /// Creates a new RedoIntent.
  const RedoIntent();
}

/// Intent for search action.
class SearchIntent extends Intent {
  /// Creates a new SearchIntent.
  const SearchIntent();
}

/// Action for save.
class SaveAction extends Action<SaveIntent> {
  /// Creates a new SaveAction.
  SaveAction();

  @override
  Object? invoke(SaveIntent intent) {
    // This will be handled by the widget that uses the shortcut
    return null;
  }
}

/// Action for open.
class OpenAction extends Action<OpenIntent> {
  /// Creates a new OpenAction.
  OpenAction();

  @override
  Object? invoke(OpenIntent intent) {
    // This will be handled by the widget that uses the shortcut
    return null;
  }
}

/// Action for undo.
class UndoAction extends Action<UndoIntent> {
  /// Creates a new UndoAction.
  UndoAction();

  @override
  Object? invoke(UndoIntent intent) {
    // This will be handled by the widget that uses the shortcut
    return null;
  }
}

/// Action for redo.
class RedoAction extends Action<RedoIntent> {
  /// Creates a new RedoAction.
  RedoAction();

  @override
  Object? invoke(RedoIntent intent) {
    // This will be handled by the widget that uses the shortcut
    return null;
  }
}

/// Action for search.
class SearchAction extends Action<SearchIntent> {
  /// Creates a new SearchAction.
  SearchAction();

  @override
  Object? invoke(SearchIntent intent) {
    // This will be handled by the widget that uses the shortcut
    return null;
  }
}
