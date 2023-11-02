import 'package:mdown_editor/data/controllers/header_controllers/header_btn_controller.dart';

class PreferencesController extends HeaderBtnController {
  PreferencesController({required super.name});

  @override
  void initActionTaps() {
    actionTaps = {
      "Settings": settings,
      "Keyboard shortcuts": keyboardShortcuts,
      "Color theme": colorTheme,
      "File icon theme": fileIconTheme,
      "Preferences": preferences
    };
  }

  void settings() {
    print("Settings");
  }

  void keyboardShortcuts() {
    print("Keyboard shortcuts");
  }

  void colorTheme() {
    print("Color theme");
  }

  void fileIconTheme() {
    print("File icon theme");
  }

  void preferences() {
    print("Preferences");
  }
}
