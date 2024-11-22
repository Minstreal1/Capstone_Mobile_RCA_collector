import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:rca_resident/app/base/base_api_service.dart';
import 'package:rca_resident/app/base/base_common.dart';
import 'package:rca_resident/app/base/base_link.dart';
import 'package:rca_resident/app/model/create_payment_payload.dart';
import 'package:rca_resident/app/model/material_type.dart';
import 'package:rca_resident/app/model/schedule_cart.dart';
import 'package:http/http.dart' as http;
class MainService extends ApiService {
  Future<List<MaterialTypeData>> fetchListMaterial() async {
    return await fetchDataList(
      BaseLink.fetchListMaterial,
      (p0) => MaterialTypeData.fromJson(p0),
    );
  }

  Future<List<ScheduleCard>> fetchListScheduleByStatus(
      {String status = 'PENDING'}) async {
    return await fetchDataList(
      '${BaseLink.fetchListScheduleByStatus}?status=$status',
      (p0) => ScheduleCard.fromJson(p0),
    );
  }
   Future<List<ScheduleCard>> fetchListScheduleByStatusByUser(
      {String status = 'PENDING'}) async {
    return await fetchDataList(
      '${BaseLink.fetchListScheduleUserByStatus}?status=$status',
      (p0) => ScheduleCard.fromJson(p0),
    );
  }

    Future<ScheduleCard> fetchScheduleById(
      {required int id}) async {
    return await fetchDataObject(
      '${BaseLink.fetchScheduleById}?id=$id',
      (p0) => ScheduleCard.fromJson(p0),
    );
  }

  Future<bool> regisSchdule({required int idSchedule}) async {
    return validationWithPatch(
        BaseLink.regisSchdule + '?scheduleId=$idSchedule',
        body: {});
  }

  Future<int> createQrPayment(
      {required CreatePaymentPayload payload}) async {
    final response = await http.post(Uri.parse(BaseLink.createQrPayment),
        headers: BaseCommon.instance.headerRequest(), body: jsonEncode(payload.toJson()));
    log("payload: ${payload.toString()}");
    log('StatusCode ${response.statusCode} - ${BaseLink.createQrPayment}');
    log('Body ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body)["data"];
      return data as int;
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
  }
  //
}
