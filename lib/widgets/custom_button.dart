import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  String text;
  Function()? onPressed;
  double radius;
  double fontSize;
  Color fontColor;
  double height;
  double width;
  Color color;
  bool isWidget;
  String priceText;
  String fontFamily;

  CustomButton({
    this.text = '',
    this.priceText = '',
    required this.onPressed,
    this.radius = 5,
    this.fontColor = MyColors.whiteColor,
    this.fontSize = 16,
    this.height = 54,
    this.width = 414,
    this.isWidget = false,
    this.fontFamily = "bold",
    this.color = MyColors.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width.w, height.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.r)),
        primary: color,
      ),
      child: CustomText(text,
          size: fontSize,
          color: fontColor,
          fontFamily: fontFamily,
          height: 2.5),
    );
  }
}
