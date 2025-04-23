import 'package:flutter/material.dart';

import '../theme/size_config.dart';

class AppSpacer extends StatelessWidget {
  final double widthRatio;
  final double heightRatio;

  const AppSpacer({this.widthRatio = 1, this.heightRatio = 1, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.hPadding * widthRatio,
      height: SizeConfig.vPadding * heightRatio,
    );
  }
}
