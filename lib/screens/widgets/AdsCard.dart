import 'package:flutter/material.dart';
import 'package:sigmamenu/style/CommonShape.dart';
import 'package:sigmamenu/style/CommonUI.dart';

// ignore: must_be_immutable
class AdsCard extends StatelessWidget {
  final String image;
  // final String description;
  final VoidCallback click;
  bool? isBanner;
  AdsCard({
    Key? key,
    required this.image,
    // required this.description,
    required this.click,
    this.isBanner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: isBanner == true
          ? EdgeInsets.symmetric(horizontal: size.width * 0.05)
          : EdgeInsets.all(0),
      child: Card(
        shape: CommonShapes.b16pxRadius,
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        child: InkWell(
          onTap: click,
          child: Stack(
            children: [
              SizedBox(
                height: 170,
                width: double.infinity,
                child: CommonUI.cachedImage(
                    image, 'assets/images/placeholder.jpg',
                    fit: BoxFit.fill),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(90),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  // child: Padding(
                  // padding: const EdgeInsets.all(8.0),
                  // child: Text(
                  // description,
                  // style: FontStyle.normal(
                  // context: context, color: Colors.white),
                  // ),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
