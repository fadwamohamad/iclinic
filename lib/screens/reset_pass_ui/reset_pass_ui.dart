import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iclinic/interfaces/success_interface.dart';
import 'package:iclinic/screens/main_ui/main_ui.dart';
import 'package:iclinic/screens/reset_pass_ui/reset_pass_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class ResetPassUi extends StatefulWidget {
  ResetPassUi({Key? key}) : super(key: key);

  @override
  State<ResetPassUi> createState() => _ResetPassUiState();
}

class _ResetPassUiState extends State<ResetPassUi> implements SuccessInterface {
  var formLoginKey = GlobalKey<FormState>();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  late ResetPassContoller resetPassContoller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resetPassContoller = ResetPassContoller(this);
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
              CustomText('تعيين كلمة مرور',
                  color: const Color(0xFF2D2D2D),
                  fontFamily: 'bold',
                  size: 18.sp,
                  align: TextAlign.center),
              SizedBox(
                height: 42.h,
              ),
              CustomText('كلمة المرور الجديدة',
                  color: MyColors.greyColor, size: 12, align: TextAlign.start),
              SizedBox(
                height: 8.h,
              ),
              CustomTextField(
                controller: passController,
                hintText: 'ادخل كلمة المرور',
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 24.h,
              ),
              CustomText('تأكيد كلمة المرور',
                  color: MyColors.greyColor, size: 12, align: TextAlign.start),
              SizedBox(
                height: 8.h,
              ),
              CustomTextField(
                controller: confirmPassController,
                hintText: 'تأكيد كلمة المرور',
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: 130.h,
              ),
              CustomButton(
                onPressed: () async {
                  if (formLoginKey.currentState!.validate()) {
                    await resetPassContoller.resetPass(
                        passController.text, confirmPassController.text);
                  }
                },
                text: 'تأكيد',
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
  void onSuccess(dynamic) async {
    // TODO: implement onSuccess
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainUi()));
  }
}
