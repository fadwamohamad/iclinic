import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';
import 'custom_text_field.dart';

Widget Search(
    {TextEditingController? searchEditingController,
    required context,
    double bottom = 5,
    filterVisible = true,
    String? initialValueFilter,
    EdgeInsetsDirectional? padding,
    required searchPress(String)}) {
  return Padding(
    padding: padding ??
        EdgeInsetsDirectional.only(
            start: 15.w, end: 15.w, top: 40.h, bottom: 20.h),
    child: CustomTextField(
      controller: searchEditingController,
      fillColor: MyColors.whiteColor,
      hintText: 'أدخل كلمة البحث',
      suffixIcon: SvgPicture.asset('assets/icons/search.svg',
          color: MyColors.greenColor, fit: BoxFit.scaleDown),
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.search,
      searchPress: (value) {
        searchPress(value);
      },
    ),
  )
    ;
}
