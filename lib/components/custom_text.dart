import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';


class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      required this.color,
      required this.style,
      this.align,
      this.textOverflow,
      this.withRichText = false});

  final String text;
  final Color color;
  final TextStyle style;
  final TextAlign? align;
  final TextOverflow? textOverflow;
  final bool withRichText;

  @override
  Widget build(BuildContext context) {
    return (withRichText)
        ? StyledText(
            text: text,
            style: style.copyWith(color: color),
            tags: {
              'bold': StyledTextTag(
                  style: AppStyles.bold12.copyWith(color: color)),
            },
            textAlign: (align != null) ? align : TextAlign.start,
            overflow: textOverflow,
          )
        : Text(
            text,
            style: style.copyWith(color: color),
            textAlign: (align != null) ? align : TextAlign.start,
            overflow: textOverflow,
          );
  }
}

class CustomRichText extends StatelessWidget {
  const CustomRichText({super.key, this.parentText, this.childText});

  final String? parentText;
  final String? childText;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          WidgetSpan(
            child: CustomText(
                text: parentText ?? "",
                color: AppColors.black87,
                style: AppStyles.bold14),
          ),
          WidgetSpan(
            child: CustomText(
                text: " ${childText ?? ''}",
                color: AppColors.black47,
                style: AppStyles.regular12),
          ),
        ],
      ),
    );
  }
}
