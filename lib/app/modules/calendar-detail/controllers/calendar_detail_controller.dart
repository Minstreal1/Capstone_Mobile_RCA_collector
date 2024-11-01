import 'dart:developer';

import 'package:get/get.dart';
import 'package:rca_resident/app/modules/models/item_collected.dart';
import 'package:rca_resident/app/resource/reponsive_utils.dart';

class CalendarDetailController extends GetxController {
  //TODO: Implement CalendarDetailController

  final count = 0.obs;
  List<ItemCollected> listItemConst = [
    ItemCollected(id: '1', name: 'Nilon', weight: 0, point: 10),
    ItemCollected(id: '2', name: 'Carton', weight: 0, point: 12),
    ItemCollected(id: '3', name: 'Orther', weight: 0, point: 5),
  ];
  Rx<ItemCollected> selectedDropdown =
      ItemCollected(id: '1', name: 'Nilon', weight: 0, point: 10).obs;
  RxList<ItemCollected> listItemAdd = <ItemCollected>[].obs;
  @override
  void onInit() {
    selectedDropdown.value = listItemConst[0];
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

  addNewItem(ItemCollected value) {
    ItemCollected? item =
        listItemAdd.value.firstWhereOrNull((item) => item.id == value.id);
    log(item?.id ?? 'hihi');
    if (item != null) {
      SnackBarCheck.snackBar(text: 'Không được thêm trùng loại', isFail: true);
    } else {
      listItemAdd.add(value);
    }
  }

  removeItem(ItemCollected value) {
    ItemCollected? item =
        listItemAdd.value.firstWhereOrNull((item) => item.id == value.id);
    if (item != null) {
      listItemAdd.remove(item);
    }
  }
}
