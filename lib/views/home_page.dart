import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/home_controller.dart';
import 'package:mdown_editor/views/editor/editor_widget.dart';
import 'package:mdown_editor/views/header/header_menu.dart';
import 'package:mdown_editor/views/mdown_widget.dart';
import 'package:mdown_editor/views/middle_divider.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double middleDividerWidth = context.width * 0.03;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          HeaderMenu(),
          Expanded(
            child: Stack(
              children: [
                Row(children: [
                  Obx(() => Expanded(
                      flex: (controller.leftWidth * 100).toInt(),
                      child: controller.isLeftEditor
                          ? EditorWidget()
                          : MdownWidget())),
                  Obx(() => Expanded(
                      flex: ((1 - controller.leftWidth) * 100).toInt(),
                      child: controller.isLeftEditor
                          ? MdownWidget()
                          : EditorWidget()))
                ]),
                Obx(
                  () => Positioned(
                      top: 0,
                      bottom: 0,
                      left: controller.leftWidth * context.width -
                          (middleDividerWidth / 2),
                      width: middleDividerWidth,
                      child: MiddleDivider(
                        barHorPadding: middleDividerWidth * 0.4,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
