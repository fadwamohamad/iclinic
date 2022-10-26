import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iclinic/screens/add_visit_ui/add_visit_ui.dart';
import 'package:iclinic/screens/visit_inside_ui/visit_inside_controller.dart';
import 'package:iclinic/screens/visit_report_ui/visit_report_ui.dart';
import 'package:iclinic/utils/list_general_ui.dart';
import 'package:iclinic/widgets/inside_visit_item.dart';
import 'package:iclinic/widgets/navigation.dart';
import '../../utils/colors.dart';
import '../../widgets/cached_network_image.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';

class VisitInsideUi extends StatefulWidget {
  int clinicId;
  String? clinicName;
  String? doctorName;
  String? logo;
  VisitInsideUi(
      {Key? key,
      required this.clinicId,
      this.clinicName,
      this.doctorName,
      this.logo})
      : super(key: key);

  @override
  State<VisitInsideUi> createState() => _VisitInsideUiState();
}

class _VisitInsideUiState extends State<VisitInsideUi> {
  InsideVisitController controller = InsideVisitController();
  Map<String, dynamic> map = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(63.h),
        child: CustomAppBar(title: 'سجل الزيارات'),
      ),
      body: Obx(() {
        return Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsetsDirectional.only(start: 34.w),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: CustomNetworkImage(
                        image: widget.logo ??
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
            Expanded(
                child: ListGeneralUi(
              status: controller.status.value,
              rateHeight: 1.6,
              onRest: controller.rest,
              isMoreDataAvailable: controller.isMoreDataAvailable.value,
              length: controller.cliniVisits.length,
              error: controller.error.value,
              onGetData: (page) async {
                return await controller.getClinicVisits(
                        widget.clinicId, page) ??
                    false;
              },
              pagination: false,
              pullToRefresh: true,
              itemBuilder: (context, index) {
                return insidesVisitItem(
                    visitNum: controller.cliniVisits[index].visitNumber,
                    visitDate: controller.cliniVisits[index].visitDate,
                    visitTime: controller.cliniVisits[index].beginVisit,
                    onTap: () {
                      navigateTo(
                          context,
                          VisitReportUi(
                            clinicName: widget.clinicName,
                            logo: widget.logo,
                            doctorName: widget.doctorName,
                            visitNum: controller.cliniVisits[index].visitNumber,
                            visitDate: controller.cliniVisits[index].visitDate,
                            visitTime: controller.cliniVisits[index].beginVisit,
                          ));
                    });
              },
            ))
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        onPressed: () {
          navigateTo(
              context,
              AddVisitUi(
                clinicId: widget.clinicId,
                clinicName: widget.clinicName,
                clinicLogo: widget.logo,
                doctorName: widget.doctorName,
              ));
        },
        backgroundColor: MyColors.greenColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
