import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/editor_controller.dart';

class EditorWidget extends StatelessWidget {
  final EditorController controller = Get.find<EditorController>();

  EditorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        child: Expanded(
          child: QuillProvider(
            configurations: QuillConfigurations(
              controller: controller.quillController,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('it'),
              ),
            ),
            child: QuillEditor.basic(
              configurations: const QuillEditorConfigurations(
                readOnly: false,
              ),
              scrollController: controller.scrollController,
            ),
          ),
        ));
  }
}
