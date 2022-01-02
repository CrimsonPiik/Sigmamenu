import 'package:flutter/material.dart';

class Style {
  // for primarySwatch
  static const MaterialColor primary = const MaterialColor(
    0xff00837b, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff05ccb9), //10%
      100: const Color(0xff04b2a1), //20%
      200: const Color(0xff039183), //30%
      300: const Color(0xff03897c), //40%
      400: const Color(0xff047267), //50%
      500: const Color(0xff005950), //60%
      600: const Color(0xff074943), //70%
      700: const Color(0xff0c3f3a), //80%
      800: const Color(0xff082825), //90%
      900: const Color(0xff01110f), //100%
    },
  );
  static const Color primaryOrange = Color(0xffEA9010);
  static Color textColor = Colors.grey.shade800;
  static const Color titleColor = Color(0xff666666);
  static const Color starColor = Color(0xfff7d82a);
  static const Color itemColor = Color(0xfff2f2f2);
  static const Color unselectColor = Color(0xffcccccc);
  static const Color background = Color(0xfff9f9f9);

  static const Color primaryBlue = Color(0xff00837b);
}

class FontStylee {
  static var primaryFont = "<Montserrat>";
  static const secondaryFont = "OpenSans";

  static TextStyle title(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      FontWeight? fontWeight: FontWeight.normal}) {
    TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      textTheme.headline5!,
      color: color ?? Style.titleColor,
      shadow: shadow,
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? primaryFont,
    );
  }

  static TextStyle headline6(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      FontWeight? fontWeight: FontWeight.normal}) {
    TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      textTheme.headline6!,
      color: color ?? Style.titleColor,
      shadow: shadow,
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? primaryFont,
    );
  }

  static TextStyle subTitle(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      TextDecoration decoration = TextDecoration.none,
      FontWeight? fontWeight: FontWeight.normal}) {
    TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      textTheme.subtitle1!,
      color: color,
      shadow: shadow,
      decoration: decoration,
      fontWeight: fontWeight!,
      fontFamily: fontFamily ?? primaryFont,
    );
  }

  static TextStyle normal(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      TextDecoration decoration = TextDecoration.none,
      FontWeight? fontWeight: FontWeight.normal}) {
    TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      textTheme.bodyText2!,
      color: color,
      shadow: shadow,
      decoration: decoration,
      fontWeight: fontWeight!,
      fontFamily: fontFamily ?? primaryFont,
    );
  }

  static TextStyle small(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      TextDecoration decoration = TextDecoration.none,
      FontWeight? fontWeight: FontWeight.normal}) {
    TextTheme textTheme = Theme.of(context)
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

  static TextStyle smaller(
      {Color? color,
      bool shadow = false,
      String? fontFamily,
      required BuildContext context,
      TextDecoration decoration = TextDecoration.none,
      FontWeight? fontWeight: FontWeight.normal}) {
    TextTheme textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: primaryFont, bodyColor: Style.textColor);
    return style(
      textTheme.caption!,
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
      FontWeight? fontWeight: FontWeight.normal}) {
    return textStyle.copyWith(
        fontWeight: fontWeight != null ? fontWeight : textStyle.fontWeight,
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily ?? primaryFont,
        decoration: decoration,
        shadows: [
          Shadow(
            blurRadius: shadow ? 1.0 : 0,
            color: shadow ? Colors.black : Colors.transparent,
            offset: shadow ? Offset(1.0, 1.0) : Offset(0, 0),
          )
        ]);
  }
}
