import 'package:iclinic/response/response_clinic_type.dart';
import '../response/response_area.dart';
import '../response/response_city.dart';
import '../services/BaseResponse.dart';
import '../services/apis.dart';
import 'helpers.dart';
import 'package:get/get.dart';

class BaseController with Helpers {
  RxList<Area> countries = <Area>[].obs;
  RxList<ClinicsType> clinicTypes = <ClinicsType>[].obs;
  RxList<Cities> cites = <Cities>[].obs; // Good

  Future<void> getCites(int country_id) async {
    showLoading();
    BaseResponse<ResponseCity>? response = await Apis().getCities(country_id);
    if (response != null) {
      if (response.status) {
        cites.value = response.result!.cities ?? [];
        cites.refresh();
        dismissLoading();
      } else {
        dismissLoading();
        showMessage(response.msg ?? "", error: true);
      }
    } else {
      dismissLoading();
      showMessage("Response Error", error: true);
    }
  }

  Future<void> getCountries() async {
    showLoading();
    BaseResponse<ResponseArea>? response = await Apis().getCountries();
    if (response != null) {
      if (response.status) {
        countries.value = response.result?.area ?? [];
        countries.refresh();
        dismissLoading();
      } else {
        dismissLoading();
        showMessage(response.msg ?? "", error: true);
      }
    } else {
      dismissLoading();
      showMessage("Response Error", error: true);
    }
  }

  Future<void> getClinicType() async {
    showLoading();
    BaseResponse<ResponseClinicsType>? response = await Apis().getCategory();
    if (response != null) {
      if (response.status) {
        clinicTypes.value = response.result!.clinicsType ?? [];
        clinicTypes.refresh();
        dismissLoading();
      } else {
        dismissLoading();
        showMessage(response.msg ?? "", error: true);
      }
    } else {
      dismissLoading();
      showMessage("Response Error", error: true);
    }
  }
}
