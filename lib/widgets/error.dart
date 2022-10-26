import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_button.dart';
import 'custom_text.dart';

Widget ErrorView(String? text, {Function()? onRefresh}) {
  return SizedBox(
    height: 200, //MediaQuery.of(App.navigatorKey.currentContext!).size.height
    child: ListView(
        //  physics:ClampingScrollPhysics(),
        children: [
          CustomText(text ?? '', align: TextAlign.center,size: 14.r),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 100.w, end: 100.w),
            child: CustomButton(
              text: 'تحديث',
              onPressed: onRefresh != null ? () => onRefresh : null,
              //fontSize: 14,
              radius: 4,
              height: 51.h,
            ),
          ),
        ]),
  );
}
