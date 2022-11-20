import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iclinic/widgets/validate_function.dart';
import 'package:intl/intl.dart' as intl;
import '../utils/colors.dart';

class CustomTextField extends StatefulWidget {
  String? text;
  String hintText;
  EdgeInsetsGeometry? contentPadding;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType textInputType;
  Color hintColor;
  Color fillColor;
  Color slectedColor;
  Color borderColor;
  bool obscureText;
  TextAlign? textAlign;
  TextEditingController? controller;
  TextInputAction textInputAction;
  bool enabled;
  bool readOnly;
  int? maxLine;
  int? minLines = 1;
  String? fontFamily;
  Function(String)? searchPress;
  FormFieldValidator<String>? validator;
  GestureTapCallback? onTap;
  TextDirection? textDirection;

  CustomTextField(
      {Key? key,
      this.hintText = '',
      this.text,
      this.contentPadding,
      this.textAlign,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.textDirection,
      this.fillColor = Colors.white,
      this.slectedColor = MyColors.mainColor,
      this.hintColor = MyColors.hintColor,
      this.borderColor = Colors.white,
      this.maxLine = 1,
      this.minLines = 1,
      this.searchPress,
      this.textInputType = TextInputType.text,
      this.obscureText = false,
      required this.controller,
      this.textInputAction = TextInputAction.next,
      this.enabled = true,
      this.readOnly = false,
      this.fontFamily = "regular",
      this.validator})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    if (isRTL(oldWidget.text) != isRTL(widget.text)) {
      WidgetsBinding.instance.addPostFrameCallback((_) => isRTL(widget.text));
    }
    super.didUpdateWidget(oldWidget);
  }

  bool isRTL(String? text) {
    if (text == null || text.isEmpty)
      return Directionality.of(context) == TextDirection.rtl;
    print("ccccccccccccccccc ${intl.Bidi.detectRtlDirectionality(text)}");

    return intl.Bidi.detectRtlDirectionality(text);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: MyColors.grey6Color,
      borderRadius: BorderRadius.circular(10.r),
      child: TextFormField(
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        onFieldSubmitted: (value) {
          widget.searchPress!(value);
        },
        validator: widget.validator != null
            ? widget.validator
            : (value) {
                if (widget.textInputType == TextInputType.text) {
                  return ValidateFunctions().validateEmpty(value!);
                } else if (widget.textInputType == TextInputType.number) {
                  return ValidateFunctions().validateEmpty(value!);
                } else if (widget.textInputType ==
                    TextInputType.visiblePassword) {
                  return ValidateFunctions().validatePassword(value!);
                } else if (widget.textInputType == TextInputType.phone) {
                  return ValidateFunctions().validateMobile(value!);
                } else if (widget.textInputType == TextInputType.emailAddress) {
                  return ValidateFunctions().validateEmail(value!);
                } else {
                  return null;
                }
              },
        onChanged: (str) {
          setState(() {
            widget.text = str;
          });
        },
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        textAlign: widget.textAlign != null
            ? widget.textAlign == TextAlign.start
                ? isRTL(widget.text)
                    ? TextAlign.start
                    : TextAlign.end
                : widget.textAlign == TextAlign.end
                    ? isRTL(widget.text)
                        ? TextAlign.end
                        : TextAlign.start
                    : widget.textAlign!
            : TextAlign
                .start // widget.text?.isNotEmpty??false ? isRTL(widget.text)?TextAlign.start:TextAlign.end:TextAlign.start
        ,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
          height: 2.5,
          fontFamily: widget.fontFamily,
        ),
        maxLines: widget.maxLine,
        minLines: widget.minLines,
        textDirection: widget.textDirection ??
            (isRTL(widget.text) ? TextDirection.rtl : TextDirection.ltr),
        cursorColor: MyColors.mainColor,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: false,
          hintText: widget.hintText,
          contentPadding: widget.contentPadding ??
              EdgeInsetsDirectional.only(
                  start: 10.w, end: 10.w, top: 0.h, bottom: 0.h),
          hintTextDirection: widget.textDirection ??
              (isRTL(widget.text) ? TextDirection.rtl : TextDirection.ltr),
          fillColor: widget.fillColor,
          filled: true,
          errorStyle: TextStyle(
            fontSize: 12.sp,
            color: Colors.red,
          ),
          hintStyle: TextStyle(
              fontSize: 12.sp,
              color: widget.hintColor,
              fontFamily: widget.fontFamily,
              height: 2.5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: MyColors.mainColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.textInputType == TextInputType.visiblePassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  child: Icon(
                    widget.obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: MyColors.hintColor,
                  ))
              : widget.suffixIcon,
          prefixIconConstraints:
              BoxConstraints(minWidth: 40.w, maxHeight: 25.h, maxWidth: 40.w),
          suffixIconConstraints:
              BoxConstraints(minWidth: 40.w, maxHeight: 25.h, maxWidth: 40.w),
        ),
      ),
    );
  }
}
