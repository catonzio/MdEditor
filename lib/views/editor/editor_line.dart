import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/editor_controllers/editor_controller.dart';
import 'package:mdown_editor/data/models/highlighter.dart';
import 'package:mdown_editor/extensions/context_extensions.dart';
import 'package:mdown_editor/utils.dart';

class EditorLine extends StatelessWidget {
  final int lineNumber;
  final String text;
  final EditorController controller;
  final Highlighter highlighter = Highlighter();

  EditorLine(
      {super.key,
      required this.lineNumber,
      required this.text,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    double offset = getLineNumbersOffset(
        context.textTheme.bodyMedium!, controller.linesCount);

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: offset),
          child: Container(
            width: double.maxFinite,
            color: controller.cursorLine == lineNumber
                ? context.colorScheme.onSurface.withOpacity(0.05)
                : Colors.transparent,
            child: RichText(
              text: TextSpan(
                  mouseCursor: MaterialStateMouseCursor.textable,
                  children: highlighter.run(
                      text, lineNumber, controller.documentService)),
              softWrap: true,
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
      ],
    );
  }

}
