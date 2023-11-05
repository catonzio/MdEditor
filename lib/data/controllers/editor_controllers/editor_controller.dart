import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/editor_controllers/document_service.dart';
import 'package:mdown_editor/data/controllers/editor_controllers/input_service.dart';
import 'package:mdown_editor/data/controllers/mdown_controller.dart';
import 'dart:math' as math;
import 'package:mdown_editor/utils.dart';

class EditorController extends GetxController {
  final DocumentService documentService;
  final InputService inputService;

  final ScrollController scrollController = ScrollController();
  GlobalKey scrollableKey = GlobalKey();

  final MdownController mdownController;

  int get linesCount => documentService.lines.length;
  int get cursorLine => documentService.cursor.line;
  int get cursorColumn => documentService.cursor.column;
  int get anchorLine => documentService.cursor.anchorLine;
  int get anchorColumn => documentService.cursor.anchorColumn;
  String lineText(int index) => documentService.lines[index];

  EditorController(
      {required this.mdownController,
      required this.documentService,
      required this.inputService});

  @override
  void onInit() {
    super.onInit();
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
    // quillController.dispose();
    scrollController.dispose();
  }

  onScrollChange(double offset) {
    // if the new offset is within the boundaries of this offset
    if ((scrollController.position.minScrollExtent <= offset) &&
        (offset <= scrollController.position.maxScrollExtent)) {
      scrollController.jumpTo(offset);
    }
  }

  double getCursorOffset(String lineText, TextStyle style) {
    final textToCursor = lineText.substring(
        0, math.min(documentService.cursor.column, lineText.length));
    final textPainter = TextPainter(
      text: TextSpan(text: textToCursor, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width;
  }

  void handleClick(TapDownDetails details) {
    inputService.handleClick(details);
  }

  void handleKeyboardInput(RawKeyEvent event) {
    bool shouldScroll = inputService.handleKeyboardInput(event);
    double offset =
        getTextSize("|", Get.context!.textTheme.bodyMedium!).height *
            cursorLine;
    if (shouldScroll && isOffsetVisible(offset)) {
      scrollController.jumpTo(offset);
    }
    mdownController.mdownContent = documentService.lines.join("\n");
    // scrollController.jumpTo(offset * cursorLine);
  }

  bool isOffsetVisible(double offset) {
    final RenderObject? renderObject =
        scrollableKey.currentContext?.findRenderObject();
    if (renderObject is RenderBox) {
      final Size size = renderObject.paintBounds.size;
      final double maxScrollExtent =
          size.height - renderObject.constraints.maxHeight;
      return offset >= 0.0 && offset <= maxScrollExtent;
    }
    return false;
  }
}
