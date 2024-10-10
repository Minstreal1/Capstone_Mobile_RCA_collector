import 'package:get/get.dart';

import '../controllers/hi_controller.dart';

class HiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HiController>(
      () => HiController(),
    );
  }
}
