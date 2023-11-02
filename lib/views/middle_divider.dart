import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/home_controller.dart';
import 'package:mdown_editor/extensions/context_extensions.dart';

class MiddleDivider extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final double barHorPadding;
  MiddleDivider({super.key, required this.barHorPadding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final totalWidth = context.width;
        final delta = details.delta.dx / totalWidth;
        controller.leftWidth += delta;
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              left: barHorPadding,
              right: barHorPadding,
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
      // child: Container(
      //   color: Colors.grey,
      //   width: context.width * 0.01,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       InkWell(
      //         onTap: () => controller.isLeftEditor = !controller.isLeftEditor,
      //         child: Container(
      //           decoration: BoxDecoration(shape: BoxShape.circle),
      //           child: Icon(
      //             Icons.swap_horiz_rounded,
      //             fill: 1,
      //             size: context.width * 0.01,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
