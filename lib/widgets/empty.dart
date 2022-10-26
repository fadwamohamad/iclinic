import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';

Widget Empty(double rateHeight, {Function()? onRefresh}) {
  return ListView(
    children: [
      Container(
          height:
              500, //MediaQuery.of(App.navigatorKey.currentContext!).size.height / rateHeight.h
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/empty.png',
                width: 312.w,
                height: 205.h,
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomText(
                'للاسف, لم يتم العثور على اي نتائج',
                size: 12,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ],
          ))
    ],
  );
}
