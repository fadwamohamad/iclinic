import 'dart:io';

import 'package:get/get.dart';

import '../../interfaces/success_interface.dart';
import '../../response/response_add_clinic.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../utils/helpers.dart';

class AddClinicController  with Helpers {
  SuccessInterface view;
  AddClinicController(this.view);

  addClinic(
      Map<String, dynamic> map,
      {File? logoImage,
        File? cardImage,
      }) async {
    try{

      showLoading();
      BaseResponse<ResponseClinic2>? response =
      await Apis().addClinic(map, logoImage: logoImage,cardImage: cardImage);
      dismissLoading();
      if (response!.status) {
        showMessage(response.msg??"تم إضافة العيادة بنجاح",error: false);
        view.onSuccess(response.result);
      } else {
        showMessage(response.msg??"");
      }
    }catch(error){
      error.printError();
      dismissLoading();
      showMessage(error.toString());
    }
  }
}
