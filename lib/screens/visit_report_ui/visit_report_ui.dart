import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iclinic/custom_lib/custom_drop_down/custom_dropdown.dart';
import 'package:iclinic/interfaces/success_interface.dart';
import 'package:iclinic/response/response_clinic_visits.dart';
import 'package:iclinic/screens/visit_report_ui/visit_report_controller.dart';
import 'package:iclinic/widgets/custom_button.dart';
import 'package:iclinic/widgets/custom_text_field.dart';
import '../../models/customer_satisfication.dart';
import '../../utils/colors.dart';
import '../../widgets/cached_network_image.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';

class VisitReportUi extends StatefulWidget {
  ClinicVisits? item;
  String? logo;
  String? clinicName;
  String? doctorName;
  Function(VisitDetail)? onUpdate;
  VisitReportUi(
      {Key? key,
      this.item,
      this.logo,
      this.clinicName,
      this.doctorName,
      this.onUpdate})
      : super(key: key);

  @override
  State<VisitReportUi> createState() => _VisitReportUiState();
}

class _VisitReportUiState extends State<VisitReportUi>
    implements SuccessInterface {
  static List<Satisfaction> satiList = [
    Satisfaction(id: "excellent", name: "ممتاز"),
    Satisfaction(id: "very_good", name: "جيد جداً"),
    Satisfaction(id: "good", name: "جيد"),
    Satisfaction(id: "pass", name: "مقبول"),
  ];

  static List<VisitType> visitList = [
    VisitType(id: "marketing", name: "تسويق"),
    VisitType(id: "program_description", name: "وصف البرنامج"),
    VisitType(id: "technical_support", name: "دعم فني"),
    VisitType(id: "financial_collection", name: "تحصيل مالي"),
  ];

  late bool checkAnotherApp =
      widget.item?.visitDetail?.checkAnotherApp == 1 ? true : false;
  late bool another_app = checkAnotherApp;
  late TextEditingController notesController =
      TextEditingController(text: widget.item?.visitDetail?.visitReport);
  late TextEditingController rangeOfAgree = TextEditingController(
      text: getSatisfaction(
          widget.item?.visitDetail?.customerSatisfaction ?? ""));
  late TextEditingController visitType = TextEditingController(
      text: getvisitType(widget.item?.visitDetail?.visitType ?? ""));
  late TextEditingController customerRecommendations = TextEditingController(
      text: widget.item?.visitDetail?.customerRecommendations);
  late TextEditingController anotherAppController =
      TextEditingController(text: widget.item?.visitDetail?.anotherApp);
  late VisitReportController controller = VisitReportController(this);
  late String satisId = widget.item?.visitDetail?.customerSatisfaction ?? "";
  late String visitTypeId = widget.item?.visitDetail?.visitType ?? "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                ClipOval(
                  //borderRadius: BorderRadius.circular(50.r),
                  child: CustomNetworkImage(
                      image: widget.logo ?? "",
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
                CustomText('زيارة رقم ${widget.item?.visitNumber}',
                    size: 14, fontFamily: 'bold', color: MyColors.titlesColor),
                const Spacer(),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/calendar.svg'),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomText(widget.item?.visitDate ?? "",
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
                    CustomText(widget.item?.beginVisit ?? "",
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
            items: satiList,
            controller: rangeOfAgree,
            myVoidCallback: (result) {
              setState(() {
                satisId = result.id;
              });
            },
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
          CustomText('نوع الزيارة',
              padding: EdgeInsetsDirectional.only(start: 30.w),
              size: 14,
              color: MyColors.black2Color),
          SizedBox(
            height: 11.h,
          ),
          CustomDropdown(
            items: visitList,
            controller: visitType,
            myVoidCallback: (result) {
              setState(() {
                visitTypeId = result.id;
              });
            },
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
          Row(
            children: [
              Theme(
                  data: ThemeData(unselectedWidgetColor: MyColors.mainColor),
                  child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: another_app,
                      activeColor: MyColors.mainColor,
                      onChanged: (check) {
                        setState(() {
                          another_app = check ?? false;
                        });
                      })),
              CustomText("هل هناك تطبيق آخر؟",
                  size: 14.sp, color: MyColors.blackColor),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Visibility(
              visible: another_app,
              child: CustomTextField(controller: anotherAppController)),
          SizedBox(
            height: 50.h,
          ),
          CustomButton(
            onPressed: () {
              print({
                "visit_report": notesController.text,
                "customer_satisfaction": rangeOfAgree.text,
                "visit_type": visitType.text,
                "customer_recommendations": customerRecommendations.text,
                "check_another_app": another_app,
                "another_app": anotherAppController.text
              });

              controller.updateVisitReport({
                "visit_report": notesController.text,
                "customer_satisfaction": satisId,
                "visit_type": visitTypeId,
                "customer_recommendations": customerRecommendations.text,
                "check_another_app": another_app,
                "another_app": anotherAppController.text
              }, widget.item?.id ?? 0);
            },
            text: 'حفظ التعديلات',
            color: MyColors.greenColor,
          )
        ],
      ),
    );
  }

  @override
  void onSuccess(dynamic) {
    // TODO: implement onSuccess
    VisitDetail re = dynamic as VisitDetail;
    if (widget.onUpdate != null) widget.onUpdate!(re);
    Navigator.pop(context);
  }

  static getvisitType(String id) {
    for (int i = 0; i < visitList.length; i++) {
      if (id == visitList[i].id) return visitList[i].name;
    }
  }

  static getSatisfaction(String id) {
    for (int i = 0; i < satiList.length; i++) {
      if (id == satiList[i].id) return satiList[i].name;
    }
  }
}
