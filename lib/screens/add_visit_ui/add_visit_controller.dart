import 'package:get/get.dart';
import '../../interfaces/success_interface.dart';
import '../../response/response_clinic_visits.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../utils/helpers.dart';

class AddVisitController with Helpers {
  SuccessInterface view;
  AddVisitController(this.view);

  addVisit(Map<String, dynamic> map) async {
    try {
      showLoading();
      BaseResponse<DataClinicVisit>? response = await Apis().addVisit(map);
      dismissLoading();
      if (response!.status) {
        showMessage(response.msg ?? "تم إضافة الزيارة بنجاح", error: false);
        view.onSuccess(response.result?.visit);
        print("reeeeee ${response.result?.toJson()}");
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
