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
        } else {
          document.goStartOfLine();
        }
      },
      'End': (RawKeyEvent event) {
        if (event.isControlPressed) {
          document.goEndOfDocument();
        } else {
          document.goEndOfLine();
        }
      },
      'Arrow Up': (RawKeyEvent event) {
        document.goUp();
      },
      'Arrow Down': (RawKeyEvent event) {
        document.goDown();
      },
      'Arrow Left': (RawKeyEvent event) {
        document.goLeft();
      },
      'Arrow Right': (RawKeyEvent event) {
        document.goRight();
      },
      'Enter': (RawKeyEvent event) {
        document.insertNewLine();
      },
      'Backspace': (RawKeyEvent event) {
        if (document.cursor.hasSelection) {
          document.deleteSelectedText();
        } else {
          document.goLeft();
          document.deleteText();
        }
      },
      'Delete': (RawKeyEvent event) {
        if (document.cursor.hasSelection) {
          document.deleteSelectedText();
        } else {
          document.deleteText();
        }
      },
      'Tab': (RawKeyEvent event) {
        document.insertTab();
      },
    };
  }

  void handleKeyboardInput(RawKeyEvent event) {
    if (event.runtimeType.toString() == 'RawKeyDownEvent') {
      if (events.containsKey(event.logicalKey.keyLabel)) {
        events[event.logicalKey.keyLabel]!(event);
      } else {
        int k = event.logicalKey.keyId;
        if ((k >= LogicalKeyboardKey.keyA.keyId &&
                k <= LogicalKeyboardKey.keyZ.keyId) ||
            (k + 32 >= LogicalKeyboardKey.keyA.keyId &&
                k + 32 <= LogicalKeyboardKey.keyZ.keyId)) {
          String ch =
              String.fromCharCode(97 + k - LogicalKeyboardKey.keyA.keyId);
          if (event.isControlPressed) {
            document.command('ctrl+$ch');
          } else {
            document.insertText(ch);
          }
        }
      }
    }
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
