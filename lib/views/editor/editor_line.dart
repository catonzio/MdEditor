import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/editor_controllers/editor_controller.dart';
import 'package:mdown_editor/extensions/context_extensions.dart';
import 'package:mdown_editor/utils.dart';

class EditorLine extends StatelessWidget {
  final int lineNumber;
  final String text;
  final EditorController controller;

  const EditorLine(
      {super.key,
      required this.lineNumber,
      required this.text,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    double offset = getLineNumbersOffset(
        context.textTheme.bodyMedium!, controller.linesCount);
    Size cursorSize = getTextSize('|', context.textTheme.bodyMedium!);
    // print(controller.document.cursor.hasSelection);
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: offset),
          child: Container(
            width: double.maxFinite,
            color: controller.cursorLine == lineNumber
                ? context.colorScheme.onSurface.withOpacity(0.1)
                : Colors.transparent,
            child: RichText(
              text: TextSpan(
                mouseCursor: MaterialStateMouseCursor.textable,
                text: text,
                style: context.textTheme.bodyMedium,
              ),
              softWrap: true,
              selectionColor: Colors.blue,
            ),
          ),
        ),
        // line number
        Container(
          width: offset * 2 / 3,
          alignment: Alignment.centerRight,
          color: context.colorScheme.onSurface.withOpacity(0.1),
          child: Text("${lineNumber + 1}"),
        ),
        // the cursor
        Obx(() => controller.cursorLine == lineNumber
            ? Positioned(
                left: offset +
                    controller.getCursorOffset(
                        text, context.textTheme.bodyMedium!),
                child: Container(
                  width: 1,
                  height: cursorSize.height,
                  color: Colors.red,
                ),
              )
            : Container())
      ],
    );
  }
}
