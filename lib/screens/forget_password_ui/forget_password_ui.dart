import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iclinic/interfaces/success_interface.dart';
import 'package:iclinic/screens/forget_password_ui/forget_password_controller.dart';
import 'package:iclinic/widgets/navigation.dart';

import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../verification_ui/forget_pass_ui.dart';

class ForgetPasswordUi extends StatefulWidget {
  const ForgetPasswordUi({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordUi> createState() => _ForgetPasswordUiState();
}

class _ForgetPasswordUiState extends State<ForgetPasswordUi>
    implements SuccessInterface {
  var formKey = GlobalKey<FormState>();
  TextEditingController mobileNumController = TextEditingController();
  late ForgetPasswordController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ForgetPasswordController(context, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
            padding:
                EdgeInsetsDirectional.only(start: 38.w, end: 38.w, top: 70.h),
            children: [
              Image.asset('assets/images/iclinic_logo.png'),
              SizedBox(
                height: 88.h,
              ),
              CustomText('نسيت كلمة المرور',
                  color: const Color(0xFF2D2D2D),
                  fontFamily: 'bold',
                  size: 18.sp,
                  align: TextAlign.center),
              SizedBox(
                height: 32.h,
              ),
              CustomText('أدخل رقم المحمول',
                  color: MyColors.greyColor, size: 12, align: TextAlign.center),
              SizedBox(
                height: 27.h,
              ),
              CustomTextField(
                controller: mobileNumController,
                textInputType: TextInputType.phone,
                hintText: 'ادخل رقم المحمول' ,
              ),
              //CustomPinCode(controller: pinCodeController),
              SizedBox(
                height: 240.h,
              ),
              CustomButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    //navigateTo(context,  ResetPassUi(tokenx: pinCodeController.text,));
                    bool b = await controller
                        .forgetPassword(mobileNumController.text);
                    if (b) {
                      navigateTo(context, VerificationUi());
                    }
                  }
                },
                text: 'إرسال',
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
