import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors_manager.dart';
import '../extensions/color.dart';
import 'font_manager.dart';
import 'text_styles.dart';

class ThemeManager {
  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.standard,
    primarySwatch: ColorsManager.primary.materialColor(),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: ColorsManager.primary.materialColor(),
      accentColor: ColorsManager.accent,
      backgroundColor: ColorsManager.white,
      brightness: Brightness.light,
      cardColor: ColorsManager.white,
      errorColor: ColorsManager.error,
    ),
    scaffoldBackgroundColor: ColorsManager.scaffoldBackground,
    primaryColor: ColorsManager.primary,
    primaryColorLight: ColorsManager.primary,
    disabledColor: ColorsManager.lightGrey,
    fontFamily: fontName,
    cardTheme: CardTheme(
      color: ColorsManager.white,
      shadowColor: ColorsManager.grey,
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      enableFeedback: true,
      backgroundColor: ColorsManager.primary,
      elevation: 8,
      shape: CircleBorder(),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: ColorsManager.grey ),
      backgroundColor: ColorsManager.scaffoldBackground,
      shadowColor: ColorsManager.black,
      centerTitle: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      titleTextStyle: TextStyles.regular16.copyWith(color: ColorsManager.white),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: ColorsManager.primary,
      disabledColor: ColorsManager.lightGrey,
      splashColor: ColorsManager.primary,
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primary,
        textStyle: TextStyles.bold16.copyWith(color: ColorsManager.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.primary,
      selectedItemColor: ColorsManager.accent,
      showSelectedLabels: true,
      unselectedItemColor: ColorsManager.grey,
      selectedLabelStyle: TextStyles.regular12.copyWith(
        color: ColorsManager.accent,
      ),
      unselectedLabelStyle: TextStyles.regular12.copyWith(
        color: ColorsManager.grey,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyles.bold18.copyWith(color: ColorsManager.black),
      titleMedium: TextStyles.medium16.copyWith(color: ColorsManager.black),
      titleSmall: TextStyles.medium14.copyWith(color: ColorsManager.black),
      bodySmall: TextStyles.regular14.copyWith(color: ColorsManager.black),
      bodyLarge: TextStyles.regular14.copyWith(color: ColorsManager.black),
    ),
    badgeTheme: const BadgeThemeData(backgroundColor: ColorsManager.red),
    tabBarTheme: const TabBarTheme(
      indicatorColor: ColorsManager.primary,
      labelColor: ColorsManager.primary,
      unselectedLabelColor: ColorsManager.lightGrey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      //border
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(64.0),
        borderSide: const BorderSide(color: ColorsManager.lightGrey),
      ),
      //hint text style
      hintStyle: TextStyles.regular12.copyWith(color: ColorsManager.lightGrey),
      //focused ERROR border
      focusedBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: ColorsManager.lightGrey),
        borderRadius: BorderRadius.circular(64.0),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: ColorsManager.red),
        borderRadius: BorderRadius.circular(64.0),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: ColorsManager.lightGrey),
        borderRadius: BorderRadius.circular(64.0),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: ColorsManager.lightGrey),
        borderRadius: BorderRadius.circular(64.0),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: ColorsManager.red),
        borderRadius: BorderRadius.circular(64.0),
      ),

      suffixStyle: TextStyles.regular12.copyWith(color: ColorsManager.grey),
      focusColor: ColorsManager.success,
      //focused ERROR hint text style
      errorStyle: TextStyles.regular12.copyWith(color: ColorsManager.red),
      //focused Label text style
      labelStyle: TextStyles.regular12.copyWith(color: ColorsManager.grey),
      filled: true,
      fillColor: Colors.white,

      ///fill COLOR
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    ),
    dialogTheme: DialogThemeData(backgroundColor: Colors.white),
  );
}
