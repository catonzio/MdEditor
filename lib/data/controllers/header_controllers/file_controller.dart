import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/header_controllers/header_btn_controller.dart';

class FileController extends HeaderBtnController {
  final RxString _filePath = "".obs;
  String get filePath => _filePath.value;
  set filePath(value) => _filePath.value = value;

  final RxString _fileName = "".obs;
  String get fileName => _fileName.value;
  set fileName(value) => _fileName.value = value;

  FileController({required super.name});

  @override
  void initActionTaps() {
    actionTaps = {
      "New file": newFile,
      "Open file": openFile,
      "Open folder": openFolder,
      "Save": save,
      "Save as": saveAs,
      "Save all": saveAll,
      "Close file": closeFile,
      "Close folder": closeFolder,
      "Close all": closeAll
    };
  }

  void newFile() {
    print("New file");
  }

  void openFile() {
    print("Open file");
  }

  void openFolder() {
    print("Open folder");
  }

  void save() {
    print("Saving file");
  }

  void saveAs() {
    print("Save as");
  }

  void saveAll() {
    print("Save all");
  }

  void closeFile() {
    print("Close file");
  }

  void closeFolder() {
    print("Close folder");
  }

  void closeAll() {
    print("Close all");
  }
}
