import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rca_resident/app/base/base_controller.dart';
import 'package:rca_resident/app/model/create_payment_payload.dart';
import 'package:rca_resident/app/model/material_type.dart';
import 'package:rca_resident/app/model/schedule_cart.dart';
import 'package:rca_resident/app/modules/models/item_collected.dart';
import 'package:rca_resident/app/resource/color_manager.dart';
import 'package:rca_resident/app/resource/reponsive_utils.dart';
import 'package:rca_resident/app/resource/text_style.dart';
import 'package:rca_resident/app/resource/util_common.dart';
import 'package:rca_resident/app/routes/app_pages.dart';
import 'package:rca_resident/app/service/main_service.dart';

class CalendarDetailController extends BaseController {
  //TODO: Implement CalendarDetailController
  CalendarDetailController({required this.dataSchedule});
  final count = 0.obs;
  List<ItemCollected> listItemConst = [
    ItemCollected(id: '1', name: 'Nilon', weight: 0, point: 10),
    ItemCollected(id: '2', name: 'Carton', weight: 0, point: 12),
    ItemCollected(id: '3', name: 'Orther', weight: 0, point: 5),
  ];
  Rx<MaterialTypeData> selectedDropdown = MaterialTypeData().obs;
  RxList<MaterialTypeData> listItemAdd = <MaterialTypeData>[].obs;
  ScheduleCard dataSchedule;
  MainService mainService = MainService();
  RxList<MaterialTypeData> listMaterialType = <MaterialTypeData>[].obs;

  Rx<double> sumData = 0.0.obs;
  @override
  void onInit() {
    fetchListMaterial();

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

  fetchListMaterial() {
    mainService.fetchListMaterial().then((listData) {
      listMaterialType(listData);
      selectedDropdown.value = listMaterialType[0];
    }).catchError(handleError);
    //     .catchError((onError) {
    //       log(e)
    //   listMaterialType.value = [
    //     MaterialType(id: 1, name: "Rác công nghiệp"),
    //     MaterialType(id: 2, name: "Rác tái chế"),
    //     MaterialType(id: 3, name: "Rác nilon")
    //   ];
    // });
  }

  addNewItem(MaterialTypeData value) {
    MaterialTypeData? item =
        listItemAdd.value.firstWhereOrNull((item) => item.id == value.id);
    // log(item?.id ?? 'hihi');
    if (item != null) {
      SnackBarCheck.snackBar(text: 'Không được thêm trùng loại', isFail: true);
    } else {
      listItemAdd.add(value);
    }
    calculation();
  }

  removeItem(MaterialTypeData value) {
    MaterialTypeData? item =
        listItemAdd.value.firstWhereOrNull((item) => item.id == value.id);
    if (item != null) {
      listItemAdd.remove(item);
    }
    calculation();
  }

  calculation() {
    sumData(0);
    listItemAdd.forEach((e) {
      sumData += e.weight! * e.price!;
    });
  }

  createQrPayment() {
    CreatePaymentPayload payload = CreatePaymentPayload();
    payload.scheduleId = dataSchedule.scheduleId!;
    payload.materials = listItemAdd.value;
    mainService.createQrPayment(payload: payload).then((value) {
      Get.bottomSheet(Container(
        height: UtilsReponsive.height(400, Get.context!),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(UtilsReponsive.height(15, Get.context!)),
              topRight:
                  Radius.circular(UtilsReponsive.height(15, Get.context!)),
            ),
            color: Colors.white),
        child: Column(
          children: [
            TextConstant.subTile2(Get.context!, text: 'Mã thanh toán: $value'),
             TextConstant.subTile2(Get.context!, text: 'Tổng cộng: $sumData'),
            QrImageView(
              data: value.toString(),
              version: QrVersions.auto,
              size: 200.0,
            ),
            ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: Get.context!.width),
            child: ElevatedButton(
              onPressed: () {
                fetchScheduleDetail();
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(ColorsManager.primary),
                padding: WidgetStateProperty.all(EdgeInsets.all(14)),
              ),
              child:  TextConstant.subTile2(
                    Get.context!,
                    text: 'Xác nhận đã thanh toán',
                  ),
            )),
          ],
        ),
      ),
      isDismissible: false,
      );
      log('Id $value');
    }).catchError(handleError);
  }

  fetchScheduleDetail(){
    mainService.fetchScheduleById(id: dataSchedule.scheduleId!).then((schedule){
      if(schedule.status == 'ONGOING'){
        Get.offAllNamed(Routes.HOME);
        UtilCommon.snackBar(text: 'Đơn hàng hoàn tất');
      }else{
        UtilCommon.snackBar(text: 'Đơn hàng chưa được khách hàng xác nhận', isFail: true);
      }
    }).catchError(handleError);
  }
}
