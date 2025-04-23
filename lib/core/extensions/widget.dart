import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/app_spacer.dart';

/// add Padding Property to widget
extension WidgetPaddingX on Widget {
  List<Widget> operator *(times) => List.generate(times, (index) => this);
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) => Padding(
    padding: EdgeInsets.only(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );

  Widget get horizontalScreenPadding =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 20.sp), child: this);

  Widget get scrollHorizontalScreenPadding =>
      Padding(padding: EdgeInsets.only(left: 20.sp), child: this);

  Widget hideKeyboard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: this,
    );
  }
}

/// Add margin property to widget
extension WidgetMarginX on Widget {
  Widget marginAll(double margin) =>
      Container(margin: EdgeInsets.all(margin), child: this);

  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) => Container(
    margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
    child: this,
  );

  Widget get marginZero => Container(margin: EdgeInsets.zero, child: this);
}

/// Allows you to insert widgets inside a CustomScrollView
extension WidgetSliverBoxX on Widget {
  Widget get sliverBox => SliverToBoxAdapter(child: this);
}

// Extension on Widget with just width and height spacing
extension AppSpacerExtension on Widget {
  // Adds horizontal spacing (width) using AppSpacer
  Widget spaceWidth([double widthRatio = 1]) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppSpacer(widthRatio: widthRatio, heightRatio: 0),
        this,
      ],
    );
  }

  // Adds vertical spacing (height) using AppSpacer
  Widget spaceHeight([double heightRatio = 1]) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppSpacer(widthRatio: 0, heightRatio: heightRatio),
        this,
      ],
    );
  }
}
