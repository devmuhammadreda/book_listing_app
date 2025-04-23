import 'package:flutter/material.dart';

import '../../l10n/messages.dart';

extension Translations on BuildContext {
  S get translate => S.of(this);
}

extension BuildContextExtensions on BuildContext {
  /// Returns the screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns the screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns a percentage of the screen height
  double heightPercentage(double percentage) =>
      screenHeight * (percentage / 100);

  /// Returns a percentage of the screen width
  double widthPercentage(double percentage) => screenWidth * (percentage / 100);
}
