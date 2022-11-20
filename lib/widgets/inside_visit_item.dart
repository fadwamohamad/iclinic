import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';
import 'custom_text.dart';

Widget insidesVisitItem(
        {Function()? onTap,
        int? visitNum,
        String? visitDate,
        String? visitTime}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.only(
            start: 17.w, end: 17.w, top: 19.h, bottom: 19.h),
        margin: EdgeInsetsDirectional.only(bottom: 19.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: MyColors.whiteColor),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText('زيارة رقم $visitNum',
                    size: 14, fontFamily: 'bold', color: MyColors.titlesColor),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/calendar.svg'),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomText(visitDate ?? "",
                        size: 10,
                        fontFamily: 'regular',
                        color: MyColors.greenColor),
                    SizedBox(
                      width: 20.w,
                    ),
                    SvgPicture.asset('assets/icons/clock.svg'),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomText(visitTime ?? "",
                        size: 10,
                        fontFamily: 'regular',
                        color: MyColors.greenColor),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Container(
                height: 22.h,
                width: 22.w,
                padding: EdgeInsetsDirectional.only(end: 5.w),
                alignment: AlignmentDirectional.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF3F3F3),
                ),
                child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_back_ios,
                      textDirection: TextDirection.ltr,
                      color: MyColors.blackColor,
                      size: 12.sp,
                    ))),
          ],
        ),
      ),
    );
