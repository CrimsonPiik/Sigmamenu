import 'package:flutter/material.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class SigningButton extends StatelessWidget {
  final String text;
  final double radius = 16; //16.0,
  final Color? textColor;
  final double minWidth = 200;
  final double minHight = 50;
  final Color? color;
  final bool withIcon = false;
  final Color? borderColor;
  final TextStyle? textStyle;
  final Size? fixedSize;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final void Function() onPressed;
  const SigningButton(
      {Key? key,
      required this.text,
      this.textColor,
      this.color,
      this.borderColor,
      this.textStyle,
      this.fixedSize,
      this.icon,
      this.padding,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(
              Responsive.isMobile(context) ? minWidth : double.maxFinite,
              Responsive.isMobile(context) ? minHight : 60),
          fixedSize: fixedSize,
          animationDuration: const Duration(milliseconds: 300),
          primary: textColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          backgroundColor: color ?? Colors.transparent,
          side: BorderSide(color: borderColor ?? Colors.brown, width: 1.1),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text, style: textStyle),
        ));
  }
}
