import 'package:get/get.dart';

class Cursor {
  final RxInt _line = 0.obs;
  int get line => _line.value;
  set line(int value) => _line.value = value;

  final RxInt _column = 0.obs;
  int get column => _column.value;
  set column(int value) => _column.value = value;

  final RxInt _anchorLine = 0.obs;
  int get anchorLine => _anchorLine.value;
  set anchorLine(int value) => _anchorLine.value = value;

  final RxInt _anchorColumn = 0.obs;
  int get anchorColumn => _anchorColumn.value;
  set anchorColumn(int value) => _anchorColumn.value = value;

  Cursor({int? line, int? column, int? anchorLine, int? anchorColumn}) {
    this.line = line ?? 0;
    this.column = column ?? 0;
    this.anchorLine = anchorLine ?? 0;
    this.anchorColumn = anchorColumn ?? 0;
  }

  Cursor copyWith(
      {int? line, int? column, int? anchorLine, int? anchorColumn}) {
    return Cursor(
        line: line ?? this.line,
        column: column ?? this.column,
        anchorLine: anchorLine ?? this.anchorLine,
        anchorColumn: anchorColumn ?? this.anchorColumn);
  }

  Cursor normalized() {
    if (line > anchorLine || (line == anchorLine && column > anchorColumn)) {
      return copyWith(
          line: anchorLine,
          column: anchorColumn,
          anchorLine: line,
          anchorColumn: column);
    }
    return copyWith();
  }

  bool get hasSelection => line != anchorLine || column != anchorColumn;
}
