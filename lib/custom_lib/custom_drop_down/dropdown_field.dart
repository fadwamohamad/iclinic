part of 'custom_dropdown.dart';

const _textFieldIcon = Text('');
const _noTextStyle = TextStyle(height: 0);

class _DropDownField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final Function(dynamic)? onChanged;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final String? errorText;
  final bool? outLineBorder;
  final TextStyle? errorStyle;
  final BorderSide? borderSide;
  final BorderSide? errorBorderSide;
  final BorderRadius? borderRadius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;

  const _DropDownField({
    Key? key,
    required this.controller,
    required this.onTap,
    this.onChanged,
    this.outLineBorder = false,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.hintStyle,
    this.style,
    this.errorText,
    this.errorStyle,
    this.borderSide,
    this.errorBorderSide,
    this.borderRadius,
    this.fillColor,
    this.validator
  }) : super(key: key);

  @override
  State<_DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<_DropDownField> {
  String? prevText;
  bool listenChanges = true;

  @override
  void initState() {
    super.initState();
    if (widget.onChanged != null) {
      widget.controller.addListener(listenItemChanges);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(listenItemChanges);
  }

  @override
  void didUpdateWidget(covariant _DropDownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onChanged != null) {
      widget.controller.addListener(listenItemChanges);
    } else {
      listenChanges = false;
    }
  }

  void listenItemChanges() {
    if (listenChanges) {
      final text = widget.controller.text;
      if (prevText != null && prevText != text && text.isNotEmpty) {
        widget.onChanged!(text);
      }
      prevText = text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = widget.outLineBorder!
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: MyColors.whiteColor,
              width: 1.0,
            ))
        : UnderlineInputBorder(
            borderSide: widget.borderSide ??
                BorderSide(
                  color: MyColors.whiteColor,
                  width: 1.0,
                ),
          );

    final errorBorder = widget.outLineBorder!
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          )
        : UnderlineInputBorder(
            borderSide: widget.errorBorderSide ??
                const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
          );

    return widget.prefixIcon != null
        ? TextFormField(
          controller: widget.controller,
           validator: widget.validator,
      // (val) {
          //   if (val?.isEmpty ?? false) return widget.errorText ?? '';
          // },
          readOnly: true,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          style: widget.style,
          decoration: InputDecoration(
            isDense: false,
            contentPadding: EdgeInsetsDirectional.only(
                start: 10.w, end: 10.w, top: 0.h, bottom: 0.h),
            suffixIcon: widget.suffixIcon ?? _textFieldIcon,
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            fillColor: widget.fillColor,
            filled: true,
            errorStyle:
                widget.errorText != null ? widget.errorStyle : _noTextStyle,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
            prefixIconConstraints: BoxConstraints(
                minWidth: 40.w, maxHeight: 25.h, maxWidth: 40.w),
            suffixIconConstraints: BoxConstraints(
                minWidth: 40.w, maxHeight: 25.h, maxWidth: 40.w),
          ),
        )
        : TextFormField(
          controller: widget.controller,
           validator: widget.validator,
      // (val) {
          //   if (val?.isEmpty ?? false) return widget.errorText ?? '';
          // },
          readOnly: true,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          style: widget.style,
          decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.only(
                start: 10.w, end: 10.w, top: 0.h, bottom: 0.h),
            suffixIcon: widget.suffixIcon ?? _textFieldIcon,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            fillColor: widget.fillColor,
            filled: true,
            errorStyle:
                widget.errorText != null ? widget.errorStyle : _noTextStyle,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
            prefixIconConstraints: BoxConstraints(
                minWidth: 40.w, maxHeight: 25.h, maxWidth: 40.w),
            suffixIconConstraints: BoxConstraints(
                minWidth: 40.w, maxHeight: 25.h, maxWidth: 40.w),
          ),
        );
  }
}
