import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iclinic/screens/add_clinic_ui/add_clinic_ui.dart';
import 'package:iclinic/screens/clinics_ui/clinics_ui.dart';
import 'package:iclinic/screens/visits_ui/visits_ui.dart';
import 'package:iclinic/utils/colors.dart';
import 'package:iclinic/widgets/custom_text.dart';
import 'package:iclinic/widgets/navigation.dart';

class MainUi extends StatefulWidget {
  const MainUi({Key? key}) : super(key: key);

  @override
  State<MainUi> createState() => _MainUiState();
}

class _MainUiState extends State<MainUi> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
          onWillPop: () async {
            if (tabController.index != 0) {
              setState(() {
                tabController.index = 0;
              });
              return false;
            } else
              return true;
          },
        child: Scaffold(
          appBar: AppBar(
            title: CustomText('الرئيسية',
                size: 20.sp, fontFamily: 'bold', color: MyColors.titlesColor),
            backgroundColor: MyColors.whiteColor,
            centerTitle: true,
            elevation: 0,
            bottom: TabBar(
              controller: tabController,
              indicatorColor: MyColors.greenColor,
              onTap: (index) {},
              tabs: [
                Tab(
                  child: CustomText('العيادات',
                      size: 16.sp,
                      fontFamily: 'bold',
                      color: tabController.index == 0
                          ? MyColors.mainColor
                          : MyColors.grey1Color),
                ),
                Tab(
                  child: CustomText('الزيارات',
                      size: 16.sp,
                      fontFamily: 'bold',
                      color: tabController.index == 1
                          ? MyColors.mainColor
                          : MyColors.grey1Color),
                )
              ],
            ),
          ),
          body: TabBarView(
              controller: tabController,
              children: const [ClinicsUi(), VisitsUi()]),
          // floatingActionButton: FloatingActionButton(
          //   elevation: 8,
          //   onPressed: () {
          //     navigateTo(context, const AddClinicUi());
          //   },
          //   backgroundColor: MyColors.greenColor,
          //   child: const Icon(Icons.add),
          // ),
        ),
      ),
    );
  }
}
