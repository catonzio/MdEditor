import 'package:get/get.dart';
import 'package:mdown_editor/configs/routes.dart';
import 'package:mdown_editor/data/bindings/home_bindings.dart';
import 'package:mdown_editor/views/home_page.dart';

class Pages {
  static Map<String, GetPage> get pages => {
        Routes.homePage: GetPage(
            name: Routes.homePage,
            page: () => HomePage(),
            binding: HomeBindings()),
      };
}
