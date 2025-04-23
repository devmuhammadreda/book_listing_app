import '../theme/text_styles.dart';
import 'app_spacer.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.msg});
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppSpacer(heightRatio: 2),
          Icon(
            Icons.error_outline,
            size: 100,
            color: Theme.of(context).primaryColor,
          ),
          AppSpacer(heightRatio: 2),
          Text(msg, style: TextStyles.semiBold18),
        ],
      ),
    );
  }
}
