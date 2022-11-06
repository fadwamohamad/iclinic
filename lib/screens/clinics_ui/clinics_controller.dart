
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:iclinic/response/response_add_clinic.dart';
import 'package:iclinic/services/BaseResponse.dart';
import 'package:iclinic/services/BaseResponseList.dart';
import 'package:iclinic/utils/helpers.dart';
import '../../response/response_clinic.dart';
import '../../services/apis.dart';
import '../../services/webservice.dart';

class ClinicsController with Helpers {
  Rx<LoadingStatus> status = LoadingStatus.loading.obs;
  Rx<bool> isLoaded = false.obs;
  RxList<Clinic> clinics = <Clinic>[].obs;
  Rx<dynamic> rest = "".obs;
  RxBool isMoreDataAvailable = false.obs;
  Rx<String> error = "".obs;

  getClinics(
      int? page, {
        Map<String, dynamic>? map,
      }) async {
    BaseResponseList<Clinic>? response = await Apis().getClinics(map ?? {});
    if (response != null) {
      if (response.result?.isEmpty ?? true) {
        isMoreDataAvailable.value = false;
      } else {
        isMoreDataAvailable.value = true;
      }
      if (page == 1) {
        clinics.clear();
      }
      print("hhhh${response.result?.length}");
      clinics.value.addAll(response.result ?? []);
      clinics.refresh();

      if (clinics.value.isEmpty) {
        status.value = LoadingStatus.empty;
      } else {
        status.value = LoadingStatus.completed;
      }
      if (response.code == 500) {
        status.value = LoadingStatus.newWorkError;
      } else if (response.code == 401) {
        status.value = LoadingStatus.unauthenticated;
      }

    } else {
      status.value = LoadingStatus.error;
      error.value = "Response Error";
    }
  }

  deleteClinic(int id)async{
    BaseResponse<Clinic>? response = await Apis().deleteClinic(id);
    if(response == true){
      showMessage(response?.msg?? "تم حذف العيادة بنجاح");
    }else{
      showMessage(response?.msg?? "error");
    }

  }
}
