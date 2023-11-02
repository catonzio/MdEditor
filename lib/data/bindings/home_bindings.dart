import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/editor_controller.dart';
import 'package:mdown_editor/data/controllers/home_controller.dart';
import 'package:mdown_editor/data/controllers/mdown_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(EditorController(mdownController: Get.put(MdownController())));
  }
}
