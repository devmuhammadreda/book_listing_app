import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../core/theme/colors_manager.dart';
import '../theme/text_styles.dart';

class PinCodeFields extends StatelessWidget {
  const PinCodeFields({super.key, this.onCompleted, required this.onChanged});
  final void Function(String)? onCompleted;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      autoFocus: true,
      cursorColor: ColorsManager.primary,
      textStyle: TextStyles.bold24,
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      length: 4,
      validator: (val) {
        if (val == null || val.length < 4) {
          return "Please enter a valid code";
        }
        return null;
      },
      animationType: AnimationType.scale,
      enablePinAutofill: true,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8.r),
        fieldHeight: 70.sp,
        fieldWidth: 70.sp,
        activeColor: ColorsManager.black,
        inactiveColor: ColorsManager.borderColor,
        selectedColor: ColorsManager.primary,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: false,
      onCompleted: onCompleted,
      onChanged: onChanged,
    );
  }
}
