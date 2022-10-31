import 'dart:io';

import 'package:get/get.dart';
import 'package:iclinic/response/response_add_visit.dart';
import 'package:iclinic/response/response_clinic_visits.dart';

import '../../interfaces/success_interface.dart';
import '../../response/response_add_clinic.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../utils/helpers.dart';

class VisitReportController  with Helpers {
  SuccessInterface view;
  VisitReportController(this.view);

  updateVisitReport(
      Map<String, dynamic> map,
      int visitId
      ) async {
    try{

      showLoading();
      BaseResponse<VisitDetail>? response =
      await Apis().updateVisitResport(map, visitId);
      dismissLoading();
      if (response!.status) {
        showMessage(response.msg??"تم تعديل سجل الزيارة",error: false);
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
