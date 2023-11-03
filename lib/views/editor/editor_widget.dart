import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/editor_controllers/editor_controller.dart';
import 'package:mdown_editor/views/editor/editor_line.dart';

class EditorWidget extends StatelessWidget {
  final EditorController controller = Get.find<EditorController>();

  EditorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      child: Obx(() => Stack(
            children: [
              GestureDetector(
                onTapDown: (details) {
                  controller.handleClick(details);
                },
                child: Focus(
                  autofocus: true,
                  onKey: (FocusNode node, RawKeyEvent event) {
                    controller.handleKeyboardInput(event);
                    return KeyEventResult.handled;
                  },
                  child: ListView.builder(
                    itemCount: controller.linesCount,
                    itemBuilder: (context, index) {
                      return EditorLine(
                          lineNumber: index,
                          text: controller.lineText(index),
                          controller: controller);
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(
                    "<${controller.cursorLine + 1}, ${controller.cursorColumn + 1}>"),
              ),
            ],
          )),
    );
  }
}
