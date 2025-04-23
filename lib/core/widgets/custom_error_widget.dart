import '../extensions/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/text_styles.dart';
import 'app_spacer.dart';
import 'progress_button.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.error, this.onPressed});
  final String error;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Center(child: Assets.images.error.image()),
        AppSpacer(heightRatio: 1),
        Text("please try again", style: TextStyles.bold20),
        if (kDebugMode)
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyles.regular14.copyWith(color: Colors.red),
          ),
        
        AppProgressButton(
          onPressed: (val) {
            onPressed!();
          },
          text: "Retry",
        ),
      ],
    ).paddingAll(20.sp);
  }
}
