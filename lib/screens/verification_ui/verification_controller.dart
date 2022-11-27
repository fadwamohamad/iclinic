import '../../interfaces/general_interface.dart';
import '../../response/response_user.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../utils/helpers.dart';

class VerificationController with Helpers {
  GeneralInterface view;

  VerificationController(this.view);
  verfication(String code, String token) async {
    Map<String, dynamic> map = <String, dynamic>{};
    map["code"] = code;
    map["token"] = token;
    showLoading();
    BaseResponse<ResponseUser>? response = await Apis().code_check(map);
    dismissLoading();
    if (response != null) {
      if (response.status) {
        view.onSuccess(response.result);
        showMessage(response.msg ?? "كود التحقق صحيح");
      } else {
        view.onError(response.msg!);
        showMessage(response.msg ?? "");
      }
    } else {
      dismissLoading();
      showMessage("Response Error", error: true);
    }
  }
}
