import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iclinic/screens/add_clinic_ui/add_clinic_ui.dart';
import 'package:iclinic/screens/clinics_ui/clinics_controller.dart';
import 'package:iclinic/utils/colors.dart';
import 'package:iclinic/utils/list_general_ui.dart';
import 'package:iclinic/widgets/clinics_item.dart';
import 'package:iclinic/widgets/custom_button.dart';
import 'package:iclinic/widgets/custom_text.dart';
import 'package:iclinic/widgets/navigation.dart';
import 'package:iclinic/widgets/search.dart';

class ClinicsUi extends StatefulWidget {
  const ClinicsUi({Key? key}) : super(key: key);

  @override
  State<ClinicsUi> createState() => _ClinicsUiState();
}

class _ClinicsUiState extends State<ClinicsUi> with AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();
  ClinicsController controller = ClinicsController();
  Map<String, dynamic> map = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(top: 18.h, start: 17.w, end: 17.w),
      child: Obx(() {
        return Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Column(
              children: [
                Search(
                    context: context,
                    searchPress: (ddd) {},
                    searchEditingController: searchController),
                Expanded(
                  child: ListGeneralUi(
                    status: controller.status.value,
                    rateHeight: 1.6,
                    onRest: controller.rest,
                    isMoreDataAvailable: controller.isMoreDataAvailable.value,
                    length: controller.clinics.length,
                    error: controller.error.value,
                    onGetData: (page) async {
                      return await controller.getClinics(page, map: map) ?? false;
                    },
                    pagination: false,
                    pullToRefresh: true,
                    itemBuilder: (context, index) {
                      return clinicsItem(
                        imageUrl: controller.clinics[index].logo,
                          doctorName: controller.clinics[index].doctorName,
                          clinicName: controller.clinics[index].name,
                          onEdit: () {
                        navigateTo(context, AddClinicUi(clinic: controller.clinics[index],));
                      }, onDelete: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0.r))),
                                  content: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r)),
                                    padding: EdgeInsetsDirectional.only(
                                        start: 39.w, end: 39.w),
                                    height: 341.h,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 46.h,
                                        ),
                                        Image.asset(
                                          'assets/images/delete_clinic.png',
                                          height: 70.6.h,
                                          width: 76.45.w,
                                        ),
                                        SizedBox(
                                          height: 26.h,
                                        ),
                                        CustomText('هل انت متأكد من حذف العيادة',
                                            size: 17.sp,
                                            fontFamily: 'bold',
                                            color: MyColors.mainColor,
                                            fontWeight: FontWeight.w700),
                                        SizedBox(
                                          height: 36.h,
                                        ),
                                        CustomButton(
                                          onPressed: () {
                                            controller.deleteClinic(controller.clinics[index].id??0);
                                          },
                                          color: MyColors.greenColor,
                                          text: 'تأكيد',
                                          height: 40.h,
                                          radius: 10,
                                          fontSize: 13,
                                          fontFamily: 'regular',
                                        ),
                                        SizedBox(
                                          height: 14.h,
                                        ),
                                        CustomButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          color: MyColors.mainColor,
                                          height: 40.h,
                                          text: 'تراجع',
                                          radius: 10,
                                          fontSize: 13,
                                          fontFamily: 'regular',
                                        ),
                                      ],
                                    ),
                                  ));
                            });
                      });
                    },
                  ),
                )
              ],
            ),
            PositionedDirectional(
              bottom: 34,
              child: Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.greenColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: IconButton(
                    onPressed: () async {
                      navigateTo(context, AddClinicUi());
                    },
                    icon: const Icon(
                      Icons.add,
                      color: MyColors.whiteColor,
                      size: 25,
                    )),
              ),
            )
          ],
        );
      }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
