import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iclinic/custom_lib/custom_drop_down/custom_dropdown.dart';
import 'package:iclinic/widgets/custom_button.dart';
import 'package:iclinic/widgets/custom_text_field.dart';

import '../../utils/colors.dart';
import '../../widgets/cached_network_image.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';

class VisitReportUi extends StatefulWidget {
  String? clinicName;
  String? doctorName;
  String? logo;
  String? visitNum;
  String? visitDate;
  String? visitTime;
   VisitReportUi({Key? key,this.clinicName,this.doctorName,this.logo,
     this.visitNum,this.visitTime,this.visitDate}) : super(key: key);

  @override
  State<VisitReportUi> createState() => _VisitReportUiState();
}

class _VisitReportUiState extends State<VisitReportUi> {
  TextEditingController notesController = TextEditingController();
  TextEditingController rangeOfAgree = TextEditingController();
  TextEditingController customerRecommendations = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(63.h),
        child: CustomAppBar(title: 'سجل الزيارات'),
      ),
      body: ListView(
        padding:
            EdgeInsetsDirectional.only(start: 17.w, end: 17.w, bottom: 31.h),
        children: [
          SizedBox(
            height: 30.h,
          ),
          Container(
            padding: EdgeInsetsDirectional.only(start: 17.w),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: CustomNetworkImage(
                      image: widget.logo??
                          'https://img.freepik.com/free-photo/top-view-background-beautiful-white-grey-brown-cream-blue-background_140725-72219.jpg?w=2000',
                      height: 72.h,
                      width: 72.w,
                      fit: BoxFit.cover),
                ),
                SizedBox(
                  width: 17.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(widget.clinicName??"",
                        size: 14,
                        fontFamily: 'bold',
                        color: MyColors.titlesColor),
                    CustomText('د. ${widget.doctorName}',
                        size: 10,
                        fontFamily: 'regular',
                        color: MyColors.grey1Color)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 26.h,
          ),
          Container(
            padding: EdgeInsetsDirectional.only(
                start: 17.w, end: 17.w, top: 19.h, bottom: 19.h),
            margin: EdgeInsetsDirectional.only(bottom: 19.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: MyColors.whiteColor),
            child: Row(
              children: [
                CustomText('زيارة رقم ${widget.visitNum}',
                    size: 14, fontFamily: 'bold', color: MyColors.titlesColor),
                const Spacer(),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/calendar.svg'),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomText(widget.visitDate??"",
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
                    CustomText(widget.visitTime??"",
                        size: 10,
                        fontFamily: 'regular',
                        color: MyColors.greenColor),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 26.h,
          ),
          CustomText('ملاحظات على الزيارة',
              padding: EdgeInsetsDirectional.only(start: 30.w),
              size: 14,
              color: MyColors.black2Color),
          SizedBox(
            height: 11.h,
          ),
          CustomTextField(
            controller: notesController,
            minLines: 5,
            maxLine: 5,
          ),
          SizedBox(
            height: 21.h,
          ),
          CustomText('مدى قبول الزيارة',
              padding: EdgeInsetsDirectional.only(start: 30.w),
              size: 14,
              color: MyColors.black2Color),
          SizedBox(
            height: 11.h,
          ),
          CustomDropdown(
            items: const [],
            controller: rangeOfAgree,
            myVoidCallback: (nnn) {},
            outLineBorder: true,
            hintText: '',
            inColor: MyColors.whiteColor,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              color: MyColors.black1Color,
            ),
          ),
          SizedBox(
            height: 21.h,
          ),
          CustomText('توصيات الزبون',
              padding: EdgeInsetsDirectional.only(start: 30.w),
              size: 14,
              color: MyColors.black2Color),
          SizedBox(
            height: 11.h,
          ),
          CustomTextField(
            controller: customerRecommendations,
            minLines: 5,
            maxLine: 5,
          ),
          SizedBox(
            height: 21.h,
          ),
          CustomButton(
            onPressed: () {},
            text: 'حفظ التعديلات',
            color: MyColors.greenColor,
          )
        ],
      ),
    );
  }
}
