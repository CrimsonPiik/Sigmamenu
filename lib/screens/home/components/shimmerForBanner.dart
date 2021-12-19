import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sigmamenu/GeneralFunction/constaints.dart';
import 'package:sigmamenu/style/CommonShape.dart';

class ShimmerForBanner extends StatelessWidget {
  const ShimmerForBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.4),
          highlightColor: Colors.grey.withOpacity(0.2),
          child: Card(
            shape: CommonShapes.b16pxRadius,
            elevation: 1,
            child: Container(
              height: 120,
           
            ),
          )),
    );
  }
}
