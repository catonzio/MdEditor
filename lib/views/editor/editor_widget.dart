import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/editor_controllers/editor_controller.dart';
import 'package:mdown_editor/extensions/context_extensions.dart';
import 'package:mdown_editor/views/editor/editor_line.dart';

class EditorWidget extends StatelessWidget {
  final EditorController controller = Get.find<EditorController>();

  EditorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF772E25),
      padding: context.padding16,
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
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();

                      return true;
                    },
                    child: ListView.builder(
                      key: controller.scrollableKey,
                      itemCount: controller.linesCount,
                      controller: controller.scrollController,
                      physics: const ClampingScrollPhysics(),
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return EditorLine(
                            lineNumber: index,
                            text: controller.lineText(index),
                            controller: controller);
                      },
                    ),
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

  EdgeInsets padding16(BuildContext context) {
    return EdgeInsets.symmetric(
        horizontal: context.width * 0.01, vertical: context.height * 0.01);
  }
}
