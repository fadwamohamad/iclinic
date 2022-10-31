import 'package:iclinic/interfaces/success_interface.dart';

import '../../response/response_user.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../utils/user_preference.dart';

class ResetPassContoller with Helpers{
  SuccessInterface view;
  ResetPassContoller(this.view);
  resetPass(
      String newPass,
      String confirmPass,
      ) async {
    showLoading();
    Map<String, dynamic> map = <String, dynamic>{};
    map["password"] = newPass;
    map["password_confirmation"] = confirmPass;
    //try {
      BaseResponse? response = await Apis().reset_password<ResponseUser>(map);
    dismissLoading();
    if (response != null) {
      if (response.status) {
        UserPreferences().addBoolToSF(Constants.isLogged, true);
        view.onSuccess(response.result);
        showMessage(response.msg??"");
      } else {
        //view.onError(response.msg!);
        showMessage(response.msg??"");
      }
    }else{
      dismissLoading();
      showMessage("Response Error",error: true);
    }

    //   if (response != null) {
    //     if (response.status) {
    //       UserPreferences().addBoolToSF(Constants.isLogged, true);
    //       print('kkmmmm${response.status}');
    //       dismissLoading();
    //       return response.status;
    //     } else {
    //       dismissLoading();
    //       showMessage(response.msg??"");
    //       return response.status;
    //     }
    //   } else {
    //     dismissLoading();
    //     showMessage("Response Error");
    //     return false;
    //   }
    // } on Exception catch (exception) {
    //   print(exception);
    //   dismissLoading();
    //   showMessage("Exception Login");
    //   return false;
    // } catch (error) {
    //   print(error);
    //   dismissLoading();
    //   showMessage(error.toString());
    //   return false;
    // }


  }
}