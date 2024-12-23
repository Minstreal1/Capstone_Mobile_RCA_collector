import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:rca_resident/app/resource/color_manager.dart';
import 'package:rca_resident/app/resource/form_field_widget.dart';
import 'package:rca_resident/app/resource/reponsive_utils.dart';
import 'package:rca_resident/app/resource/text_style.dart';
import 'package:rca_resident/app/resource/util_common.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: Container(
            height: UtilsReponsive.height(60, context),
            width: UtilsReponsive.height(60, context),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: FloatingActionButton(
                backgroundColor: ColorsManager.primary,
                onPressed: () async {
                  Get.dialog(Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Container(
                      padding: const EdgeInsets.all(15),
                      height: UtilsReponsive.height(300, context),
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          vertical: UtilsReponsive.height(200, context),
                          horizontal: UtilsReponsive.height(30, context)),
                      decoration: UtilCommon.shadowBox(context),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(Icons.close)),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.isQrCode(true);
                            },
                            child: Row(
                              children: [
                                Obx(() => controller.isQrCode.value
                                    ? Icon(
                                        Icons.radio_button_checked,
                                        color: ColorsManager.primary,
                                      )
                                    : Icon(Icons.radio_button_off)),
                                TextConstant.subTile3(context, text: 'Nạp tiền'),
                              ],
                            ),
                          ),
                          SizedBoxConst.size(context: context),
                          GestureDetector(
                            onTap: () {
                              controller.isQrCode(false);
                            },
                            child: Row(
                              children: [
                                Obx(() => !controller.isQrCode.value
                                    ? Icon(
                                        Icons.radio_button_checked,
                                        color: ColorsManager.primary,
                                      )
                                    : Icon(Icons.radio_button_off)),
                                TextConstant.subTile3(context,
                                    text: 'Nhập mã thanh toán'),
                              ],
                            ),
                          ),
                          SizedBoxConst.size(context: context),
                         FormFieldWidget(
                              setValueFunc: (value) {},
                              radiusBorder: 10,
                              controllerEditting:
                                  controller.pointNum,
                              borderColor: Colors.black,
                              textInputType: TextInputType.number,
                            ),
                          
                          SizedBoxConst.size(context: context),
                          ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: Get.context!.width),
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.payment();
                                  },
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    backgroundColor: WidgetStateProperty.all(
                                        ColorsManager.primary),
                                    padding: WidgetStateProperty.all(
                                        EdgeInsets.all(14)),
                                  ),
                                  child: Obx(
                                    () => controller.isLockButton.value
                                        ? CupertinoActivityIndicator()
                                        : TextConstant.subTile2(
                                            Get.context!,
                                            text: 'Xác nhận đã thanh toán',
                                          ),
                                  ))),
                        ],
                      ),
                    ),
                  ));
                },
                child: Icon(Icons.payment)),
          ),
          bottomNavigationBar: Obx(() => _bottomNav2(context)),
          body: Obx(
              () => controller.body.elementAt(controller.indexSelected.value))),
    );
  }

  Container _bottomNav2(BuildContext context) {
    return Container(
        // color: Colors.grey.withOpacity(0.1),

        height: UtilsReponsive.height(80, context),
        padding: EdgeInsets.only(bottom: UtilsReponsive.height(15, context)),
        child: BottomNavigationBar(
          // backgroundColor: Colors.grey.withOpacity(0.1),

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: LineIcon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: LineIcon(Icons.calendar_month),
              label: 'Lịch',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.abc),
            //   label: 'Tạo lịch',
            // ),
            BottomNavigationBarItem(
              icon: LineIcon(Icons.book),
              label: 'Lịch sử',
            ),
            BottomNavigationBarItem(
              icon: LineIcon(Icons.person),
              label: 'Tài khoản',
            ),
          ],
          currentIndex: controller.indexSelected.value,
          selectedItemColor: ColorsManager.primary,
          selectedLabelStyle: GoogleFonts.montserrat(
              fontSize: UtilsReponsive.height(14, context),
              fontWeight: FontWeight.bold,
              color: Colors.black),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: GoogleFonts.montserrat(
              fontSize: UtilsReponsive.height(12, context),
              fontWeight: FontWeight.w600,
              color: Colors.black),
          showUnselectedLabels: true,
          elevation: 0,
          onTap: (value) async {
            await controller.onTapped(value);
          },
        ));
  }
}
