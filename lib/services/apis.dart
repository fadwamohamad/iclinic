import 'dart:io';

import 'package:iclinic/response/response_add_clinic.dart';
import 'package:iclinic/response/response_add_visit.dart';
import 'package:iclinic/response/response_clinic_visits.dart';
import 'package:iclinic/services/BaseResponseList.dart';

import '../response/response_clinic.dart';
import '../response/response_visit.dart';
import 'BaseResponse.dart';
import 'webservice.dart';

class Apis {
  static final Apis _instance = Apis._internal();
  factory Apis() {
    return _instance;
  }
  Apis._internal();

  Future<BaseResponse<T>?> login<T>(Map<String, dynamic> map) async {
    BaseResponse<T>? response = await Webservice().post("auth/login", body: map);
    return response;
  }
  Future<BaseResponse<T>?> forget_password<T>(Map<String, dynamic> map) async {
    BaseResponse<T>? response =
    await Webservice().post("auth/forgot-password", body: map);
    return response;
  }

  Future<BaseResponse<T>?> reset_password<T>(Map<String, dynamic> map) async {
    BaseResponse<T>? response =
    await Webservice().post("auth/reset-password", body: map);
    return response;
  }

  Future<BaseResponseList<Clinics>?> getClinics(Map<String, dynamic> map) async {
    BaseResponseList<Clinics>? response = await Webservice().getList("clinics",queryParameters: map);
    return response;
  }
  Future<BaseResponseList<Visits>?> getVisits(Map<String, dynamic> map) async {
    BaseResponseList<Visits>? response = await Webservice().getList("visits",queryParameters: map);
    return response;
  }

  Future<BaseResponse<ResponseClinic2>?> addClinic(Map<String, dynamic> map,
      {File? logoImage,File? cardImage }) async {
    BaseResponse<ResponseClinic2>? response = await Webservice()
        .postFile("clinics", body: map,logoImage: logoImage,cardImage: cardImage);
    return response!;
  }



  Future<BaseResponse<ResponseVisit>?> addVisit(Map<String, dynamic> map) async {
    BaseResponse<ResponseVisit>? response = await Webservice()
        .post("visits", body: map);
    return response!;
  }

  Future<BaseResponse<ResponseClinic2>?> showClinic(Map<String, dynamic> map,int id) async {
    BaseResponse<ResponseClinic2>? response = await Webservice()
        .get("clinics/$id");
    return response;
  }

  Future<BaseResponse<T>?> deleteClinic<T>(int id) async {
    BaseResponse<T>? response = await Webservice().delete("clinics/$id");
    return response;
  }
  Future<BaseResponse<ResponseClinic2>?> editClinic(Map<String, dynamic> map,int id,
      {logoImage,File? cardImage }) async {
    BaseResponse<ResponseClinic2>? response = await Webservice()
        .putFile("clinics/$id", body: map,logoImage: logoImage,cardImage: cardImage);
    return response!;
  }

  Future<BaseResponse<DataClinicVisits>?> getClinicVisits(int clinicId) async {
    BaseResponse<DataClinicVisits>? response = await Webservice()
        .get("visits/$clinicId");
    return response;
  }
  Future<BaseResponse<ResponseVisit>?> updateVisitResport(Map<String, dynamic> map,int visitId) async {
    BaseResponse<ResponseVisit>? response = await Webservice()
        .put("visits/$visitId");
    return response;
  }

}
