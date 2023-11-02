import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/header_controllers/header_btn_controller.dart';
import 'package:mdown_editor/extensions/context_extensions.dart';

class HeaderButton extends StatelessWidget {
  final HeaderBtnController controller;

  const HeaderButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: PopupMenuButton<String>(
          offset: Offset(0, context.height * 0.03),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                  color: context.colorScheme.onBackground, width: 0.3)),
          tooltip: controller.name,
          elevation: 1,
          itemBuilder: (context) => controller.actionTaps.keys
              .map((e) => PopupMenuItem<String>(
                    child: Text(e),
                    onTap: () => controller.onActionTap(e),
                  ))
              .toList(),
          child: Text(controller.name),
        ));
  }
}
