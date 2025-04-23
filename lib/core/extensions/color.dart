import 'package:flutter/material.dart';

import '../theme/colors_manager.dart';

extension ColorEx on Color {
  MaterialColor materialColor() {
    final double r = ColorsManager.primary.r;
    final double g = ColorsManager.primary.g;
    final double b = ColorsManager.primary.b;
    final Map<int, Color> shades = {
      50: Color.from(red: r, green: g, blue: b, alpha: .1),
      100: Color.from(red: r, green: g, blue: b, alpha: .2),
      200: Color.from(red: r, green: g, blue: b, alpha: .3),
      300: Color.from(red: r, green: g, blue: b, alpha: .4),
      400: Color.from(red: r, green: g, blue: b, alpha: .5),
      500: Color.from(red: r, green: g, blue: b, alpha: .6),
      600: Color.from(red: r, green: g, blue: b, alpha: .7),
      700: Color.from(red: r, green: g, blue: b, alpha: .8),
      800: Color.from(red: r, green: g, blue: b, alpha: .9),
      900: Color.from(red: r, green: g, blue: b, alpha: 1),
    };
    return MaterialColor(ColorsManager.primary.toInt32, shades);
  }

  static int floatToInt8(double x) {
    return (x * 255.0).round() & 0xff;
  }

  int get toInt32 {
    return floatToInt8(a) << 24 |
        floatToInt8(r) << 16 |
        floatToInt8(g) << 8 |
        floatToInt8(b) << 0;
  }


}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool hashSign = false, bool withAlpha = false}) {
    final alpha = (a * 255).toInt().toRadixString(16).padLeft(2, '0');
    final red = (r * 255).toInt().toRadixString(16).padLeft(2, '0');
    final green = (g * 255).toInt().toRadixString(16).padLeft(2, '0');
    final blue = (b * 255).toInt().toRadixString(16).padLeft(2, '0');

    return '${hashSign ? '#' : ''}'
            '${withAlpha ? alpha : ''}'
            '$red$green$blue'
        .toUpperCase();
  }
}
Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
