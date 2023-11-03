import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/editor_controllers/document_service.dart';
import 'package:mdown_editor/data/controllers/editor_controllers/editor_controller.dart';
import 'package:mdown_editor/data/controllers/editor_controllers/input_service.dart';
import 'package:mdown_editor/data/controllers/mdown_controller.dart';

class EditorBindings extends Bindings {
  @override
  void dependencies() {
    final DocumentService documentService =
        Get.put<DocumentService>(DocumentService());
    final InputService inputService =
        Get.put<InputService>(InputService(document: documentService));

    Get.put(EditorController(
        mdownController: Get.put(MdownController()),
        documentService: documentService,
        inputService: inputService));
  }
}
