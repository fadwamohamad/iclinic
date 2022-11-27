import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iclinic/screens/clinics_ui/clinics_ui.dart';
import 'package:iclinic/screens/login_ui/login_ui.dart';
import 'package:iclinic/screens/visits_ui/visits_ui.dart';
import 'package:iclinic/utils/colors.dart';
import 'package:iclinic/widgets/custom_text.dart';
import 'package:iclinic/widgets/navigation.dart';
import '../../custom_lib/awesome_dialogs/awesome_dialog.dart';
import '../../utils/user_preference.dart';

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
          } else {
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: CustomText('الرئيسية',
                size: 20.sp, fontFamily: 'bold', color: MyColors.titlesColor),
            backgroundColor: MyColors.whiteColor,
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: MyColors.whiteColor),
            centerTitle: true,
            elevation: 0,
            actions: [
              InkWell(
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    animType: AnimType.BOTTOMSLIDE,
                    desc: 'هل تريد بالتأكيد تسجيل خروج من التطبيق؟',
                    btnOkText: "تأكيد",
                    btnCancelText: "إلغاء",
                    btnOkColor: MyColors.mainColor,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      UserPreferences().logOut();
                      navigateTo(context, const LoginUi());
                    },
                  ).show();
                },
                child: Container(
                  padding: EdgeInsetsDirectional.all(7.r),
                  margin: EdgeInsetsDirectional.only(end: 15.w),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.mainColor),
                  child: Icon(
                    Icons.logout,
                    size: 18.sp,
                  ),
                ),
              )
            ],
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
          body: TabBarView(controller: tabController, children: [
            ClinicsUi(
              map: {},
            ),
            VisitsUi(
              map: {},
            )
          ]),
        ),
      ),
    );
  }
}
