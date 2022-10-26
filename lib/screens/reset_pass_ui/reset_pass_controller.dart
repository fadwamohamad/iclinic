import '../../response/response_user.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../utils/user_preference.dart';

class ResetPassContoller with Helpers{
  Future<bool> resetPass(
      String token,
      String newPass,
      String confirmPass,
      ) async {
    showLoading();
    Map<String, dynamic> map = <String, dynamic>{};
    map["token"] = token;
    map["password"] = newPass;
    map["password_confirmation"] = confirmPass;
    try {
      BaseResponse<ResponseUser>? response = await Apis().reset_password<ResponseUser>(map);

      if (response != null) {
        if (response.status) {
          UserPreferences().addBoolToSF(Constants.isLogged, true);
          print('kkmmmm${response.status}');
          dismissLoading();
          return response.status;
        } else {
          dismissLoading();
          showMessage(response.msg??"");
          return response.status;
        }
      } else {
        dismissLoading();
        showMessage("Response Error");
        return false;
      }
    } on Exception catch (exception) {
      print(exception);
      dismissLoading();
      showMessage("Exception Login");
      return false;
    } catch (error) {
      print(error);
      dismissLoading();
      showMessage(error.toString());
      return false;
    }


  }
}