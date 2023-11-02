import 'package:get/get.dart';

abstract class HeaderBtnController extends GetxController {
  final String name;
  Map<String, Function> actionTaps = {};

  HeaderBtnController({required this.name}) {
    initActionTaps();
  }

  void initActionTaps();

  void onActionTap(String action) {
    print("Tapped $action");
    (actionTaps[action] ?? defaultAction)();
  }

  void defaultAction() {
    print("Default action");
  }
}
