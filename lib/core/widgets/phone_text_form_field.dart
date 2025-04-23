import '../../core/global/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/colors_manager.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../core/services/get_storage_helper.dart';
import '../theme/text_styles.dart';

class PhoneTextFormField extends StatelessWidget {
  const PhoneTextFormField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onCountryChanged,
    this.initialValue = AppConstants.appPhoneKey,
    this.initialCountryCode = AppConstants.appCountryKey,
    required this.hintText,
    this.name,
    this.isRequired = false,
    this.readOnly = false,
    this.showLength = true,
  });

  final TextEditingController controller;
  final void Function(PhoneNumber)? onChanged;
  final void Function(Country)? onCountryChanged;
  final String initialValue;
  final String initialCountryCode;
  final String hintText;
  final String? name;
  final bool isRequired;
  final bool readOnly;
  final bool showLength;
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (validator) {
        if (isRequired && controller.text.isEmpty) {
          return "";
        }
        if (controller.text.isNotEmpty) {
          String pattern = r'(^[0-9]*$)';
          RegExp regExp = RegExp(pattern);
          if (!regExp.hasMatch(controller.text)) {
            return "";
          }
        }
        return null;
      },
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (name != null) Text(name ?? "", style: TextStyles.regular14),
            if (name != null) SizedBox(height: 8.sp),
            AbsorbPointer(
              absorbing: readOnly,
              child: IgnorePointer(
                ignoring: readOnly,
                child: IntlPhoneField(
                  readOnly: readOnly,
                  disableLengthCheck: !showLength,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  languageCode: CacheHelper.getLocale,
                  dropdownTextStyle: TextStyles.medium14.copyWith(
                    color: Colors.grey,
                  ),
                  dropdownIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                  style: TextStyles.medium14.copyWith(color: Colors.grey),
                  cursorColor: Colors.grey,
                  autofocus: false,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintTextDirection:
                        CacheHelper.getLocale == AppConstants.en
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    filled: false,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    alignLabelWithHint: true,
                    hintStyle: TextStyles.medium14.copyWith(color: Colors.grey),
                    errorStyle: TextStyles.medium12.copyWith(color: Colors.red),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide(
                        color: ColorsManager.error,
                        width: 0.5,
                      ),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide(
                        color: ColorsManager.error,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide(
                        color: ColorsManager.primary,
                        width: 0.5,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  controller: controller,
                  initialCountryCode: initialCountryCode,
                  initialValue: initialValue,
                  validator: (value) {
                    String pattern = r'(^[0-9]*$)';
                    RegExp regExp = RegExp(pattern);
                    if (value!.number.isEmpty) {
                      return "";
                    } else if (!regExp.hasMatch(value.number)) {
                      return "";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    field.didChange(value.completeNumber);
                    if (onChanged != null) {
                      onChanged!(value);
                    }
                  },
                  onCountryChanged: onCountryChanged,
                ),
              ),
            ),
            if (field.hasError)
              Text(
                field.errorText!,
                style: TextStyles.regular14.copyWith(color: Colors.red),
              ),
          ],
        );
      },
    );
  }
}
