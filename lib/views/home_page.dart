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

  List<Widget> get getMainContent {
    Widget leftWidget = controller.preview
        ? (controller.isLeftEditor ? EditorWidget() : MdownWidget())
        : EditorWidget();
    Widget rightWidget = controller.preview
        ? (controller.isLeftEditor ? MdownWidget() : EditorWidget())
        : EditorWidget();
    return [
      Obx(() => Expanded(
          flex: (controller.leftWidth * 100).toInt(), child: leftWidget)),
      if (controller.preview)
        Obx(() => Expanded(
            flex: ((1 - controller.leftWidth) * 100).toInt(),
            child: rightWidget))
    ];
  }

  @override
  Widget build(BuildContext context) {
    double headerHeight = context.height * 0.04;
    double middleDividerWidth = context.width * 0.03;
    double middleDividerHeight = context.height * 0.03;
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: false,
      appBar: AppBar(
        flexibleSpace: Center(child: HeaderMenu()),
        toolbarHeight: headerHeight.clamp(25, 35),
        elevation: 3,
        scrolledUnderElevation: 3,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(() => controller.vertical
              ? Column(children: getMainContent)
              : Row(children: getMainContent)),
          Obx(() => controller.preview
              ? Positioned(
                  top: controller.vertical
                      ? controller.leftWidth * context.height -
                          (middleDividerHeight / 2)
                      : 0,
                  height: controller.vertical
                      ? middleDividerHeight
                      : context.height,
                  left: controller.vertical
                      ? 0
                      : controller.leftWidth * context.width -
                          (middleDividerWidth / 2),
                  width:
                      controller.vertical ? context.width : middleDividerWidth,
                  child: MiddleDivider(
                    barHorPadding: middleDividerWidth * 0.4,
                    barVerPadding: middleDividerHeight * 0.4,
                  ))
              : Container())
        ],
      ),
    ));
  }
}
