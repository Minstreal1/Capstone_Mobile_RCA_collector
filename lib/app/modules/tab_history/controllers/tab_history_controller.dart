import 'package:get/get.dart';
import 'package:rca_resident/app/base/base_controller.dart';
import 'package:rca_resident/app/model/schedule_cart.dart';
import 'package:rca_resident/app/service/main_service.dart';

class TabHistoryController extends BaseController {
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
    MainService().fetchListScheduleByStatusByUser(status: 'ONGOING').then((data) {
      listSchedule(data);
      listSchedule.value.reversed;
      isLoading(false);
    }).catchError(handleError);
  }
}

