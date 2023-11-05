import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/home_controller.dart';
import 'package:mdown_editor/extensions/context_extensions.dart';

class MiddleDivider extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final double barHorPadding;
  final double barVerPadding;
  MiddleDivider(
      {super.key, required this.barHorPadding, required this.barVerPadding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (controller.vertical) {
          final totalHeight = context.height;
          final delta = details.delta.dy / totalHeight;
          controller.leftWidth += delta;
        } else {
          final totalWidth = context.width;
          final delta = details.delta.dx / totalWidth;
          controller.leftWidth += delta;
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              top: controller.vertical ? barVerPadding : 0,
              bottom: controller.vertical ? barVerPadding : 0,
              left: controller.vertical ? 0 : barHorPadding,
              right: controller.vertical ? 0 : barHorPadding,
              child: Container(
                color: context.colorScheme.onBackground,
              )),
          Positioned(
            child: InkWell(
              onTap: () => controller.isLeftEditor = !controller.isLeftEditor,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: context.colorScheme.primary),
                child: Icon(
                  Icons.swap_horiz_rounded,
                  color: context.colorScheme.background,
                  // size: context.width * 0.01,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
