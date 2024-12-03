import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rca_resident/app/base/base_controller.dart';
import 'package:rca_resident/app/modules/tab-calendar/controllers/tab_calendar_controller.dart';
import 'package:rca_resident/app/modules/tab-calendar/views/tab_calendar_view.dart';
import 'package:rca_resident/app/modules/tab_account/views/tab_account_view.dart';
import 'package:rca_resident/app/modules/tab_history/controllers/tab_history_controller.dart';
import 'package:rca_resident/app/modules/tab_history/views/tab_history_view.dart';
import 'package:rca_resident/app/modules/tab_home/controllers/tab_home_controller.dart';
import 'package:rca_resident/app/modules/tab_home/views/tab_home_view.dart';
import 'package:rca_resident/app/resource/util_common.dart';
import 'package:rca_resident/app/service/main_service.dart';

class HomeController extends BaseController {
  RxList<Widget> body = RxList([
    TabHomeView(),
    TabCalendarView(),
    TabHistoryView(),
    TabAccountView()
  ]);
  final indexSelected = 0.obs;
  TextEditingController textEdittingController =
      TextEditingController(text: '');
      final isQrCode = false.obs;

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

  onTapped(int index) async {
    switch (index) {
      case 0:
        Get.find<TabHomeController>().fetchListScheduleByStatus();
        indexSelected(0);
        break;
      case 1:
      Get.find<TabCalendarController>().fetchListScheduleByStatus();
        indexSelected(1);
        break;
      case 2:
      Get.find<TabHistoryController>().fetchListScheduleByStatus();
        indexSelected(2);
        break;
      case 3:
        indexSelected(3);
        break;
      default:
    }
  }
  onTapMainButton()async{
  
  }
payment() {
    if (!isLockButton.value) {
      isLockButton.value = true;
      MainService()
          .confirmPayment(
              idPayment: int.tryParse(textEdittingController.text) ?? 0)
          .then((_) {
        isLockButton.value = false;
        Get.back();
        UtilCommon.snackBar(text: 'Xác nhận đơn thành công');
      }).catchError(handleError);
    }
  }
}
