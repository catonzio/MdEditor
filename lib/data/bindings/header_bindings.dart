import 'package:get/get.dart';
import 'package:mdown_editor/data/controllers/header_controllers/edit_controller.dart';
import 'package:mdown_editor/data/controllers/header_controllers/file_controller.dart';
import 'package:mdown_editor/data/controllers/header_controllers/header_controller.dart';
import 'package:mdown_editor/data/controllers/header_controllers/help_controller.dart';
import 'package:mdown_editor/data/controllers/header_controllers/preferences_controller.dart';

class HeaderBindings extends Bindings {
  Map<String, Function> mapp = {
    'File': (String tag) => FileController(name: tag),
    'Edit': (String tag) => EditController(name: tag),
    'Preferences': (String tag) => PreferencesController(name: tag),
    'Help': (String tag) => HelpController(name: tag)
  };

  @override
  void dependencies() {
    final headerController = Get.put(HeaderController());

    for (MapEntry<String, Function> entry in mapp.entries) {
      headerController.buttonsControllers[entry.key] =
          Get.put(entry.value(entry.key), tag: entry.key);
    }
  }
}
