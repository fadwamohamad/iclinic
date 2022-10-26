import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';

Widget NoInternet(double rateHeight, {Function()? onRefresh}) {
  return ListView(children: [
    Container(
        height: 500.h,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/no_internet.png',
              width: 200.w,
            ),
            SizedBox(
              height: 40.h,
            ),
            SizedBox(
              width: 208.w,
              child: CustomText(
                'تأكد من اتصالك بمزود خدمة الانترنت ومن ثم أعد المحاولة',
                align: TextAlign.center,
                size: 12,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ))
  ]);
}
