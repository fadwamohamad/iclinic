// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class CustomAppBar extends StatefulWidget {
  String title;
  Color? color;
  PreferredSizeWidget? bottom;
  Brightness? brightness;
  CustomAppBar(
      {Key? key, required this.title, this.color, this.bottom, this.brightness})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  Size get preferredSize => Size.fromHeight(70.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: widget.color,
      //   statusBarIconBrightness: widget.brightness,
      //   statusBarBrightness: widget.brightness,
      // ),
      bottom: widget.bottom,
      title: Padding(
        padding: EdgeInsetsDirectional.only(top: 10.h),
        child: Text(
          widget.title,
          style: TextStyle(
              fontSize: 20.sp, fontFamily: 'bold', color: MyColors.titlesColor),
        ),
      ),
      centerTitle: true,
      backgroundColor: widget.color ?? Colors.white,
      elevation: 0,
      leadingWidth: 30.w,
      actions: [
        Padding(
            padding: EdgeInsetsDirectional.only(top: 10.h, end: 20.w),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                textDirection: TextDirection.ltr,
                color: MyColors.black1Color,
                size: 20.r,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ))
      ],
    );
  }
}
