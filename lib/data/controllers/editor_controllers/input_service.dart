import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/editor_controllers/document_service.dart';
import 'dart:math' as math;

import 'package:mdown_editor/utils.dart';

class InputService extends GetxService {
  final DocumentService document;

  late Map<String, Function(RawKeyEvent)> events;

  InputService({required this.document});

  @override
  void onInit() {
    super.onInit();
    events = {
      'Home': (RawKeyEvent event) {
        if (event.isControlPressed) {
          document.goStartOfDocument();
          return true;
        } else {
          document.goStartOfLine();
          return false;
        }
      },
      'End': (RawKeyEvent event) {
        if (event.isControlPressed) {
          document.goEndOfDocument();
          return true;
        } else {
          document.goEndOfLine();
          return false;
        }
      },
      'Arrow Up': (RawKeyEvent event) {
        document.goUp();
        return true;
      },
      'Arrow Down': (RawKeyEvent event) {
        document.goDown();
        return true;
      },
      'Arrow Left': (RawKeyEvent event) {
        document.goLeft();
        return true;
      },
      'Arrow Right': (RawKeyEvent event) {
        document.goRight();
        return true;
      },
      'Enter': (RawKeyEvent event) {
        document.insertNewLine();
        return true;
      },
      'Backspace': (RawKeyEvent event) {
        if (document.cursor.hasSelection) {
          document.deleteSelectedText();
        } else {
          document.goLeft();
          document.deleteText();
        }
        return false;
      },
      'Delete': (RawKeyEvent event) {
        if (document.cursor.hasSelection) {
          document.deleteSelectedText();
        } else {
          document.deleteText();
        }
        return false;
      },
      'Tab': (RawKeyEvent event) {
        document.insertTab();
        return false;
      },
      ' ': (RawKeyEvent event) {
        document.insertText(' ');
        return false;
      }
    };
  }

  bool handleKeyboardInput(RawKeyEvent event) {
    if (event is! RawKeyUpEvent) return false;

    document.isControlPressed = event.isControlPressed;
    document.isShiftPressed = event.isShiftPressed;

    if (events.containsKey(event.logicalKey.keyLabel)) {
      return events[event.logicalKey.keyLabel]!(event);
    }
    int k = event.logicalKey.keyId;
    String char = event.logicalKey.keyLabel;

    if (isLetter(k)) {
      if (event.isShiftPressed) {
        document.insertText(char.toUpperCase());
      } else {
        document.insertText(char.toLowerCase());
      }
      if (event.isControlPressed) {
        document.command('ctrl+${char.toLowerCase()}');
      }
      return false;
    }
    if (isNumber(char)) {
      document.insertText(char.contains("Numpad")
          ? char.replaceAll("Numpad", "").trim()
          : char.toString());
    }
    return false;
    // if (isLetter(k) && event.isControlPressed) {
    //   String ch =
    //       String.fromCharCode(97 + k - LogicalKeyboardKey.keyA.keyId);

    //   document.command('ctrl+$ch');
    // } else {
    //   String char = event.logicalKey.keyLabel;
    //   if (char.contains('Numpad')) {
    //     char = char.replaceAll("Numpad", "").trim();
    //   }
    //   if (!char.contains("Shift") && !char.contains("Alt")) {
    //     document.insertText(char);
    //   }
    // }
  }

  void handleClick(TapDownDetails details) {
    if (Get.context == null) {
      return;
    }
    final RenderBox box = Get.context!.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    // final Offset localOffset = details.localPosition;
    int lineNumber = getLineNumberFromOffset(localOffset);

    int column = getColumnNumberFromOffset(lineNumber, localOffset);
    // Now you can set the cursor position
    document.cursor.line = lineNumber;
    document.cursor.column = column;
  }

  int getColumnNumberFromOffset(int lineNumber, Offset localOffset) {
    double offset = getLineNumbersOffset(
        Get.context!.textTheme.bodyMedium!, document.lines.length);

    String line = document.lines[lineNumber];
    final int column;
    if (line.isEmpty) {
      column = 0;
    } else {
      final double lineWidth =
          getTextSize(line, Get.context!.textTheme.bodyMedium!).width;
      column = math.min(line.length,
          ((localOffset.dx - offset) / lineWidth * line.length).floor() - 2);
    }
    return column;
  }

  int getLineNumberFromOffset(Offset localOffset) {
    String text = document.lines.where((l) => l.isNotEmpty).first;
    // Calculate line number
    final double lineHeight =
        getTextSize(text, Get.context!.textTheme.bodyMedium!)
            .height; // adjust this as needed
    final int lineNumber = math.max(
        0,
        math.min((localOffset.dy / lineHeight).floor() - 2,
            document.lines.length - 1));
    return lineNumber;
  }
}

bool isNumber(String label) {
  return label.contains('Numpad') ||
      (label.length == 1 &&
          label.codeUnitAt(0) >= LogicalKeyboardKey.digit0.keyId &&
          label.codeUnitAt(0) <= LogicalKeyboardKey.digit9.keyId);
}

bool isLetter(int k) {
  return (k >= LogicalKeyboardKey.keyA.keyId &&
          k <= LogicalKeyboardKey.keyZ.keyId) ||
      (k + 32 >= LogicalKeyboardKey.keyA.keyId &&
          k + 32 <= LogicalKeyboardKey.keyZ.keyId);
}
