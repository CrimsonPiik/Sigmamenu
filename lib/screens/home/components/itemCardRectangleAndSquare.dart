import 'package:flutter/material.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/screens/home/components/ItemCardRectangle.dart';
import 'package:sigmamenu/screens/home/components/ItemCardSquares.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Session.dart';

class ItemCardRectangleAndSquare extends StatefulWidget {
  final List<Product> productList;
  final ScrollController? controller;

  const ItemCardRectangleAndSquare({
    Key? key,
    required this.productList,
    this.controller,
  }) : super(key: key);

  @override
  _ItemCardRectangleAndSquareState createState() =>
      _ItemCardRectangleAndSquareState();
}

class _ItemCardRectangleAndSquareState extends State<ItemCardRectangleAndSquare>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isList = true;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    List<Product> products = widget.productList;
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Align(
              // alignment: Alignment.topRight,
              // padding: const EdgeInsets.symmetric(horizontal: 6),
              // /child:
              IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.view_list,
                  progress: animationController,
                ),
                onPressed: () {
                  ///toggle controls the animation Forward and Backward
                  toggle();
                  setState(() {
                    Session.isList = !Session.isList;
                  });
                },
                // )
              ),
              SizedBox(width: 20),
            ],
          ),
          Session.isList
              ? Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.isDesktop(context)
                            ? 7
                            : Responsive.isTablet(context)
                                ? 4
                                : 2,
                        mainAxisSpacing: kDefaultPaddin,
                        crossAxisSpacing: kDefaultPaddin,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) => ItemCardSquares(
                        product: products[index],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: GridView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: Responsive.isDesktop(context)
                              ? 8.2
                              : Responsive.isMobile(context)
                                  ? 2.30
                                  : 1.75),
                      itemBuilder: (context, index) => ItemCardRectangle(
                        product: products[index],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
