import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app_binding.dart';
import 'src/controllers/auth/auth_controller.dart';
import 'src/controllers/themes/themes_controller.dart';
import 'src/routes/routes.dart';
import 'src/shared/widgets/constant/firebase_constant.dart';
import 'src/themes/themes.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) => {
        Get.put(AuthController()),
      });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemesController themesController = Get.put(ThemesController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Godi',
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: getThemeMode(themesController.theme),
      getPages: Routes.routes,
      initialBinding: AppBinding(),
      initialRoute: Routes.initial,
    );
  }
}

ThemeMode getThemeMode(String type) {
  ThemeMode themeMode = ThemeMode.system;
  switch (type) {
    case "system":
      themeMode = ThemeMode.system;
      break;
    case "dark":
      themeMode = ThemeMode.dark;
      break;
    default:
      themeMode = ThemeMode.light;
      break;
  }

  return themeMode;
}
