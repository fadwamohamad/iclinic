import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iclinic/screens/login_ui/login_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iclinic/screens/main_ui/main_ui.dart';
import 'package:iclinic/utils/colors.dart';
import 'package:iclinic/utils/constants.dart';
import 'package:iclinic/utils/user_preference.dart';

import 'custom_lib/flutter_easyloading/src/animations/animation.dart';
import 'custom_lib/flutter_easyloading/src/easy_loading.dart';
bool? isLogged = false;
Widget? initialScreen = MainUi();

Widget getWidget(Map<String, dynamic> data, bool fromNotification) {
  if (data['type'] != null) {
    /* switch (data['type']) {
      case 'general_notification':
        return NotificationUi();
        break;
      case 'product':
        return ProductsDetailsUi(id: int.parse(data['id'].toString()));
        break;
      case 'auction':
        return AuctionDetailsUi(id: int.parse(data['id'].toString()));
        break;
      case 'order':
        return OrderDetailsUi(
          id: data['id'].toString(),
          path: "order_details",
          isOrder: true,
        );
        break;
      case 'my_order':
        return OrderDetailsUi(
            id: data['id'].toString(),
            path: "my_orders_details",
            isOrder: false);
        break;
    }*/
  }
  return fromNotification
      ? MainUi()
      : !isLogged!
      ? LoginUi()
      : MainUi();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().initPreferences();
  isLogged = await UserPreferences().getBoolSF(Constants.isLogged);
  initialScreen = //TestUi();
  getWidget({}, false);
  runApp(
    DevicePreview(
      enabled: !true,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            theme: ThemeData(
              scaffoldBackgroundColor: MyColors.backgroundColor,
              primarySwatch: Colors.green,
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', ''),
            ],
            builder: EasyLoading.init(),
            home: initialScreen,
          );
        });
  }
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.spinningLines
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 500.0
    ..radius = 50.0
    ..progressColor = Colors.yellow
    ..backgroundColor = MyColors.mainColor
    ..indicatorColor = MyColors.mainColor
    ..textColor = Colors.yellow
    ..maskColor = Colors.grey.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}
class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
      Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,
      ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}