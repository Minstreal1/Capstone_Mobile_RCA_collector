import 'package:get/get.dart';
import 'package:rca_resident/app/model/schedule_cart.dart';

import '../controllers/calendar_detail_controller.dart';

class CalendarDetailBinding extends Bindings {
  @override
  void dependencies() {
    ScheduleCard dataSchedule = Get.arguments as  ScheduleCard;
    Get.lazyPut<CalendarDetailController>(
      () => CalendarDetailController(dataSchedule: dataSchedule),
    );
  }
}
