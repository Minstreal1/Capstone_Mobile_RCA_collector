import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rca_resident/app/common/widget/app_bar_custom.dart';
import 'package:rca_resident/app/modules/models/item_collected.dart';
import 'package:rca_resident/app/resource/color_manager.dart';
import 'package:rca_resident/app/resource/form_field_widget.dart';
import 'package:rca_resident/app/resource/reponsive_utils.dart';
import 'package:rca_resident/app/resource/text_style.dart';

import '../controllers/calendar_detail_controller.dart';

class CalendarDetailView extends GetView<CalendarDetailController> {
  const CalendarDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(ColorsManager.primary),
                padding: WidgetStateProperty.all(EdgeInsets.all(14)),
              ),
              child: TextConstant.subTile2(
                context,
                text: 'Tạo QR Code',
              ),
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: UtilsReponsive.paddingAll(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarCustom(
                    callback: () {
                      Get.back();
                    },
                    title: 'Chi tiết'),
                SizedBoxConst.size(context: context),
                Container(
                  padding: UtilsReponsive.paddingAll(context),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.amber,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextConstant.subTile3(context,
                          text: 'THÔNG TIN KHÁCH HÀNG',
                          fontWeight: FontWeight.w500),
                      SizedBoxConst.size(context: context),
                      Row(
                        children: [
                          TextConstant.subTile3(context,
                              text: 'Khách hàng', fontWeight: FontWeight.w500),
                          SizedBoxConst.sizeWith(context: context),
                          TextConstant.subTile3(context, text: 'Nguyễn Văn B'),
                        ],
                      ),
                      SizedBoxConst.size(context: context, size: 5),
                      Row(
                        children: [
                          TextConstant.subTile3(context,
                              text: 'Chung cư', fontWeight: FontWeight.w500),
                          SizedBoxConst.sizeWith(context: context),
                          TextConstant.subTile3(context,
                              text: 'Vinhome Grand Park'),
                        ],
                      ),
                      SizedBoxConst.size(context: context, size: 5),
                      Row(
                        children: [
                          TextConstant.subTile3(context,
                              text: 'Số điện thoại',
                              fontWeight: FontWeight.w500),
                          SizedBoxConst.sizeWith(context: context),
                          TextConstant.subTile3(context, text: '020202890'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBoxConst.size(context: context),
                TextConstant.subTile2(context, text: 'Thông tin thu gom'),
                Row(
                  children: [
                    Obx(
                      () => Expanded(
                        child: DropdownButton<ItemCollected>(
                          value: controller.selectedDropdown.value,
                          onChanged: (ItemCollected? newValue) {
                            controller.selectedDropdown.value = newValue!;
                          },
                          items: controller.listItemConst
                              .map<DropdownMenuItem<ItemCollected>>(
                                  (ItemCollected value) {
                            return DropdownMenuItem<ItemCollected>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          controller
                              .addNewItem(controller.selectedDropdown.value);
                        },
                        child: Icon(Icons.add))
                  ],
                ),
                Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    itemCount: controller.listItemAdd.value.length,
                    separatorBuilder: (context, index) =>
                        SizedBoxConst.size(context: context),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextConstant.subTile2(context,
                                  text: controller.listItemAdd[index].name),
                              TextConstant.subTile3(context,
                                  text:
                                      '1kg = ${controller.listItemAdd[index].point} điểm',
                                  fontWeight: FontWeight.w500),
                            ],
                          )),
                          Expanded(
                            child: FormFieldWidget(
                              padding: 5,
                              setValueFunc: (value) {
                                controller.listItemAdd[index].weight =
                                    double.tryParse(value) ?? 0;
                              },
                              borderColor: Colors.black,
                              radiusBorder: 16,
                            ),
                          ),
                          SizedBoxConst.sizeWith(context: context),
                          GestureDetector(
                              onTap: () {
                                controller
                                    .removeItem(controller.listItemAdd[index]);
                              },
                              child: Icon(Icons.close))
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
