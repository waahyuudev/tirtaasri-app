import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../theme/styles.dart';
import 'custom_text.dart';

class CustomInputText extends StatelessWidget {
  const CustomInputText(
      {super.key,
        this.text,
        this.focusNode,
        this.onChanged,
        this.keyboardType = TextInputType.text,
        this.textInputAction = TextInputAction.done,
        this.controller,
        this.withOptional = false,
        this.autoFocus = false,
        this.hintText = "",
        this.errorText,
        this.onEditingComplete,
        this.onSubmitted,
        this.inputFormatters,
        this.maxLength,
        this.maxLines = 1,
        this.floatingLabelBehavior,
        this.enabled,
        this.suffixIcon,
        this.obscureText,
        this.radiusTopLeft,
        this.radiusBottomLeft,
        this.radiusTopRight,
        this.radiusBottomRight,
        this.readOnly,
        this.prefixText,
        this.validator});

  final FocusNode? focusNode;
  final String? text;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool withOptional;
  final bool autoFocus;
  final String hintText;
  final TextEditingController? controller;
  final String? errorText;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool? enabled;
  final Widget? suffixIcon;
  final bool? obscureText;
  final double? radiusTopLeft;
  final double? radiusBottomLeft;
  final double? radiusTopRight;
  final double? radiusBottomRight;
  final bool? readOnly;
  final String? prefixText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      obscureText: obscureText ?? false,
      controller: controller,
      autofocus: autoFocus,
      style: AppStyles.regular16.copyWith(
          color: (readOnly ?? false) ? AppColors.black47 : AppColors.black87),
      enabled: enabled,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
          filled: readOnly ?? false,
          fillColor: AppColors.whiteBg,
          prefixIcon: (prefixText != null)
              ? Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
            child: CustomText(
                text: prefixText!,
                color: AppColors.black47,
                style: AppStyles.regular16),
          )
              : null,
          suffixIcon: suffixIcon,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusTopLeft ?? 8.0),
                  bottomLeft: Radius.circular(radiusBottomLeft ?? 8.0),
                  topRight: Radius.circular(radiusTopRight ?? 8.0),
                  bottomRight: Radius.circular(radiusBottomRight ?? 8.0)),
              borderSide: const BorderSide(color: AppColors.black7)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusTopLeft ?? 8.0),
                  bottomLeft: Radius.circular(radiusBottomLeft ?? 8.0),
                  topRight: Radius.circular(radiusTopRight ?? 8.0),
                  bottomRight: Radius.circular(radiusBottomRight ?? 8.0)),
              borderSide: const BorderSide(color: AppColors.black7)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusTopLeft ?? 8.0),
                  bottomLeft: Radius.circular(radiusBottomLeft ?? 8.0),
                  topRight: Radius.circular(radiusTopRight ?? 8.0),
                  bottomRight: Radius.circular(radiusBottomRight ?? 8.0)),
              borderSide: const BorderSide(color: AppColors.black7)),
          label: (text != null)
              ? Text.rich(
            TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  child: CustomText(
                      text: text ?? "",
                      color: (readOnly ?? false)
                          ? AppColors.black27
                          : AppColors.black67,
                      style: AppStyles.regular16),
                ),
                WidgetSpan(
                  child: Text(
                    (withOptional)
                        ? " optional"
                        : "",
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black27),
                  ),
                ),
              ],
            ),
          )
              : null,
          hintText: hintText,
          errorText: errorText,
          floatingLabelBehavior: floatingLabelBehavior,
          hintStyle: GoogleFonts.openSans(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.black27)),
      cursorColor: AppColors.black67,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      focusNode: focusNode,
      maxLength: maxLength,
      maxLines: maxLines,
      textAlignVertical: TextAlignVertical.top,
      onFieldSubmitted: onSubmitted,
    );
  }
}
