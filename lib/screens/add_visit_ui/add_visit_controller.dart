import 'dart:io';

import 'package:get/get.dart';
import 'package:iclinic/response/response_add_visit.dart';
import '../../interfaces/success_interface.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../utils/helpers.dart';

class AddVisitController  with Helpers {
  SuccessInterface view;
  AddVisitController(this.view);

  addVisit(Map<String, dynamic> map) async {
    try{
      showLoading();
      BaseResponse<ResponseVisit>? response =
      await Apis().addVisit(map);
      dismissLoading();
      if (response!.status) {
        showMessage(response.msg??"تم إضافة الزيارة بنجاح",error: false);
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
