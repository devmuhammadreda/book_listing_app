import 'package:flutter/material.dart';

import 'dimentions.dart';

class Layout extends StatelessWidget {
  const Layout(
      {super.key,
      required this.mobile,
      required this.desktop,
      this.tablet,
      this.landScape});
  final Widget mobile;
  final Widget desktop;
  final Widget? tablet;
  final Widget? landScape;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      switch (constraints.maxWidth) {
        case <= Dimensions.mobile:
          return mobile;
        case <= Dimensions.tablet:
          return tablet ?? mobile;
        case <= Dimensions.desktop:
          return desktop;
        case <= Dimensions.largeDesktop:
        default:
          return landScape ?? desktop;
      }
    });
  }
}