import 'package:book_listing_app/core/extensions/build_context.dart';
import 'package:flutter/foundation.dart';

import '../../gen/assets.gen.dart';
import '../extensions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/text_styles.dart';
import 'app_spacer.dart';
import 'progress_button.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(
      {super.key,
      required this.error,
      this.onPressed,
      this.showImage = true,
      this.withMaterial = false});
  final String error;
  final Function()? onPressed;
  final bool withMaterial;
  final bool showImage;
  @override
  Widget build(BuildContext context) {
    if (withMaterial) {
      return Material(
        child: _buildErrorWidget(context, showImage),
      );
    }
    return _buildErrorWidget(context, showImage);
  }

  Widget _buildErrorWidget(BuildContext context, bool showImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showImage) ...[
          Assets.images.systemUpdate.svg(
            width: 200.sp,
            height: 200.sp,
          ),
          AppSpacer(),
        ],
        Text(
          context.translate.an_error_occurred,
          textAlign: TextAlign.center,
          style: TextStyles.bold20,
        ),
        AppSpacer(heightRatio: .5),
        if (kDebugMode) ...[
          Text(
            error,
            style: TextStyles.regular14,
            textAlign: TextAlign.center,
          ),
        ],
        AppSpacer(),
        AppProgressButton(
          onPressed: (val) {
            onPressed!();
          },
          text: context.translate.retry,
        ),
      ],
    ).paddingAll(20.sp);
  }
}
