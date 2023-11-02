import 'package:mdown_editor/data/controllers/header_controllers/header_btn_controller.dart';

class HelpController extends HeaderBtnController {
  HelpController({required super.name});

  @override
  void initActionTaps() {
    actionTaps = {
      "Welcome": welcome,
      "Documentation": documentation,
      "Release notes": releaseNotes,
      "Report issues": reportIssues
    };
  }

  void welcome() {
    print("Welcome");
  }

  void documentation() {
    print("Documentation");
  }

  void releaseNotes() {
    print("Release notes");
  }

  void reportIssues() {
    print("Report issues");
  }
}
