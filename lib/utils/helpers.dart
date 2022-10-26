import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' as intl;

import '../custom_lib/flutter_easyloading/src/easy_loading.dart';
import 'colors.dart';



class Helpers {
  void showMessage(String message, {error = true}) {
    if ( message !=null && message .isNotEmpty) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 16,
        backgroundColor:
            error ? const Color(0xFFEB5757).withOpacity(.9) :
        MyColors.mainColor.withOpacity(.9),
      );
    }
  }
 static String formatTimeOfDay(TimeOfDay tod,intl.DateFormat format) {
    final now =  DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  //  final formatv = format;//DateFormat.Hm();  //"6:00 AM"
    return format.format(dt);
  }
 static String? formatDateTime(DateTime tod,intl.DateFormat format) {
    return format.format(tod);
  }
  // void showSnackBar({
  //   required BuildContext context,
  //   required String content,
  //   bool error = false,
  // }) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(content),
  //     behavior: SnackBarBehavior.floating,
  //     backgroundColor: error ? Colors.red : CustomColors.mainColor,
  //   ));
  // }

  void showLoading() {
    EasyLoading.show(status: '');
  }

  void dismissLoading() {
    EasyLoading.dismiss();
  }
}
