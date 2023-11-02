import 'package:get/get.dart';
import 'package:mdown_editor/data/bindings/header_bindings.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    HeaderBindings().dependencies();
  }
}
