// To parse this JSON data, do
//
//     final createPaymentPayload = createPaymentPayloadFromJson(jsonString);

import 'dart:convert';

import 'package:rca_resident/app/model/material_type.dart';



String createPaymentPayloadToJson(CreatePaymentPayload data) => json.encode(data.toJson());

class CreatePaymentPayload {
    int? scheduleId;
    List<MaterialTypeData>? materials;

    CreatePaymentPayload({
        this.scheduleId,
        this.materials,
    });

    CreatePaymentPayload copyWith({
        int? scheduleId,
        List<MaterialTypeData>? materials,
    }) => 
        CreatePaymentPayload(
            scheduleId: scheduleId ?? this.scheduleId,
            materials: materials ?? this.materials,
        );

   

    Map<String, dynamic> toJson() => {
        "scheduleId": scheduleId,
        "materials": materials == null ? [] : List<dynamic>.from(materials!.map((x) => x.toJsonCreatePayment())),
    };
}
