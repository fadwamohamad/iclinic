import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';

Widget CustomText(String text,
    {double size = 15,
    Color? color = MyColors.blackColor,
    FontWeight? fontWeight = FontWeight.normal,
    double height = 1.5,
    int? maxLine,
    TextAlign align = TextAlign.start,
    TextOverflow textOverflow = TextOverflow.visible,
    TextDecoration decoration = TextDecoration.none,
    EdgeInsetsDirectional padding = EdgeInsetsDirectional.zero,
    TextDirection? textDirection,
    String fontFamily = 'regular'}) {
  return Container(
    padding: padding,
    child: Text(
      text,
      textAlign: align,
      maxLines: maxLine,
      textDirection: textDirection,
      style: TextStyle(
        color: color,
        fontSize: size.sp,
        fontWeight: fontWeight,
        height: height.h,
        decoration: decoration,
        letterSpacing: 0,
        fontFamily: fontFamily,
      ),
      overflow: textOverflow,
    ),
  );
}
