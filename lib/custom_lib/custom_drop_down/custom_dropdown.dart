library animated_custom_dropdown;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
export 'custom_dropdown.dart';

part 'animated_section.dart';

part 'dropdown_field.dart';

part 'dropdown_overlay.dart';

part 'overlay_builder.dart';

typedef callback = void Function(dynamic data);

class CustomDropdown extends StatefulWidget {
  final List<dynamic> items;
  final TextEditingController controller;
  final String? hintText;
  final bool? outLineBorder;
  final TextStyle? hintStyle;
  final TextStyle? selectedStyle;
  final String? errorText;
  final TextStyle? errorStyle;
  final TextStyle? listItemStyle;
  final BorderSide? borderSide;
  final BorderSide? errorBorderSide;
  final BorderRadius? borderRadius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(dynamic)? onChanged;
  final bool? excludeSelected;
  final Color fillColor;
  final Color inColor;
  final callback myVoidCallback;

  CustomDropdown({
    Key? key,
    required this.items,
    required this.controller,
    required this.myVoidCallback,
    this.hintText,
    this.hintStyle,
    this.selectedStyle,
    this.errorText,
    this.errorStyle,
    this.listItemStyle,
    this.errorBorderSide,
    this.outLineBorder,
    this.borderRadius,
    this.borderSide,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.excludeSelected = true,
    this.fillColor = Colors.white,
    this.inColor = MyColors.mainColor,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    /// hint text
    final hintText = widget.hintText ?? 'Select value';

    // hint style :: if provided then merge with default
    final hintStyle = TextStyle(
      fontSize: 14.sp,
      color: MyColors.hintColor,
      fontFamily: "normal",
      height: 2.5,
    ).merge(widget.hintStyle);

    // selected item style :: if provided then merge with default
    final selectedStyle = TextStyle(
      fontSize: 14.sp,
      color: Colors.black,
      fontFamily: "medium",
      height: 2.5,
    ).merge(widget.selectedStyle);

    final errorStyle = TextStyle(
      fontSize: 12.sp,
      color: Colors.red,
    ).merge(widget.errorStyle);

    return _OverlayBuilder(
      overlay: (size, hideCallback) {
        return _DropdownOverlay(
          inColor: widget.inColor,
          items: widget.items,
          controller: widget.controller,
          size: size,
          layerLink: layerLink,
          hideOverlay: hideCallback,
          myVoidCallback: widget.myVoidCallback,
          headerStyle:
              widget.controller.text.isNotEmpty ? selectedStyle : hintStyle,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          hintText: hintText,
          listItemStyle: widget.listItemStyle,
          excludeSelected: widget.excludeSelected,
          borderRadius: widget.borderRadius,
        );
      },
      child: (showCallback) {
        return CompositedTransformTarget(
          link: layerLink,
          child: _DropDownField(
            controller: widget.controller,
            onTap: showCallback,
            outLineBorder: widget.outLineBorder ?? false,
            style: selectedStyle,
            borderRadius: widget.borderRadius,
            borderSide: widget.borderSide,
            errorBorderSide: widget.errorBorderSide,
            errorStyle:errorStyle,
            errorText: widget.errorText,
            hintStyle: hintStyle,
            hintText: hintText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            onChanged: widget.onChanged,
            fillColor: widget.fillColor,
          ),
        );
      },
    );
  }
}
