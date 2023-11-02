import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/mdown_controller.dart';

class MdownWidget extends StatelessWidget {
  final MdownController controller = Get.find<MdownController>();

  MdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Markdown(
              data: controller.mdownContent,
              controller: controller.scrollController,
              selectable: true,
              styleSheet: MarkdownStyleSheet.fromTheme(Get.theme),
              
            )));
  }
}
