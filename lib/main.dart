import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mdown_editor/configs/pages.dart';
import 'package:mdown_editor/configs/routes.dart';
import 'package:mdown_editor/data/bindings/initial_bindings.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mdwon Editor',
      theme: ThemeData.dark(useMaterial3: true),
      initialBinding: InitialBindings(),
      initialRoute: Routes.homePage,
      getPages: Pages.pages.values.toList(),
    );
  }
}
