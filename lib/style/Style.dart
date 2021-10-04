import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/style/ScreenUtil.dart';

//~~ Zuhair
// this is not themeData i swear to god it not themeData its just for the custom colors that i will use it in application
class Style {
  static const MaterialColor primary = MaterialColor(
    0Xff6F5B3E, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff5e4d36), //10%
      100: Color(0xff544530), //20%
      200: Color(0xff4c3d29), //30%
      300: Color(0xff473722), //40%
      400: Color(0xff3f311e), //50%
      500: Color(0xff382b1a), //60%
      600: Color(0xff352817), //70%
      700: Color(0xff2b2012), //80%
      800: Color(0xff23190c), //90%
      900: Color(0xff160f06), //100%
    },
  );

  static const Color backgroundColor = Colors.white;

  static const Color textColor = Colors.black;
  static const Color brownTextColor = Color(0xff6F5B3E);
  static const Color beige = Color(0xffC4AE78);
  static const Color cream = Color(0xffF9F6F0);
  static const Color unselected = Color(0xff979797);
  static const Color almostBlack = Color(0xff222020);
  static const Color darkBrown = Color(0xff4F3B1E);
  static const Color canvasColor = Color(0xfff9f6f0);
  static const Color grey = Color(0xffD8D7D3);
  static const Color beigeBrown = Color(0xff6F5B3E);
  static const Color starColor = Color(0xffF8D418);
  static const Color beigeCoffee = Color(0xffC4AE78);
}

