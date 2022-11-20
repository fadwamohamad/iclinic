import 'dart:io';
import 'package:iclinic/response/response_add_clinic.dart';
import 'package:iclinic/response/response_area.dart';
import 'package:iclinic/response/response_city.dart';
import 'package:iclinic/response/response_clinic_type.dart';
import 'package:iclinic/response/response_clinic_visits.dart';
import 'package:iclinic/response/response_user.dart';
import 'package:iclinic/services/BaseResponseList.dart';
import '../response/response_update_visit.dart';
import '../response/response_visit.dart';
import '../response/verification_token.dart';
import 'BaseResponse.dart';
import 'webservice.dart';

class Apis {
  static final Apis _instance = Apis._internal();
  factory Apis() {
    return _instance;
  }
  Apis._internal();

  Future<BaseResponse<T>?> login<T>(Map<String, dynamic> map) async {
    BaseResponse<T>? response =
        await Webservice().post("auth/login", body: map);
    return response;
  }

  Future<BaseResponse<ResponseVerification>?> forget_password<T>(
      Map<String, dynamic> map) async {
    BaseResponse<ResponseVerification>? response =
        await Webservice().post("auth/password/mobile", body: map);
    return response;
  }

  Future<BaseResponse<ResponseUser>?> code_check<T>(
      Map<String, dynamic> map) async {
    BaseResponse<ResponseUser>? response =
        await Webservice().post("auth/password/code/check", body: map);
    return response;
  }

  Future<BaseResponse<T>?> reset_password<T>(Map<String, dynamic> map) async {
    BaseResponse<T>? response =
        await Webservice().post("password/reset", body: map);
    return response;
  }

  Future<BaseResponseList<Clinic>?> getClinics(Map<String, dynamic> map) async {
    BaseResponseList<Clinic>? response =
        await Webservice().getList("clinics", queryParameters: map);
    return response;
  }

  Future<BaseResponseList<Visits>?> getVisits(Map<String, dynamic> map) async {
    BaseResponseList<Visits>? response =
        await Webservice().getList("visits", queryParameters: map);
    return response;
  }

  Future<BaseResponse<ResponseClinic2>?> addClinic(Map<String, dynamic> map,
      {File? logoImage, File? cardImage}) async {
    BaseResponse<ResponseClinic2>? response = await Webservice().postFile(
        "clinics",
        body: map,
        logoImage: logoImage,
        cardImage: cardImage);
    return response!;
  }

  Future<BaseResponse<ResponseClinic2>?> updateClinic(
      Map<String, dynamic> map, int clinicId,
      {File? logoImage, File? cardImage}) async {
    BaseResponse<ResponseClinic2>? response = await Webservice().postFile(
        "clinics/$clinicId",
        body: map,
        logoImage: logoImage,
        cardImage: cardImage);
    return response!;
  }

  Future<BaseResponse<DataClinicVisit>?> addVisit(
      Map<String, dynamic> map) async {
    BaseResponse<DataClinicVisit>? response =
        await Webservice().post("visits", body: map);
    return response!;
  }

  Future<BaseResponse<ResponseClinic2>?> showClinic(
      Map<String, dynamic> map, int id) async {
    BaseResponse<ResponseClinic2>? response =
        await Webservice().get("clinics/$id");
    return response;
  }

  Future<BaseResponse<T>?> deleteClinic<T>(int id) async {
    BaseResponse<T>? response = await Webservice().delete("clinics/$id");
    return response;
  }

  Future<BaseResponse<ResponseClinic2>?> editClinic(
      Map<String, dynamic> map, int id,
      {logoImage, File? cardImage}) async {
    BaseResponse<ResponseClinic2>? response = await Webservice().putFile(
        "clinics/$id",
        body: map,
        logoImage: logoImage,
        cardImage: cardImage);
    return response!;
  }

  Future<BaseResponse<DataClinicVisits>?> getClinicVisits(int clinicId) async {
    BaseResponse<DataClinicVisits>? response =
        await Webservice().get("visits/$clinicId");
    return response;
  }

  Future<BaseResponse<UpdateVisitReportResponse>?> updateVisitResport(
      Map<String, dynamic> map, int visitId) async {
    BaseResponse<UpdateVisitReportResponse>? response =
        await Webservice().put("visits/$visitId", body: map);
    return response;
  }

  Future<BaseResponse<ResponseArea>?> getCountries() async {
    BaseResponse<ResponseArea>? response = await Webservice().get("areas");
    return response;
  }

  Future<BaseResponse<ResponseCity>?> getCities(int id) async {
    BaseResponse<ResponseCity>? response = await Webservice().get("areas/$id");
    return response;
  }

  Future<BaseResponse<ResponseClinicsType>?> getCategory() async {
    BaseResponse<ResponseClinicsType>? response =
        await Webservice().get("clinics-type");
    return response;
  }
}
