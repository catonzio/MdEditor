import 'package:flutter/widgets.dart';

Size getTextSize(String text, TextStyle style) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  );
  textPainter.layout();
  return textPainter.size;
}

double getLineNumbersOffset(TextStyle style, int linesCount) {
  return style.fontSize! * (linesCount.toString().length) * 3 / 2;
}
