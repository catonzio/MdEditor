import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/home_controller.dart';
import 'package:mdown_editor/data/bindings/editor_bindings.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    EditorBindings().dependencies();
  }
}
