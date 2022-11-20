import 'package:get/get.dart';
import 'package:iclinic/response/response_clinic_visits.dart';
import '../../interfaces/success_interface.dart';
import '../../response/response_update_visit.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../utils/helpers.dart';

class VisitReportController with Helpers {
  SuccessInterface view;
  VisitReportController(this.view);

  updateVisitReport(Map<String, dynamic> map, int visitId) async {
    try {
      showLoading();
      BaseResponse<UpdateVisitReportResponse>? response =
          await Apis().updateVisitResport(map, visitId);
      dismissLoading();
      if (response!.status) {
        showMessage(response.msg ?? "تم تعديل سجل الزيارة", error: false);
        view.onSuccess(response.result?.visitDetail);
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
