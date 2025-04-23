// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_listing_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.title,
    this.subTitle,
  });
  final String title;
  final Widget? subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.semiBold16,
        ),
        if (subTitle != null) ...[
          subTitle!,
        ],
      ],
    );
  }
}
