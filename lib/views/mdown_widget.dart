import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/mdown_controller.dart';
import 'package:mdown_editor/extensions/context_extensions.dart';

class MdownWidget extends StatelessWidget {
  final MdownController controller = Get.find<MdownController>();

  MdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF283D3B),
      child: Padding(
          padding: context.padding16,
          child: Obx(() => Markdown(
                data: controller.mdownContent,
                controller: controller.scrollController,
                selectable: true,
                styleSheet: MarkdownStyleSheet.fromTheme(Get.theme),
              ))),
    );
  }
}
