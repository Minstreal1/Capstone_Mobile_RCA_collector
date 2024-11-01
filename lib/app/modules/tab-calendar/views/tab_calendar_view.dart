import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rca_resident/app/resource/color_manager.dart';
import 'package:rca_resident/app/resource/reponsive_utils.dart';
import 'package:rca_resident/app/resource/text_style.dart';
import 'package:rca_resident/app/routes/app_pages.dart';

import '../controllers/tab_calendar_controller.dart';

class TabCalendarView extends GetView<TabCalendarController> {
  const TabCalendarView({super.key});
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
                child: TextConstant.titleH3(
                            text: 'Lịch thu gom',
                            context),
              ),
              SizedBoxConst.size(context: context, size: 20),
              ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) => _cardData(
                        context,
                      ),
                  separatorBuilder: (context, index) =>
                      SizedBoxConst.size(context: context),
                  itemCount: 1)
            ],
          )),
    ));
  }

  Widget _cardData(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          // height: UtilsReponsive.height(100, context),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(UtilsReponsive.height(15, context)),
              border: Border.all(color: ColorsManager.primary)),
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
                          text: 'Thứ 3, Ngày 10-10-2024',
                          fontWeight: FontWeight.w500,
                          context),
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
                        text: 'Nguyễn Van B',
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
                        text: 'VinHome Grand Park',
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
                          Get.toNamed(Routes.CALENDAR_DETAIL);
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
                              text: 'Chi tiết', color: Colors.white),
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

}
