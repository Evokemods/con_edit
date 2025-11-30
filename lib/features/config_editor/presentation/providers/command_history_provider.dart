import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/commands/command.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/config_node.dart';

/// State for command history (undo/redo).
class CommandHistoryState {
  /// Creates a new CommandHistoryState.
  const CommandHistoryState({
    this.undoStack = const <Command>[],
    this.redoStack = const <Command>[],
  });

  /// Stack of commands that can be undone.
  final List<Command> undoStack;

  /// Stack of commands that can be redone.
  final List<Command> redoStack;

  /// Whether undo is available.
  bool get canUndo => undoStack.isNotEmpty;

  /// Whether redo is available.
  bool get canRedo => redoStack.isNotEmpty;

  /// Creates a copy with updated fields.
  CommandHistoryState copyWith({
    List<Command>? undoStack,
    List<Command>? redoStack,
  }) {
    return CommandHistoryState(
      undoStack: undoStack ?? this.undoStack,
      redoStack: redoStack ?? this.redoStack,
    );
  }
}

/// Notifier for command history management.
class CommandHistoryNotifier extends StateNotifier<CommandHistoryState> {
  /// Creates a new CommandHistoryNotifier.
  CommandHistoryNotifier() : super(const CommandHistoryState());


  /// Executes a command and adds it to undo stack.
  ConfigNode executeCommand(ConfigNode rootNode, Command command) {
    final ConfigNode newRoot = command.execute(rootNode);

    // Add to undo stack
    final List<Command> newUndoStack = <Command>[
      ...state.undoStack,
      command,
    ];

    // Limit undo stack size
    final List<Command> limitedUndoStack = newUndoStack.length > AppConstants.maxUndoHistory
        ? newUndoStack.sublist(newUndoStack.length - AppConstants.maxUndoHistory)
        : newUndoStack;

    state = state.copyWith(
      undoStack: limitedUndoStack,
      redoStack: <Command>[], // Clear redo stack when new command is executed
    );

    return newRoot;
  }

  /// Undoes the last command.
  ConfigNode? undo(ConfigNode rootNode) {
    if (!state.canUndo) {
      return null;
    }
    final Command command = state.undoStack.last;
    final ConfigNode newRoot = command.undo(rootNode);

    // Move command from undo to redo stack
    final List<Command> newUndoStack = state.undoStack.sublist(0, state.undoStack.length - 1);
    final List<Command> newRedoStack = <Command>[...state.redoStack, command];

    state = state.copyWith(
      undoStack: newUndoStack,
      redoStack: newRedoStack,
    );

    return newRoot;
  }

  /// Redoes the last undone command.
  ConfigNode? redo(ConfigNode rootNode) {
    if (!state.canRedo) {
      return null;
    }
    final Command command = state.redoStack.last;
    final ConfigNode newRoot = command.execute(rootNode);

    // Move command from redo to undo stack
    final List<Command> newRedoStack = state.redoStack.sublist(0, state.redoStack.length - 1);
    final List<Command> newUndoStack = <Command>[...state.undoStack, command];

    state = state.copyWith(
      undoStack: newUndoStack,
      redoStack: newRedoStack,
    );

    return newRoot;
  }

  /// Clears the command history.
  void clear() {
    state = const CommandHistoryState();
  }
}

/// Provider for command history.
final StateNotifierProvider<CommandHistoryNotifier, CommandHistoryState> commandHistoryProvider =
    StateNotifierProvider<CommandHistoryNotifier, CommandHistoryState>((Ref ref) {
  return CommandHistoryNotifier();
});

