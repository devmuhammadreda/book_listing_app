import 'package:flutter/material.dart';

class ColorsManager {
  static const Color primary = Color(0xFFFF5500);
  static const Color subPrimary = Color(0xFF1E1E1E);
  static const Color scaffoldBackground = Color(0xFFFFFFFF);
  static const Color star = Color(0xFFFBEC26);
  static const Color dotColor = Color(0xFFADB3BC);
  static const Color accent = Color.fromARGB(255, 2, 30, 100);
  static const Color white = Color(0xFFFFFFFF);
  static const Color selection = Color(0xFF3E6FCF);
  static const Color light = Color(0xFFEFF4F8);
  static const Color lightBlue = Color(0xFF009AE2);
  static const Color pink = Color(0xFFF72585);
  static const Color offWhite = Color(0xFFF3F3F3);
  static const Color veryLightGrey = Color(0xFFCDCDCD);
  static const Color checkBoxBorderColor = Color(0xFFD9D9D9);
  static const Color lightGrey = Color(0xFFF7F7F7);
  static const Color grey = Color(0xFF303030); //#8C8C8C
  static const Color darkGrey = Color(0xFF616161);
  static const Color veryDarkGrey = Color(0xFF505050);
  static const Color charcoal = Color(0xFF222222);
  static const Color black = Color(0xFF000000);
  static const Color error = Color(0xFFB00020);
  static const Color red = Color(0xFFFF4343);
  static const Color success = Color(0xFF00C853);
  static const Color blue = Color(0xFF3064CF);
  static const Color borderColor = Color(0xFFF2F2F2);
  static WidgetStateProperty<Color?> greyMatrialColor =
      WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return white;
        }
        return white;
      });

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1, 'shade values must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
      (darker ? (hsl.lightness - value) : (hsl.lightness + value)).clamp(
        0.0,
        1.0,
      ),
    );

    return hslDark.toColor();
  }

  static LinearGradient get onboardingGradient {
    return LinearGradient(
      colors: [Color(0xFFCE048C), Color(0xFF4D0A8E)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );
  }

  static LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFfABDCFF), Color(0xFF0396FF)],
  );

    static LinearGradient get visaLinearGradient {
    return LinearGradient(
      colors: [Color(0xFFE27BC1), Color(0xFFFF5500)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }

    static LinearGradient get mastercardLinearGradient {
    return LinearGradient(
      colors: [Color(0xFFA280C1), Color(0xFF4D0A8E)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}
