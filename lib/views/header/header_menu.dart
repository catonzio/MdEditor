import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/header_controllers/header_btn_controller.dart';
import 'package:mdown_editor/data/controllers/header_controllers/header_controller.dart';
import 'package:mdown_editor/data/controllers/home_controller.dart';
import 'package:mdown_editor/views/header/header_button.dart';

class HeaderMenu extends StatelessWidget {
  final HeaderController controller = Get.find<HeaderController>();
  final HomeController homeController = Get.find<HomeController>();
  HeaderMenu({super.key});

  @override
  Widget build(BuildContext context) {
    List<HeaderBtnController> list =
        controller.buttonsControllers.values.toList();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 7,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: list.map((e) => HeaderButton(controller: e)).toList()),
        ),
        Expanded(
          flex: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Obx(() => Checkbox(
                    value: homeController.vertical,
                    onChanged: (value) =>
                        homeController.vertical = value ?? false)),
                const Text("Vertical")
              ]),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Obx(() => Checkbox(
                    value: homeController.preview,
                    onChanged: (value) =>
                        homeController.preview = value ?? false)),
                const Text("Preview")
              ]),
            ],
          ),
        )
      ],
    );
  }
}
