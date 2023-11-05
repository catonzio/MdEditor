import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/editor_controllers/basic_file.dart';
import 'package:mdown_editor/data/models/cursor.dart';

class DocumentService extends GetxService {
  RxList<String> lines =
      contentList.obs; // ["ciao a tutti", "come va?", "bene grazie"].obs;

  Cursor cursor = Cursor();

  bool isControlPressed = false;
  bool isShiftPressed = false;

  final RxString _clipboardText = ''.obs;
  String get clipboardText => _clipboardText.value;
  set clipboardText(String text) => _clipboardText.value = text;

  void _validateCursor(bool keepAnchor) {
    if (cursor.line >= lines.length) {
      cursor.line = lines.length - 1;
    }
    if (cursor.line < 0) cursor.line = 0;
    if (cursor.column > lines[cursor.line].length) {
      cursor.column = lines[cursor.line].length;
    }
    if (cursor.column == -1) cursor.column = lines[cursor.line].length;
    if (cursor.column < 0) cursor.column = 0;
    if (!keepAnchor) {
      cursor.anchorLine = cursor.line;
      cursor.anchorColumn = cursor.column;
    }
  }

  void moveCursor(int line, int column, {bool keepAnchor = false}) {
    cursor.line = line;
    cursor.column = column;
    _validateCursor(keepAnchor);
  }

  void goLeft({int count = 1, bool keepAnchor = false}) {
    cursor.column = cursor.column - count;
    if (cursor.column < 0) {
      goUp(keepAnchor: keepAnchor);
      goEndOfLine(keepAnchor: keepAnchor);
    }
    _validateCursor(keepAnchor);
  }

  void goRight({int count = 1, bool keepAnchor = false}) {
    cursor.column = cursor.column + count;
    if (cursor.column > lines[cursor.line].length) {
      goDown(keepAnchor: keepAnchor);
      goStartOfLine(keepAnchor: keepAnchor);
    }
    _validateCursor(keepAnchor);
  }

  void goUp({int count = 1, bool keepAnchor = false}) {
    cursor.line = cursor.line - count;
    _validateCursor(keepAnchor);
  }

  void goDown({int count = 1, bool keepAnchor = false}) {
    cursor.line = cursor.line + count;
    _validateCursor(keepAnchor);
  }

  void goStartOfLine({bool keepAnchor = false}) {
    cursor.column = 0;
    _validateCursor(keepAnchor);
  }

  void goEndOfLine({bool keepAnchor = false}) {
    cursor.column = lines[cursor.line].length;
    _validateCursor(keepAnchor);
  }

  void goStartOfDocument({bool keepAnchor = false}) {
    cursor.line = 0;
    cursor.column = 0;
    _validateCursor(keepAnchor);
  }

  void goEndOfDocument({bool keepAnchor = false}) {
    cursor.line = lines.length - 1;
    cursor.column = lines[cursor.line].length;
    _validateCursor(keepAnchor);
  }

  void insertNewLine() {
    deleteSelectedText();
    insertText('\n');
  }

  void insertText(String text) {
    deleteSelectedText();
    String l = lines[cursor.line];
    String left = l.substring(0, cursor.column);
    String right = l.substring(cursor.column);

    // handle new line
    if (text == '\n') {
      lines[cursor.line] = left;
      lines.insert(cursor.line + 1, right);
      goDown();
      goStartOfLine();
      return;
    }

    lines[cursor.line] = left + text + right;
    goRight(count: text.length);
  }

  void insertTab() {
    insertText('  ');
  }

  void deleteText({int numberOfCharacters = 1}) {
    String l = lines[cursor.line];

    // handle join lines
    if (cursor.column >= l.length) {
      // Cursor cur = cursor.copyWith();
      // lines[cursor.line] += lines[cursor.line + 1];
      // goDown();
      // deleteLine();
      // cursor = cur;
      lines.removeAt(cursor.line);
      goUp();
      goEndOfLine();
      return;
    }

    Cursor cur = cursor.normalized();
    String left = l.substring(0, cur.column);
    String right = l.substring(cur.column + numberOfCharacters);
    cursor = cur;

    // handle erase entire line
    if (lines.length > 1 && (left + right).isEmpty) {
      if (lines[cursor.line].isEmpty) {
        lines.removeAt(cursor.line);
        goUp();
        goEndOfLine();
      } else {
        lines[cursor.line] = "";
      }
      return;
    }

    lines[cursor.line] = left + right;
  }

  void deleteLine({int numberOfLines = 1}) {
    for (int i = 0; i < numberOfLines; i++) {
      goStartOfLine();
      deleteText(numberOfCharacters: lines[cursor.line].length);
    }
    _validateCursor(false);
  }

  List<String> selectedLines() {
    List<String> res = <String>[];
    Cursor cur = cursor.normalized();
    if (cur.line == cur.anchorLine) {
      String sel = lines[cur.line].substring(cur.column, cur.anchorColumn);
      res.add(sel);
      return res;
    }

    res.add(lines[cur.line].substring(cur.column));
    for (int i = cur.line + 1; i < cur.anchorLine; i++) {
      res.add(lines[i]);
    }
    res.add(lines[cur.anchorLine].substring(0, cur.anchorColumn));
    return res;
  }

  String selectedText() {
    return selectedLines().join('\n');
  }

  void deleteSelectedText() {
    if (!cursor.hasSelection) {
      return;
    }

    Cursor cur = cursor.normalized();
    List<String> res = selectedLines();
    if (res.length == 1) {
      print(cur.anchorColumn - cur.column);
      deleteText(numberOfCharacters: cur.anchorColumn - cur.column);
      clearSelection();
      return;
    }

    String l = lines[cur.line];
    String left = l.substring(0, cur.column);
    l = lines[cur.anchorLine];
    String right = l.substring(cur.anchorColumn);

    cursor = cur;
    lines[cur.line] = left + right;
    lines[cur.anchorLine] = lines[cur.anchorLine].substring(cur.anchorColumn);
    for (int i = 0; i < res.length - 1; i++) {
      lines.removeAt(cur.line + 1);
    }
    _validateCursor(false);
  }

  void clearSelection() {
    cursor.anchorLine = cursor.line;
    cursor.anchorColumn = cursor.column;
  }

  void command(String cmd) {
    switch (cmd) {
      case 'ctrl+c':
        clipboardText = selectedText();
        break;
      case 'ctrl+x':
        clipboardText = selectedText();
        deleteSelectedText();
        break;
      case 'ctrl+v':
        insertText(clipboardText);
        break;
      case 'ctrl+s':
        // saveFile();
        break;
    }
  }
}
