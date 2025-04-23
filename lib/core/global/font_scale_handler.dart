const double minimumScale = .8;
const double maximumScale = .8;
const double defaultScale = 1;

class FontScaleHandler {
  static double deviceTextScale = defaultScale;

  /// calculates the font size based on the device's
  /// text scale factor. It ensures the font size respects
  /// minimum and maximum scaling limits
  /// defined by minimumScale and maximumScale.
  static double calculateFontSize(double fontSize) {
    double textScaleFactorMargin = 1;
    if (deviceTextScale < minimumScale) {
      textScaleFactorMargin = minimumScale;
    } else if (deviceTextScale > maximumScale) {
      textScaleFactorMargin = maximumScale;
    }
    return (fontSize * textScaleFactorMargin) / deviceTextScale;
  }
}