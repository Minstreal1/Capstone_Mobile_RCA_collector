import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rca_resident/app/base/base_controller.dart';
import 'package:rca_resident/app/modules/tab_account/model/nav_account.dart';
import 'package:rca_resident/app/resource/color_manager.dart';
import 'package:rca_resident/app/routes/app_pages.dart';
import 'package:rca_resident/app/service/main_service.dart';

class TabAccountController extends  BaseController {
  
  final count = 0.obs;
  List<NavAccount> listNav = [
    NavAccount(title: 'Thông tin tài khoản', icon: Icon(Icons.person, color: Colors.white,), path: Routes.PERSONAL_INFO, textColor: Colors.black, backgroundColor:ColorsManager.primary)
    ,NavAccount(title: 'Lịch sử', icon: Icon(Icons.history,color: Colors.white), path: '', textColor: Colors.black, backgroundColor:ColorsManager.primary)
    ,NavAccount(title: 'Đổi mật khẩu', icon: Icon(Icons.password,color: Colors.white), path: '', textColor: Colors.black, backgroundColor:ColorsManager.primary)
    ,NavAccount(title: 'Chuyển điểm', icon: Icon(Icons.money, color: Colors.white), path: 'path', textColor: Colors.black, backgroundColor:ColorsManager.primary)
    ,NavAccount(title: 'QR của tôi', icon: Icon(Icons.qr_code, color: Colors.white), path: 'qr_code', textColor: Colors.black, backgroundColor:ColorsManager.primary)
  
    // ,NavAccount(title: 'Thông tin chung', icon: Icon(Icons.info, color: ColorsManager.primary), path: 'path', textColor: Colors.black, backgroundColor:ColorsManager.primary)
  ];
 Rx<double> point = 0.0.obs;
  @override
 void onInit() async {
    fetchData();
    // account.value = BaseCommon.instance.accountSession!;
    // isLoading(false);
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
  fetchData(){
    MainService().fetchPoint().then((v){
      point(v);
    }).catchError(handleError);
  }
  }