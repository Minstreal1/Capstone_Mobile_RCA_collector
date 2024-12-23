import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rca_resident/app/base/base_common.dart';
import 'package:rca_resident/app/resource/util_common.dart';
import 'package:rca_resident/app/routes/app_pages.dart';
import 'package:rca_resident/app/service/auth.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  Rx<String> phoneError = ''.obs;
  Rx<String> passwordError = ''.obs;
  AuthService authService = AuthService();

  final isLoading = false.obs;
  final visiblePassword = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void validationPhone() {
    if (phoneController.text.trim().isEmpty) {
      phoneError.value = 'Số điện thoại không được để trống';
      return;
    }
    if (!phoneController.text.trim().isPhoneNumber) {
      phoneError.value = 'Số điện thoại không đúng định dạng';
      return;
    }
    phoneError.value = '';
  }

  void validationPassword() {
    if (passwordController.text.trim().isEmpty) {
      passwordError.value = 'Mật khẩu không được để trống';
      return;
    }
    passwordError.value = '';
  }

  Future<void> login() async {
    authService
        .login(
            username: phoneController.text,
             password: passwordController.text,
            // username: "huynguyen005",
            // password: "huynguyen005"
            )
        .then((token) {
      BaseCommon.instance.saveToken(token).then((_) {
        if (BaseCommon.instance.accountSession!.role ==
            'ROLE_COLLECTOR') {
          Get.toNamed(Routes.HOME);
        }else{
          UtilCommon.snackBar(text: 'Tài khoản không phải Collector', isFail: true);
        }
      });
    });
  }
}
