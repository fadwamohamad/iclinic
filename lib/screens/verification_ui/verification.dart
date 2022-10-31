import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iclinic/custom_lib/pin_code_fields/pin_code_fields.dart';
import 'package:iclinic/interfaces/general_interface.dart';
import 'package:iclinic/screens/verification_ui/verification_controller.dart';
import 'package:iclinic/widgets/navigation.dart';
import '../../custom_lib/pin_code_fields/models/pin_theme.dart';
import '../../response/response_user.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/user_preference.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../reset_pass_ui/reset_pass_ui.dart';

class VerificationUi extends StatefulWidget {
  String? token;
  VerificationUi({Key? key,required this.token}) : super(key: key);

  @override
  State<VerificationUi> createState() => _VerificationUiState();
}

class _VerificationUiState extends State<VerificationUi>implements GeneralInterface {
  var formKey = GlobalKey<FormState>();
  TextEditingController pinCodeController = TextEditingController();
  late VerificationController controller = VerificationController(this);
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
              CustomText('ادخل الكود المرسل عبر البريد الالكتروني',
                  color: MyColors.greyColor, size: 12, align: TextAlign.center),
              SizedBox(
                height: 27.h,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  onChanged: (ff) {},
                  controller: pinCodeController,
                  enableActiveFill: true,
                  validator: (String? value) =>
                      value!.isEmpty ? 'يرجى إدخال كود التفعيل' : null,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5.r),
                    fieldHeight: 50.h,
                    fieldWidth: 65.w,
                    inactiveFillColor: MyColors.whiteColor,
                    selectedFillColor: Colors.white,
                    selectedColor: Colors.red,
                    activeColor: MyColors.greenColor,
                    activeFillColor: Colors.white,
                    //disabledColor: const Color(0xFFE1F1FF),
                    inactiveColor: const Color(0xFFE1F1FF),
                    borderWidth: 1,
                    errorBorderColor: Colors.red,
                  ),
                ),
              ),
              //CustomPinCode(controller: pinCodeController),
              SizedBox(
                height: 240.h,
              ),
              CustomButton(
                onPressed: () async{
                  if (formKey.currentState!.validate()) {
                   // bool b =
                    await controller
                        .verfication(pinCodeController.text,widget.token??"");
                    //if (b) {

                    //}

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
  void onError(dynamic) {
    // TODO: implement onError
  }

  @override
  void onSuccess(dynamic) async{
    // TODO: implement onSuccess
    ResponseUser response=dynamic as ResponseUser;
    await UserPreferences()
        .fAddStringToSF(Constants.token, response.token??"");
    await UserPreferences()
        .fAddObjectToSF(Constants.user_info, response.user??Object());
    navigateTo(context,  ResetPassUi());
  }
}
