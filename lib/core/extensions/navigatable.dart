// Widget Extension for navigation
import 'package:flutter/material.dart';

import '../utils/router.dart';

extension NavigatableWidget on Widget {
  /// Navigate to this widget
  Future<dynamic> push(BuildContext context) => MagicRouter.navigateTo(this);

  /// Navigate to this widget, replacing the current page
  Future<dynamic> pushReplacement(BuildContext context) =>
      MagicRouter.navigateAndReplace(this);

  /// Navigate to this widget, removing all previous pages
  Future<dynamic> pushAndRemoveAll(BuildContext context) =>
      MagicRouter.navigateAndPopAll(this);

  /// Navigate to this widget, removing all pages until the first one
  Future<dynamic> pushAndRemoveUntilFirstPage(BuildContext context) =>
      MagicRouter.navigateAndPopUntilFirstPage(this);
}

extension NavigatableContext on BuildContext {
  /// Navigate to this widget
  Future<dynamic> push(Widget screen) => MagicRouter.navigateTo(screen);

  /// Navigate to this widget, replacing the current page
  Future<dynamic> pushReplacement(Widget screen) =>
      MagicRouter.navigateAndReplace(screen);

  /// Navigate to this widget, removing all previous pages
  Future<dynamic> pushAndRemoveAll(Widget screen) =>
      MagicRouter.navigateAndPopAll(screen);

  /// Navigate to this widget, removing all pages until the first one
  Future<dynamic> pushAndRemoveUntilFirstPage(Widget screen) =>
      MagicRouter.navigateAndPopUntilFirstPage(screen);
}
