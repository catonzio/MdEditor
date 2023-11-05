import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxDouble _leftWidth = 0.5.obs;
  double get leftWidth => _leftWidth.value;
  set leftWidth(value) {
    if (Get.context != null) {
      _leftWidth.value = value.clamp(0.1, 0.9);
    } else {
      _leftWidth.value = value;
    }
  }

  final RxBool _isLeftEditor = true.obs;
  bool get isLeftEditor => _isLeftEditor.value;
  set isLeftEditor(value) => _isLeftEditor.value = value;

  final RxBool _vertical = false.obs;
  bool get vertical => _vertical.value;
  set vertical(value) => _vertical.value = value;

  final RxBool _preview = true.obs;
  bool get preview => _preview.value;
  set preview(value) => _preview.value = value;
}
