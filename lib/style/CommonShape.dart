import 'package:flutter/material.dart';

//~~ Zuhair
/// this is for common shaps that used in card and Container
class CommonShapes {
  /////////////////////// for Container //////////////////////////////////
  static const BorderRadiusGeometry k32pxRadius =
      BorderRadius.all(Radius.circular(32));
  static const BorderRadiusGeometry k16pxRadius =
      BorderRadius.all(Radius.circular(16));
  static const BorderRadiusGeometry k10pxRadius =
      BorderRadius.all(Radius.circular(10));
  static const BorderRadiusGeometry k8pxRadius =
      BorderRadius.all(Radius.circular(8));
  /////////////////////// for Card //////////////////////////////////
  static const OutlinedBorder b32pxRadius = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)));
  static const OutlinedBorder b16pxRadius = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)));
  static const OutlinedBorder b10pxRadius = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)));
  static const OutlinedBorder b8pxRadius = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)));
      
  static OutlinedBorder outlinedBorder(double radius) {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)));
  }

  static BorderRadiusGeometry brRounded(double radius) {
    return BorderRadius.all(Radius.circular(radius));
  }

  static OutlinedBorder roundedOnly({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight)));
  }
}
