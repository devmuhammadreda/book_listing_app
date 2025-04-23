class Dimensions {
  static const double mobile = 480;
  static const double tablet = 900;
  static const double desktop = 1200;
  static const double largeDesktop = 1600;
  static double sideWidth(double width) {
    switch (width) {
      // case <= mobile:
      case > tablet && < desktop:
        return 100;

      default:
        return 250;
    }
  }
}
