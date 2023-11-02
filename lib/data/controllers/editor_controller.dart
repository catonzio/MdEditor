import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/mdown_controller.dart';

class EditorController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final QuillController quillController = QuillController.basic();
  final ScrollController scrollController = ScrollController();

  final MdownController mdownController;

  EditorController({required this.mdownController});

  @override
  void onInit() {
    super.onInit();
    quillController.changes.listen((event) {
      mdownController.updateContent(quillController.document.toPlainText());
    });

    mdownController.scrollController.addListener(() {
      onScrollChange(mdownController.scrollController.offset);
    });

    scrollController.addListener(() {
      mdownController.onScrollChange(scrollController.offset);
    });
  }

  @override
  dispose() {
    super.dispose();
    quillController.dispose();
    scrollController.dispose();
  }

  onScrollChange(double offset) {
    // if the new offset is within the boundaries of this offset
    if ((scrollController.position.minScrollExtent <= offset) &&
        (offset <= scrollController.position.maxScrollExtent)) {
      scrollController.jumpTo(offset);
    }
  }
}
