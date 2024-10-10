import 'package:get/get.dart';

import '../modules/hi/bindings/hi_binding.dart';
import '../modules/hi/views/hi_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/personal_info/bindings/personal_info_binding.dart';
import '../modules/personal_info/views/personal_info_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/tab_account/bindings/tab_account_binding.dart';
import '../modules/tab_account/views/tab_account_view.dart';
import '../modules/tab_home/bindings/tab_home_binding.dart';
import '../modules/tab_home/views/tab_home_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.TAB_ACCOUNT,
      page: () => const TabAccountView(),
      binding: TabAccountBinding(),
    ),
    GetPage(
      name: _Paths.TAB_HOME,
      page: () => const TabHomeView(),
      binding: TabHomeBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO,
      page: () => const PersonalInfoView(),
      binding: PersonalInfoBinding(),
    ),
    GetPage(
      name: _Paths.HI,
      page: () => const HiView(),
      binding: HiBinding(),
    ),
  ];
}
