import 'package:iclinic/response/response_clinic.dart';
import 'package:iclinic/response/response_clinic_visits.dart';
import 'package:iclinic/response/response_visit.dart';
import 'package:json_annotation/json_annotation.dart';

import '../response/response_add_clinic.dart';

@JsonSerializable()
class BaseResponseList<T> {
  @JsonKey(name: 'status')
  bool? status;

  @JsonKey(name: "result")
  @_Converter()
  List<T>? result;

  @JsonKey(name: 'msg')
  String? msg;

  int? code;

  BaseResponseList({this.status = false, this.result, this.msg, this.code});

  factory BaseResponseList.fromJson(Map<dynamic, dynamic>? json) {
    return BaseResponseList(
      status: json!['status'] !=null? json['status'] as bool:null,
      result: (json['data'] as List).map(_Converter<T>().fromJson).toList(),
      msg:json['msg'] !=null? json['msg']:null,
      code: json['code'],
    );
  }
}

class _Converter<T> implements JsonConverter<T, dynamic> {
  const _Converter();

  @override
  T fromJson(dynamic jsonx) {
    if(T == Clinic){
      return Clinic.fromJson(jsonx) as T;
    }
    if(T == Visits){
      return Visits.fromJson(jsonx) as T;
    }
    if(T == ClinicVisits){
      return ClinicVisits.fromJson(jsonx) as T;
    }
    return jsonx as T;
  }

  @override
  Object toJson(T object) {
    return object!;
  }
}
