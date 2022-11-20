import 'package:flutter/material.dart';
import '../../interfaces/success_interface.dart';
import '../../response/response_user.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../utils/user_preference.dart';

class LoginController with Helpers {
  SuccessInterface view;
  BuildContext context;

  LoginController(this.context, this.view);

  Future<bool> login(
    String phone,
    String password,
  ) async {
    showLoading();
    Map<String, dynamic> map = <String, dynamic>{};
    map["email"] = phone;
    map["password"] = password;
    await UserPreferences().fAddStringToSF(Constants.phone_number, phone);
    await UserPreferences().fAddStringToSF(Constants.password, password);
    try {
      BaseResponse<ResponseUser>? response =
          await Apis().login<ResponseUser>(map);

      if (response != null) {
        if (response.status) {
          await UserPreferences()
              .fAddStringToSF(Constants.token, response.result?.token ?? "");
          await UserPreferences().fAddObjectToSF(
              Constants.user_info, response.result?.user ?? Object());
          UserPreferences().addBoolToSF(Constants.isLogged, true);
          dismissLoading();
          return response.status;
        } else {
          dismissLoading();
          showMessage(response.msg ?? "");
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

  Future<bool> forgetPassword(String phone) async {
    Map<String, dynamic> map = <String, dynamic>{};
    map["email"] = phone;
    try {
      showLoading();
      BaseResponse? response = await Apis().forget_password(map);
      dismissLoading();
      if (response != null) {
        if (response.status) {
          showMessage(response.msg ?? "تم ارسال الكود الى بريدك الالكتروني",
              error: false);
          view.onSuccess(response.status);
          return response.status;
        } else {
          showMessage(response.msg ?? '');
          return response.status;
        }
      } else {
        showMessage('Response Error', error: true);
        return false;
      }
    } catch (error) {
      dismissLoading();
      showMessage(error.toString(), error: true);
      return false;
    }
  }
}
