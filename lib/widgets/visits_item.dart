import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';
import 'cached_network_image.dart';
import 'custom_text.dart';

Widget visitsItem(
        {Function()? onTap,
        Function()? onAdd,
        String? clinicName,
        int? visitsCount,
        String? clinicImage}) =>
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
            ClipOval(
              //borderRadius: BorderRadius.circular(50.r),
              child: CustomNetworkImage(
                  image: clinicImage ??
                      'https://img.freepik.com/free-photo/top-view-background-beautiful-white-grey-brown-cream-blue-background_140725-72219.jpg?w=2000',
                  height: 72.h,
                  width: 72.w,
                  fit: BoxFit.cover),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 140.w,
                  child: CustomText(clinicName ?? "",
                      size: 14, fontFamily: 'bold', color: MyColors.titlesColor),
                ),
                CustomText('${visitsCount} زيارة',
                    size: 10, fontFamily: 'regular', color: MyColors.greenColor)
              ],
            ),
            const Spacer(),
            Container(
                height: 30.h,
                width: 30.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.mainColor,
                ),
                child: InkWell(
                    onTap: onAdd,
                    child: Icon(
                      Icons.add,
                      color: MyColors.whiteColor,
                      size: 18.sp,
                    ))),
          ],
        ),
      ),
    );
