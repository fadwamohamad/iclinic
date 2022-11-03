import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iclinic/screens/add_visit_ui/add_visit_ui.dart';
import 'package:iclinic/screens/visit_inside_ui/visit_inside_ui.dart';
import 'package:iclinic/screens/visits_ui/visits_controller.dart';
import 'package:iclinic/widgets/navigation.dart';
import 'package:iclinic/widgets/visits_item.dart';

import '../../utils/list_general_ui.dart';
import '../../widgets/search.dart';

class VisitsUi extends StatefulWidget {
  Map<String, dynamic> map = {};
   VisitsUi({Key? key,required this.map}) : super(key: key);

  @override
  State<VisitsUi> createState() => _VisitsUiState();
}

class _VisitsUiState extends State<VisitsUi>
    with AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();
  VisitsController controller = VisitsController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(top: 18.h, start: 17.w, end: 17.w),
      child: Obx(() {
        return Column(
          children: [
            Search(
                context: context,
                searchPress: (value) {
                  widget.map["search"] = value;
                  controller.getVisits(1, map: widget.map);
                  controller.rest.refresh();
                  controller.visits.refresh();
                },
                searchEditingController: searchController),
            Expanded(
              child: ListGeneralUi(
                status: controller.status.value,
                rateHeight: 1.6,
                onRest: controller.rest,
                isMoreDataAvailable: controller.isMoreDataAvailable.value,
                length: controller.visits.length,
                error: controller.error.value,
                onGetData: (page) async {
                  return await controller.getVisits(page, map: widget.map) ?? false;
                },
                pagination: false,
                pullToRefresh: true,
                itemBuilder: (context, index) {
                  return visitsItem(
                      clinicName: controller.visits[index].name,
                      clinicImage: controller.visits[index].logoUrl,
                      visitsCount: controller.visits[index].visitsCount ?? 0,
                      onTap: () {
                        navigateTo(
                            context,
                            VisitInsideUi(
                              clinicId: controller.visits[index].id ?? 0,
                              clinicName: controller.visits[index].name,
                              doctorName: controller.visits[index].doctorName,
                              logo: controller.visits[index].logoUrl,
                            ));
                      },
                      onAdd: () {
                        navigateTo(
                            context,
                            AddVisitUi(
                              clinicId: controller.visits[index].id ?? 0,
                              clinicName: controller.visits[index].name,
                              doctorName: controller.visits[index].doctorName,
                              clinicLogo: controller.visits[index].logoUrl,
                            ));
                      });
                },
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
