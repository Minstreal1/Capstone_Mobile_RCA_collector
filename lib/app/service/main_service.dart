import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:rca_resident/app/base/base_api_service.dart';
import 'package:rca_resident/app/base/base_common.dart';
import 'package:rca_resident/app/base/base_link.dart';
import 'package:rca_resident/app/model/create_payment_payload.dart';
import 'package:rca_resident/app/model/material_type.dart';
import 'package:rca_resident/app/model/payment_detail.dart';
import 'package:rca_resident/app/model/schedule_cart.dart';
import 'package:http/http.dart' as http;
import 'package:rca_resident/app/model/schedule_detail.dart';
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
      {String? status}) async {
    return await fetchDataList(
      '${BaseLink.fetchListScheduleUserByStatus}?sortOrder=DESC${status!=null?'&status=$status':''}',
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
    log("payload: ${jsonEncode(payload).toString()}");
    log('StatusCode ${response.statusCode} - ${BaseLink.createQrPayment}');
    log('Body ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body)["data"];
      return data as int;
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
  }
      Future<ScheduleDetail> fetchDataDetail(
      {required int idSchedule }) async {
    return await fetchDataObject(
      '${BaseLink.scheduleDetailById}?id=$idSchedule',
      (p0) => ScheduleDetail.fromJson(p0),
    );
  }


  Future<PaymentDetail> fetchDataPaymentDetail(
      {required int idSchedule }) async {
    return await fetchDataObject(
      '${BaseLink.paymentDetailByScheduleId}?scheduleId=$idSchedule',
      (p0) => PaymentDetail.fromJson(p0),
    );
  }
    Future<bool> confirmPayment({required int idPayment}) async {
    final response = await http.post(
        Uri.parse(BaseLink.confirmPayment + '?id=$idPayment'),
        headers: BaseCommon.instance.headerRequest());
    log('StatusCode ${response.statusCode} - ${BaseLink.confirmPayment + '?id=$idPayment'}');
    log('Body ${response.body}');
    if (response.statusCode == 200) {
      return true;
    }
    throw Exception(json.decode(response.body)['message']);
  }
  Future<double> fetchPoint() async {
     final response = await http.get(Uri.parse(BaseLink.getPoints),
        headers: BaseCommon.instance.headerRequest());
    log('StatusCode ${response.statusCode} - ${BaseLink.getPoints}');
    log('Body ${response.body}');
    if(response.statusCode == 200){
      return json.decode(response.body)["data"];
    }
    throw Exception(json.decode(response.body)["message"]);
  }
    Future<String> createMoneyLink(int point) async {
    final response = await http.get(
        Uri.parse(BaseLink.createMoneyLink + '?numberPoint=$point'),
        headers: BaseCommon.instance.headerRequest());
    log('StatusCode ${response.statusCode} - ${BaseLink.createMoneyLink + '?numberPoint=$point'}');
    log('Body ${response.body}');
    if (response.statusCode == 200) {
      return json.decode(response.body)["data"];
    }
    throw Exception(json.decode(response.body)['message']);
  }
    Future<void> sendPoint({required int point, required int userId})async{
    final response = await http.get(
        Uri.parse('${BaseLink.sendPoint}?numberPoint=$point&userId=$userId'),
        headers: BaseCommon.instance.headerRequest());
    log('StatusCode ${response.statusCode} - ${'${BaseLink.sendPoint}??numberPoint=$point&userId=$userId'}');
    log('Body ${response.body}');
    if (response.statusCode == 200) {
      return json.decode(response.body)["data"];
    }
    throw Exception(json.decode(response.body)['message']);
}
}
