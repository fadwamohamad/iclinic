import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:iclinic/response/response_visit.dart';
import '../../services/BaseResponseList.dart';
import '../../services/apis.dart';
import '../../services/webservice.dart';

class VisitsController {
  Rx<LoadingStatus> status = LoadingStatus.loading.obs;
  Rx<bool> isLoaded = false.obs;
  RxList<Visits> visits = <Visits>[].obs;
  Rx<dynamic> rest = "".obs;
  RxBool isMoreDataAvailable = false.obs;
  Rx<String> error = "".obs;

  getVisits(
    int? page, {
    Map<String, dynamic>? map,
  }) async {
    BaseResponseList<Visits>? response = await Apis().getVisits(map ?? {});
    if (response != null) {
      if (response.result?.isEmpty ?? true) {
        isMoreDataAvailable.value = false;
      } else {
        isMoreDataAvailable.value = true;
      }
      if (page == 1) {
        visits.clear();
      }
      print("hhhh${response.result?.length}");
      visits.value.addAll(response.result ?? []);
      visits.refresh();

      if (visits.value.isEmpty) {
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
