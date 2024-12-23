import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rca_resident/app/model/schedule_cart.dart';
import 'package:rca_resident/app/modules/tab_history/controllers/tab_history_controller.dart';
import 'package:rca_resident/app/resource/color_manager.dart';
import 'package:rca_resident/app/resource/reponsive_utils.dart';
import 'package:rca_resident/app/resource/text_style.dart';
import 'package:rca_resident/app/resource/util_common.dart';
import 'package:rca_resident/app/routes/app_pages.dart';


class TabHistoryView extends GetView<TabHistoryController> {
  const TabHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
          padding: EdgeInsets.all(UtilsReponsive.height(15, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBoxConst.size(context: context, size: 10),
              Center(
                child: TextConstant.titleH3(text: 'Lịch sử thu gom', context),
              ),
              SizedBoxConst.size(context: context, size: 20),
              Obx(
                () => controller.isLoading.value
                    ? CircularProgressIndicator()
                     : controller.listSchedule.value.isEmpty
                        ? Center(child: TextConstant.subTile3(context, text: 'Chưa có lịch'))
                    : ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) =>
                            _cardData(context, controller.listSchedule[index]),
                        separatorBuilder: (context, index) =>
                            SizedBoxConst.size(context: context),
                        itemCount: controller.listSchedule.value.length),
              )
            ],
          )),
    ));
  }

  Widget _cardData(BuildContext context, ScheduleCard schedule) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.SCHEDULE_DETAIL, arguments: schedule);
      },
      child: Container(
          // height: UtilsReponsive.height(100, context),
          width: double.infinity,
          decoration: UtilCommon.shadowBox(context, colorSd: ColorsManager.primary),
          padding: EdgeInsets.symmetric(
              vertical: UtilsReponsive.height(10, context),
              horizontal: UtilsReponsive.height(10, context)),
          child: Row(
            children: [
              SizedBoxConst.sizeWith(context: context, size: 20),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: ColorsManager.primary,
                        size: UtilsReponsive.height(16, context),
                      ),
                      SizedBoxConst.sizeWith(context: context, size: 5),
                      TextConstant.subTile2(
                          text: UtilCommon.convertEEEDateTime(
                              schedule.scheduleDate ?? DateTime.now()),
                          fontWeight: FontWeight.w500,
                          context),
                    ],
                  ),
                  SizedBoxConst.size(context: context),
                  Row(
                    children: [
                      TextConstant.subTile3(
                        context,
                        text: 'ID:',
                        size: 10,
                      ),
                      SizedBoxConst.sizeWith(context: context, size: 5),
                      TextConstant.subTile2(
                        context,
                        text:
                            '${schedule.scheduleId!}',
                      ),
                    ],
                  ),
                  SizedBoxConst.size(context: context),
                  Row(
                    children: [
                      TextConstant.subTile3(
                        context,
                        text: 'Khách hàng:',
                        size: 10,
                      ),
                      SizedBoxConst.sizeWith(context: context, size: 5),
                      TextConstant.subTile2(
                        context,
                        text:
                            '${schedule.residentId?.user?.firstName} ${schedule.residentId?.user?.lastName}',
                      ),
                    ],
                  ),
                  SizedBoxConst.size(context: context),
                  Row(
                    children: [
                      TextConstant.subTile3(
                        context,
                        text: 'Chung cư:',
                        size: 10,
                      ),
                      SizedBoxConst.sizeWith(context: context, size: 5),
                      TextConstant.subTile3(
                        context,
                        text: '${schedule.building?.buildingName}',
                      ),
                    ],
                  ),
                  SizedBoxConst.size(context: context),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextConstant.subTile3(
                        context,
                        text: 'Mô tả các loại:',
                        size: 10,
                      ),
                      SizedBoxConst.sizeWith(context: context, size: 5),
                      Expanded(
                        child: TextConstant.subTile3(
                          context,
                          text:
                              '${schedule.materialType?.map((element) => element.name).toList().join(', ')}',
                        ),
                      ),
                    ],
                  ),
                  SizedBoxConst.size(context: context),
                  
                ],
              ))
            ],
          )),
    );
  }
}

