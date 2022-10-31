import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iclinic/interfaces/success_interface.dart';
import 'package:iclinic/screens/add_visit_ui/add_visit_controller.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';
import '../../utils/helpers.dart';
import '../../widgets/cached_network_image.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class AddVisitUi extends StatefulWidget {
  int clinicId;
  String? clinicName;
  String? doctorName;
  String? clinicLogo;
  AddVisitUi(
      {Key? key,
      required this.clinicId,
      this.clinicName,
      this.doctorName,
      this.clinicLogo})
      : super(key: key);

  @override
  State<AddVisitUi> createState() => _AddVisitUiState();
}

class _AddVisitUiState extends State<AddVisitUi> implements SuccessInterface {
  TextEditingController dateOfVisit = TextEditingController();
  TextEditingController beginTimeOfVisit = TextEditingController();
  TextEditingController endTimeOfVisit = TextEditingController();
  late AddVisitController addVisitController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addVisitController = AddVisitController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(63.h),
        child: CustomAppBar(title: 'اضافة زيارة'),
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
                      image: widget.clinicLogo ??
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
                    CustomText(widget.clinicName ?? "",
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
            height: 37.h,
          ),
          CustomText('تاريخ الزيارة',
              padding: EdgeInsetsDirectional.only(start: 30.w),
              size: 14,
              color: MyColors.black2Color),
          SizedBox(
            height: 11.h,
          ),
          CustomTextField(
            controller: dateOfVisit,
            readOnly: true,
            hintText: 'اختر تاريخ الزيارة',
            suffixIcon: SvgPicture.asset(
              'assets/icons/calendar.svg',
              height: 12.5.h,
              width: 12.5.w,
              color: MyColors.greenColor,
            ),
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1960),
                lastDate: DateTime(2025),
              ).then((value) {
                dateOfVisit.text = DateFormat("yyyy-MM-dd").format(value!);
              });
            },
          ),
          SizedBox(
            height: 21.h,
          ),
          CustomText('وقت بدأ الزيارة',
              padding: EdgeInsetsDirectional.only(start: 30.w),
              size: 14,
              color: MyColors.black2Color),
          SizedBox(
            height: 11.h,
          ),
          CustomTextField(
            controller: beginTimeOfVisit,
            readOnly: true,
            hintText: 'اختر ساعة بدأ الزيارة',
            suffixIcon: SvgPicture.asset(
              'assets/icons/clock.svg',
              height: 12.5.h,
              width: 12.5.w,
              color: MyColors.greenColor,
            ),
            onTap: () {
              showTimePicker(context: context, initialTime: TimeOfDay.now())
                  .then((value) {
                beginTimeOfVisit.text =
                    Helpers.formatTimeOfDay(value!, DateFormat.Hms());
              });
            },
          ),
          SizedBox(
            height: 21.h,
          ),
          CustomText('وقت انتهاء الزيارة',
              padding: EdgeInsetsDirectional.only(start: 30.w),
              size: 14,
              color: MyColors.black2Color),
          SizedBox(
            height: 11.h,
          ),
          CustomTextField(
            controller: endTimeOfVisit,
            readOnly: true,
            hintText: 'اختر ساعة انتهاء الزيارة',
            suffixIcon: SvgPicture.asset(
              'assets/icons/clock.svg',
              height: 12.5.h,
              width: 12.5.w,
              color: MyColors.greenColor,
            ),
            onTap: () {
              showTimePicker(context: context, initialTime: TimeOfDay.now())
                  .then((value) {
                endTimeOfVisit.text =
                    Helpers.formatTimeOfDay(value!, DateFormat.Hms());
              });
            },
          ),
          SizedBox(
            height: 300.h,
          ),
          CustomButton(
            onPressed: () {
              addVisitController.addVisit({
                "visit_date": dateOfVisit.text,
                "begin_visit": beginTimeOfVisit.text,
                "end_visit": endTimeOfVisit.text,
                "clinic_id": widget.clinicId
              });
            },
            text: 'إضافة',
            color: MyColors.greenColor,
          )
        ],
      ),
    );
  }

  @override
  void onSuccess(dynamic) {
    // TODO: implement onSuccess
    Navigator.pop(context);
  }
}