// for text style
class FontStyle {
  static const primaryFont = "Montserrat";
  static const secondaryFont = "OpenSans";
  static TextStyle title(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      FontWeight? fontWeight = FontWeight.normal}) {
    final TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      ScreenUtil.isDesktop(context)
          ? textTheme.headline4!
          : textTheme.headline5!,
      color: color ?? Style.textColor,
      shadow: shadow,
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? primaryFont,
    );
  }

  static TextStyle smallTitle(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      FontWeight? fontWeight = FontWeight.normal}) {
    final TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      textTheme.headline6!,
      color: color ?? Style.textColor,
      shadow: shadow,
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? primaryFont,
    );
  }

  // static TextStyle headline4(
  //     {Color? color,
  //     bool shadow = false,
  //     String? fontFamily,
  //     required BuildContext context,
  //     FontWeight? fontWeight: FontWeight.normal}) {
  //   TextTheme textTheme = Theme.of(context)
  //       .textTheme
  //       .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
  //   return style(
  //     textTheme.headline4!,
  //     color: color ?? Style.textColor,
  //     shadow: shadow,
  //     fontWeight: fontWeight,
  //     fontFamily: fontFamily ?? primaryFont,
  //   );
  // }
  static TextStyle subTitle(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      TextDecoration decoration = TextDecoration.none,
      FontWeight? fontWeight = FontWeight.normal}) {
    final TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      textTheme.subtitle1!,
      color: color,
      shadow: shadow,
      decoration: decoration,
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? primaryFont,
    );
  }

  static TextStyle normal(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      TextDecoration decoration = TextDecoration.none,
      FontWeight? fontWeight = FontWeight.normal}) {
    final TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      ScreenUtil.isDesktop(context)
          ? textTheme.bodyText1!
          : textTheme.bodyText2!,
      color: color,
      shadow: shadow,
      decoration: decoration,
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? primaryFont,
    );
  }

  static TextStyle caption(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      TextDecoration decoration = TextDecoration.none,
      FontWeight? fontWeight = FontWeight.normal}) {
    final TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      textTheme.caption!,
      color: color,
      shadow: shadow,
      decoration: decoration,
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? primaryFont,
    );
  }

  static TextStyle overline(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      TextDecoration decoration = TextDecoration.none,
      FontWeight? fontWeight = FontWeight.normal}) {
    final TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      textTheme.overline!,
      color: color,
      fontSize: 10,
      shadow: shadow,
      decoration: decoration,
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? primaryFont,
    );
  }

  static TextStyle button(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      TextDecoration decoration = TextDecoration.none,
      FontWeight? fontWeight = FontWeight.normal}) {
    final TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      textTheme.button!,
      color: color,
      fontSize: 10,
      shadow: shadow,
      decoration: decoration,
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? primaryFont,
    );
  }

  static TextStyle style(TextStyle textStyle,
      {Color? color,
      double? fontSize,
      String? fontFamily,
      bool shadow = false,
      TextDecoration decoration = TextDecoration.none,
      FontWeight? fontWeight = FontWeight.normal}) {
    return textStyle.copyWith(
        fontWeight: fontWeight ?? textStyle.fontWeight,
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily ?? primaryFont,
        decoration: decoration,
        shadows: [
          Shadow(
            blurRadius: shadow ? 1.0 : 0,
            color: shadow ? Colors.black : Colors.transparent,
            offset: shadow ? const Offset(1.0, 1.0) : const Offset(0, 0),
          )
        ]);
  }
}
// ignore this for now please
// ThemeData? applicationThemeData(
//     {Brightness? brightness,
//     VisualDensity? visualDensity,
//     MaterialColor? primarySwatch,
//     Color? primaryColor,
//     Brightness? primaryColorBrightness,
//     Color? primaryColorLight,
//     Color? primaryColorDark,
//     Color? accentColor,
//     Brightness? accentColorBrightness,
//     Color? canvasColor,
//     Color? shadowColor,
//     Color? scaffoldBackgroundColor,
//     Color? bottomAppBarColor,
//     Color? cardColor,
//     Color? dividerColor,
//     Color? focusColor,
//     Color? hoverColor,
//     Color? highlightColor,
//     Color? splashColor,
//     InteractiveInkFeatureFactory? splashFactory,
//     Color? selectedRowColor,
//     Color? unselectedWidgetColor,
//     Color? disabledColor,
//     Color? buttonColor,
//     ButtonThemeData? buttonTheme,
//     ToggleButtonsThemeData? toggleButtonsTheme,
//     Color? secondaryHeaderColor,
//     Color? textSelectionColor,
//     Color? cursorColor,
//     Color? textSelectionHandleColor,
//     Color? backgroundColor,
//     Color? dialogBackgroundColor,
//     Color? indicatorColor,
//     Color? hintColor,
//     Color? errorColor,
//     Color? toggleableActiveColor,
//     String? fontFamily,
//     TextTheme? textTheme,
//     TextTheme? primaryTextTheme,
//     TextTheme? accentTextTheme,
//     InputDecorationTheme? inputDecorationTheme,
//     IconThemeData? iconTheme,
//     IconThemeData? primaryIconTheme,
//     IconThemeData? accentIconTheme,
//     SliderThemeData? sliderTheme,
//     TabBarTheme? tabBarTheme,
//     TooltipThemeData? tooltipTheme,
//     CardTheme? cardTheme,
//     ChipThemeData? chipTheme,
//     TargetPlatform? platform,
//     MaterialTapTargetSize? materialTapTargetSize,
//     bool? applyElevationOverlayColor,
//     PageTransitionsTheme? pageTransitionsTheme,
//     AppBarTheme? appBarTheme,
//     ScrollbarThemeData? scrollbarTheme,
//     BottomAppBarTheme? bottomAppBarTheme,
//     ColorScheme? colorScheme,
//     DialogTheme? dialogTheme,
//     FloatingActionButtonThemeData? floatingActionButtonTheme,
//     NavigationRailThemeData? navigationRailTheme,
//     Typography? typography,
//     NoDefaultCupertinoThemeData? cupertinoOverrideTheme,
//     SnackBarThemeData? snackBarTheme,
//     BottomSheetThemeData? bottomSheetTheme,
//     PopupMenuThemeData? popupMenuTheme,
//     MaterialBannerThemeData? bannerTheme,
//     DividerThemeData? dividerTheme,
//     ButtonBarThemeData? buttonBarTheme,
//     BottomNavigationBarThemeData? bottomNavigationBarTheme,
//     TimePickerThemeData? timePickerTheme,
//     TextButtonThemeData? textButtonTheme,
//     ElevatedButtonThemeData? elevatedButtonTheme,
//     OutlinedButtonThemeData? outlinedButtonTheme,
//     TextSelectionThemeData? textSelectionTheme,
//     DataTableThemeData? dataTableTheme,
//     CheckboxThemeData? checkboxTheme,
//     RadioThemeData? radioTheme,
//     SwitchThemeData? switchTheme,
//     bool? fixTextFieldOutlineLabel,
//     bool? useTextSelectionTheme}) {
//   // customize from here
//   primarySwatch = Style.primary;
//   primaryColor = Style.primary;
//   secondaryHeaderColor = Style.secondaryHeaderColor;
//   accentColor = Style.accentColor; //Light Brown
//   backgroundColor = Style.backgroundColor;
//   scaffoldBackgroundColor = Style.backgroundColor; //GREY
//   canvasColor = Style.canvasColor;
// }