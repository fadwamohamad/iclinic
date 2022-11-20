import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iclinic/widgets/cached_network_image.dart';
import '../response/response_add_clinic.dart';
import '../utils/colors.dart';
import 'custom_text.dart';

Widget clinicsItem(Clinic? item,
        {String? imageUrl,
        String? clinicName,
        String? doctorName,
        Function(Clinic)? onDelete,
        Function()? onEdit}) =>
    Container(
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
          ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: CustomNetworkImage(
                image: imageUrl ??
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
              CustomText(clinicName ?? "",
                  size: 14, fontFamily: 'bold', color: MyColors.titlesColor),
              CustomText('د. $doctorName',
                  size: 10, fontFamily: 'regular', color: MyColors.grey1Color)
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                height: 30.h,
                width: 30.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.grey6Color,
                ),
                child: IconButton(
                    onPressed: onEdit,
                    icon: SvgPicture.asset('assets/icons/edit.svg')),
              ),
              SizedBox(
                width: 23.w,
              ),
              Container(
                height: 30.h,
                width: 30.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.grey6Color,
                ),
                child: IconButton(
                    onPressed: onDelete != null ? () => onDelete(item!) : null,
                    icon: SvgPicture.asset('assets/icons/delete.svg')),
              )
            ],
          )
        ],
      ),
    );
