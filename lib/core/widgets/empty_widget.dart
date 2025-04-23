import 'package:book_listing_app/gen/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/text_styles.dart';
import 'app_spacer.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.msg, this.withMaterial = false});
  final String msg;

  final bool withMaterial;

  @override
  Widget build(BuildContext context) {
    if (withMaterial) {
      return Material(
        child: _buildEmptyWidget(context),
      );
    }
    return _buildEmptyWidget(context);
  }

  Widget _buildEmptyWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppSpacer(heightRatio: 2),
          Assets.images.empty.svg(width: 200.sp, height: 200.sp),
          AppSpacer(heightRatio: 2),
          Text(msg, style: TextStyles.semiBold18),
        ],
      ),
    );
  }
}
