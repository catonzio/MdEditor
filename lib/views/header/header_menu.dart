import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/header_controllers/header_controller.dart';
import 'package:mdown_editor/views/header/header_button.dart';

class HeaderMenu extends StatelessWidget {
  final HeaderController controller = Get.find<HeaderController>();
  HeaderMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: context.height * 0.04,
        width: context.width,
        child: ListView.builder(
            itemCount: controller.buttonsControllers.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => HeaderButton(
                controller:
                    controller.buttonsControllers.values.toList()[index])));
  }
}
