import 'package:flutter/material.dart';

class ValidateFunctions {
  TextInputType visiblePassword = TextInputType.visiblePassword;

  String? validateMobile(String value) {
    print("zscszd$value");

    String pattern = r'(^(((\+)|(00))?(([0-9]{1,3}))|(0))([0-9]{9})$)';

    // (\\+|00)
    RegExp regExp =  RegExp(pattern);
    if (value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    } else if (!regExp.hasMatch(value)) {
      return 'أدخل رقم هاتف صحيح';
    }
    return null;
  }

  static bool validateMobile2(String value) {
    String pattern = r'(^(((\+)|(00))?(([0-9]{1,3}))|(0))([0-9]{9})$)';

    // (\\+|00)
    RegExp regExp =  RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  String? validateEmpty(String value) {
    if (value.isEmpty) {
      return 'يرجى الكتابة هنا';
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (value.isEmpty) {
      return 'البريد الالكتروني مطلوب';
    } else if (!emailValid) {
      return 'يجب ان يكون بريد الكتروني صالح';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'كلمة المرور مطلوب';
    } else if (value.length < 5) {
      return 'يجب ان تكون كلمة المرور قوية';
    }

    return null;
  }

  String? validateConfirmPassword(String value, passController) {
    if (value != passController) {
      return 'كلمة المرور غير متطابقة';
    } else if (value.isEmpty) {
      return 'تأكيد كلمة المرور';
    }
    return null;
  }
}

ValidateFunctions mUtils = ValidateFunctions();
