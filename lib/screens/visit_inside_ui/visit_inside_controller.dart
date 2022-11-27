import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:iclinic/response/response_clinic_visits.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../services/webservice.dart';

class InsideVisitController {
  Rx<LoadingStatus> status = LoadingStatus.loading.obs;
  Rx<bool> isLoaded = false.obs;
  RxList<ClinicVisits> cliniVisits = <ClinicVisits>[].obs;
  Rx<dynamic> rest = "".obs;
  RxBool isMoreDataAvailable = false.obs;
  Rx<String> error = "".obs;

  getClinicVisits(
    int clinicVisitId,
    int? page, {
    Map<String, dynamic>? map,
  }) async {
    BaseResponse<DataClinicVisits>? response =
        await Apis().getClinicVisits(clinicVisitId);
    if (response != null) {
      if (response.result?.visits?.isEmpty ?? true) {
        isMoreDataAvailable.value = false;
      } else {
        isMoreDataAvailable.value = true;
      }
      if (page == 1) {
        cliniVisits.clear();
      }
      cliniVisits.value.addAll(response.result?.visits ?? []);
      cliniVisits.refresh();

      if (cliniVisits.value.isEmpty) {
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
}
