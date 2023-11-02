import 'package:mdown_editor/data/controllers/header_controllers/header_btn_controller.dart';

class EditController extends HeaderBtnController {
  EditController({required super.name});

  @override
  void initActionTaps() {
    actionTaps = {
      "Undo": undo,
      "Redo": redo,
      "Cut": cut,
      "Copy": copy,
      "Paste": paste,
      "Delete": delete,
      "Select all": selectAll,
      "Find": find,
      "Replace": replace,
      "Find in files": findInFiles,
      "Replace in files": replaceInFiles
    };
  }

  void undo() {
    print("Undo");
  }

  void redo() {
    print("Redo");
  }

  void cut() {
    print("Cut");
  }

  void copy() {
    print("Copy");
  }

  void paste() {
    print("Paste");
  }

  void delete() {
    print("Delete");
  }

  void selectAll() {
    print("Select all");
  }

  void find() {
    print("Find");
  }

  void replace() {
    print("Replace");
  }

  void findInFiles() {
    print("Find in files");
  }

  void replaceInFiles() {
    print("Replace in files");
  }
}
