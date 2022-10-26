import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iclinic/interfaces/success_interface.dart';
import 'package:iclinic/screens/forget_password_ui/forget_password_ui.dart';
import 'package:iclinic/screens/main_ui/main_ui.dart';
import 'package:iclinic/utils/colors.dart';
import 'package:iclinic/widgets/custom_button.dart';
import 'package:iclinic/widgets/custom_text.dart';
import 'package:iclinic/widgets/custom_text_field.dart';
import 'package:iclinic/widgets/navigation.dart';

import '../../services/apis.dart';
import '../../utils/constants.dart';
import '../../utils/user_preference.dart';
import 'login_controller.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({Key? key}) : super(key: key);

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> implements SuccessInterface{
  var formLoginKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  late LoginController loginController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController = LoginController(context, this);
    mobileController.text =
        UserPreferences().getStringSF(Constants.phone_number) ?? '';
    passController.text =
        UserPreferences().getStringSF(Constants.password) ?? '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mobileController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formLoginKey,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
            padding:
                EdgeInsetsDirectional.only(start: 38.w, end: 38.w, top: 70.h),
            children: [
              Image.asset('assets/images/iclinic_logo.png'),
              SizedBox(
                height: 88.h,
              ),
              CustomText('تسجيل الدخول',
                  color: const Color(0xFF2D2D2D),
                  fontFamily: 'bold',
                  size: 18.sp,
                  align: TextAlign.center),
              SizedBox(
                height: 42.h,
              ),
              CustomText('رقم المحمول',
                  padding: EdgeInsetsDirectional.only(start: 30.w),
                  color: MyColors.greyColor,
                  size: 12,
                  align: TextAlign.start),
              SizedBox(
                height: 8.h,
              ),
              CustomTextField(
                controller: mobileController,
                hintText: 'ادخل رقم المحمول',
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 24.h,
              ),
              CustomText('كلمة المرور',
                  padding: EdgeInsetsDirectional.only(start: 30.w),
                  color: MyColors.greyColor,
                  size: 12,
                  align: TextAlign.start),
              SizedBox(
                height: 8.h,
              ),
              CustomTextField(
                controller: passController,
                hintText: 'ادخل كلمة المرور',
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: () async{
                   navigateTo(context, ForgetPasswordUi());
                  },
                  child: CustomText('نسيت كلمة المرور',
                      padding: EdgeInsetsDirectional.only(start: 20.w),
                      color: MyColors.greenColor,
                      size: 12,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: 90.h,
              ),
              CustomButton(
                onPressed: () async{
                  if (formLoginKey.currentState!.validate()) {
                    bool c = await loginController.login(
                        mobileController.text,
                        passController.text);
                    if (c) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainUi()));
                    }
                  }
                },
                text: 'تسجيل الدخول',
                fontSize: 12.sp,
                radius: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onSuccess(dynamic) {
    // TODO: implement onSuccess
  }
}
