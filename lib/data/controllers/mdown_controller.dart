import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MdownController extends GetxController {
  final RxString _mdownContent = "asdasdasd".obs;
  String get mdownContent => _mdownContent.value;
  set mdownContent(value) => _mdownContent.value = value;

  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  onScrollChange(double offset) {
    // if the new offset is within the boundaries of this offset
    if ((scrollController.position.minScrollExtent <= offset) &&
        (offset <= scrollController.position.maxScrollExtent)) {
      scrollController.jumpTo(offset);
    }
  }

  updateContent(String text) {
    mdownContent = text;
  }
}
