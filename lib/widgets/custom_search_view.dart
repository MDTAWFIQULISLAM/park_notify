import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

class CustomSearchView extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  final Alignment? alignment;
  final double? width;
  final TextEditingController? scrollPadding;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;

  const CustomSearchView({
    Key? key,
    this.controller,
    this.onSubmitted,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment!,
      child: searchViewWidget(context),
    )
        : searchViewWidget(context);
  }

  Widget searchViewWidget(BuildContext context) => SizedBox(
    width: width ?? double.maxFinite,
    child: TextFormField(
      scrollPadding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      controller: controller,
      focusNode: focusNode ?? FocusNode(),
      autofocus: autofocus!,
      style: textStyle ?? CustomTextStyles.bodyMediumSecondaryContainer,
      keyboardType: textInputType,
      maxLines: maxLines ?? 1,
      decoration: decoration,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted, // Handle onSubmitted callback here
    ),
  );

  InputDecoration get decoration => InputDecoration(
    hintText: hintText ?? "",
    hintStyle: hintStyle ?? CustomTextStyles.bodyMediumSecondaryContainer,
    prefixIcon: prefix ??
        Container(
          margin: EdgeInsets.fromLTRB(14.h, 13.v, 4.h, 12.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgSearch,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
        ),
    prefixIconConstraints: prefixConstraints ??
        BoxConstraints(
          maxHeight: 46.v,
        ),
    suffixIcon: suffix ??
        Container(
          margin: EdgeInsets.fromLTRB(30.h, 7.v, 16.h, 7.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgFluentmic20regular,
            height: 31.v,
            width: 27.h,
          ),
        ),
    suffixIconConstraints: suffixConstraints ??
        BoxConstraints(
          maxHeight: 46.v,
        ),
    isDense: true,
    contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 13.v),
    fillColor: fillColor ?? appTheme.whiteA700,
    filled: filled!,
    border: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(23.h),
          borderSide: BorderSide(
            color: theme.colorScheme.onPrimaryContainer,
            width: 2,
          ),
        ),
    enabledBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(23.h),
          borderSide: BorderSide(
            color: theme.colorScheme.onPrimaryContainer,
            width: 2,
          ),
        ),
    focusedBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(23.h),
          borderSide: BorderSide(
            color: theme.colorScheme.onPrimaryContainer,
            width: 2,
          ),
        ),
  );
}

extension SearchViewStyleHelper on CustomSearchView {
  static OutlineInputBorder get outlineOnPrimaryContainer => OutlineInputBorder(
    borderRadius: BorderRadius.circular(18.h),
    borderSide: BorderSide(
      color: theme.colorScheme.onPrimaryContainer,
      width: 2,
    ),
  );
}
