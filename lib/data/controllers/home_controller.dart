import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxDouble _leftWidth = 0.5.obs;
  double get leftWidth => _leftWidth.value;
  set leftWidth(value) => _leftWidth.value = value;

  final RxBool _isLeftEditor = true.obs;
  bool get isLeftEditor => _isLeftEditor.value;
  set isLeftEditor(value) => _isLeftEditor.value = value;
}
