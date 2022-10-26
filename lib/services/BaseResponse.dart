import 'package:iclinic/response/response_add_clinic.dart';
import 'package:iclinic/response/response_add_visit.dart';
import 'package:iclinic/response/response_clinic.dart';
import 'package:iclinic/response/response_clinic_visits.dart';
import 'package:iclinic/response/response_user.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class BaseResponse<T> {
  @JsonKey(name: 'status')
  bool status;

  @JsonKey(name: "result")
  @_Converter()
  T? result;

  @JsonKey(name: 'msg')
  String? msg;

  @JsonKey(name: 'errors')
  Map<String, dynamic>? errors;

  int? code;

  BaseResponse({this.status = false, this.result, this.msg, this.code,this.errors});

  factory BaseResponse.fromJson(Map<dynamic, dynamic>? json) {
    return BaseResponse(
      status: json!['status']??true ,
      result: json['data'] != null
          ? _Converter<T>().fromJson(json['data'])
          :  json['data'] ,
      msg: json['msg'] !=null? json['msg']:null,
      code: json['code'],
      errors: json['errors'],
    );
  }
}

class _Converter<T> implements JsonConverter<T, dynamic> {
  const _Converter();

  @override
  T fromJson(dynamic jsonx) {
    if(T == ResponseUser){
      return ResponseUser.fromJson(jsonx) as T;
    }else if(T == ResponseClinic2){
      return ResponseClinic2.fromJson(jsonx) as T;
    }else if(T == ResponseVisit){
      return ResponseVisit.fromJson(jsonx) as T;
    }else if(T == DataClinicVisits){
      return DataClinicVisits.fromJson(jsonx) as T;
    }
    return jsonx as T;
  }

  @override
  Object toJson(T object) {
    return object!;
  }
}
