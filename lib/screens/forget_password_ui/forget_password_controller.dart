
import 'package:flutter/material.dart';
import '../../interfaces/success_interface.dart';
import '../../services/BaseResponse.dart';
import '../../services/apis.dart';
import '../../utils/helpers.dart';

class ForgetPasswordController with Helpers{
  SuccessInterface view;
  BuildContext context;

  ForgetPasswordController(this.context, this.view);


  Future<bool> forgetPassword(String phone) async {
    Map<String, dynamic> map = <String, dynamic>{};
    map["email"] = phone;
    try {
      showLoading();
      BaseResponse? response = await Apis().forget_password(map);
      dismissLoading();
      if (response != null) {
        if (response.status) {
          showMessage(response.msg ?? "تم ارسال الكود الى بريدك الالكتروني", error: false);
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
    }catch(error){
      dismissLoading();
      showMessage(error.toString(), error: true);
      return false;
    }
  }
}