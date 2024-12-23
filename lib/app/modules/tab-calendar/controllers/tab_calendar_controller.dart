import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rca_resident/app/base/base_common.dart';
import 'package:rca_resident/app/base/base_controller.dart';

import 'package:rca_resident/app/model/schedule_cart.dart';
import 'package:rca_resident/app/modules/chat/model/chat_convert.dart';
import 'package:rca_resident/app/resource/reponsive_utils.dart';
import 'package:rca_resident/app/routes/app_pages.dart';
import 'package:rca_resident/app/service/main_service.dart';

class TabCalendarController extends BaseController {
  //TODO: Implement TabCalendarController

  RxList<ScheduleCard> listSchedule = <ScheduleCard>[].obs;
  @override
  void onInit() {
    fetchListScheduleByStatus();
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

  fetchListScheduleByStatus() {
    isLoading(true);
    MainService()
        .fetchListScheduleByStatusByUser(status: 'ACCEPTED')
        .then((data) {
      listSchedule(data);
      listSchedule.value.reversed;
      isLoading(false);
    }).catchError(handleError);
  }

  goToChat({required  ScheduleCard schedule}) {
    ChatModelConver me = ChatModelConver(
        name: '${BaseCommon.instance.accountSession!.firstName! + BaseCommon.instance.accountSession!.lastName!}',
        email: BaseCommon.instance.accountSession!.email!,
       );
    ChatModelConver other = ChatModelConver(
        name: '${schedule.residentId!.user!.firstName! + schedule.residentId!.user!.lastName!}',
        email: schedule.residentId!.user!.email!,
       );
    Get.toNamed(Routes.CHAT, arguments: [me, other]);
  }
}
