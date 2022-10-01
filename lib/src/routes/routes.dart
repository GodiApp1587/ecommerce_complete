import 'package:get/route_manager.dart';

import '../controllers/auth/auth_binding.dart';
import '../controllers/home/home_binding.dart';
import '../views/authentication/login_page.dart';
import '../views/authentication/register_page.dart';
import '../views/authentication/splash_screen.dart';
import '../views/home/home_page.dart';

class Routes {
  static const initial = '/splash';

  static final routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashPage(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: '/product/:id',
    //   page: () => const ProductPage(),
    //   binding: ProductBinding(),
    // )
  ];
}
