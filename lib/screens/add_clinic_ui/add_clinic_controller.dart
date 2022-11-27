import 'dart:io';
import 'package:get/get.dart';
import 'package:iclinic/utils/base_controller.dart';
import '../../interfaces/success_interface.dart';
import '../../response/response_add_clinic.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../utils/helpers.dart';

class AddClinicController extends BaseController with Helpers {
  SuccessInterface view;
  AddClinicController(this.view);

  addClinic(
    Map<String, dynamic> map, {
    File? logoImage,
    File? cardImage,
  }) async {
    try {
      showLoading();
      BaseResponse<ResponseClinic2>? response = await Apis()
          .addClinic(map, logoImage: logoImage, cardImage: cardImage);
      dismissLoading();
      if (response!.status) {
        showMessage(response.msg ?? "تم إضافة العيادة بنجاح", error: false);
        view.onSuccess(response.result?.clinic);
      } else {
        showMessage(response.msg ?? "");
      }
    } catch (error) {
      error.printError();
      dismissLoading();
      showMessage(error.toString());
    }
  }

  updateClinic(
    Map<String, dynamic> map,
    int clinicId, {
    File? logoImage,
    File? cardImage,
  }) async {
    try {
      showLoading();
      BaseResponse<ResponseClinic2>? response = await Apis().updateClinic(
          map, clinicId,
          logoImage: logoImage, cardImage: cardImage);
      dismissLoading();
      if (response!.status) {
        showMessage(response.msg ?? "تم تعديل العيادة بنجاح", error: false);
        view.onSuccess(response.result);
      } else {
        showMessage(response.msg ?? "");
      }
    } catch (error) {
      error.printError();
      dismissLoading();
      showMessage(error.toString());
    }
  }
}
