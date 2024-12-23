import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rca_resident/app/base/base_common.dart';
import 'package:rca_resident/app/model/schedule_cart.dart';
import 'package:rca_resident/app/resource/color_manager.dart';
import 'package:rca_resident/app/resource/reponsive_utils.dart';
import 'package:rca_resident/app/resource/text_style.dart';
import 'package:rca_resident/app/resource/util_common.dart';

import '../controllers/tab_home_controller.dart';

class TabHomeView extends GetView<TabHomeController> {
  const TabHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
          padding: EdgeInsets.all(UtilsReponsive.height(15, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBoxConst.size(context: context, size: 10),
              _headerWelcome(context),
              SizedBoxConst.size(context: context, size: 20),
              TextConstant.subTile2(text: 'Đơn mới', context),
              Container(
                width: UtilsReponsive.width(70, context),
                height: UtilsReponsive.height(2, context),
                color: ColorsManager.primary,
              ),
              Obx(
                () => controller.isLoading.value
                    ? CircularProgressIndicator()
                    : ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) =>
                            _cardData(context, controller.listSchedule[index]),
                        separatorBuilder: (context, index) =>
                            SizedBoxConst.size(context: context, size: 15),
                        itemCount: controller.listSchedule.value.length),
              )
            ],
          )),
    ));
  }

  Widget _cardData(BuildContext context, ScheduleCard schedule) {
    return GestureDetector(
      onTap: () {},
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
                              schedule.scheduleDate!),
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
                        text: '${schedule.scheduleId!}',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.regisSchdule(schedule.scheduleId!);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: UtilsReponsive.height(30, context),
                          width: UtilsReponsive.height(100, context),
                          decoration: BoxDecoration(
                            color: ColorsManager.primary,
                            borderRadius: BorderRadius.circular(
                                UtilsReponsive.height(8, context)),
                            border: Border.all(color: ColorsManager.primary),
                          ),
                          child: TextConstant.subTile3(context,
                              text: 'Đăng kí nhận', color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ))
            ],
          )),
    );
  }

  SizedBox _headerWelcome(BuildContext context) {
    return SizedBox(
      height: UtilsReponsive.height(50, context),
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: UtilsReponsive.width(5, context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: UtilsReponsive.height(40, context),
              width: UtilsReponsive.height(40, context),
              padding: EdgeInsets.all(UtilsReponsive.height(10, context)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal),
                color: ColorsManager.primary,
                shape: BoxShape.circle,
              ),
            ),
            SizedBoxConst.sizeWith(context: context),
            TextConstant.subTile3(context,
                fontWeight: FontWeight.bold,
                text:
                    'Xin chào,\n${BaseCommon.instance.accountSession?.firstName} ${BaseCommon.instance.accountSession?.lastName}',
                color: ColorsManager.primary),
          ],
        ),
      ),
    );
  }
}
