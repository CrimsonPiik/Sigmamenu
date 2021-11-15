import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/style/AssetsManager.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import '../../../style/Style.dart';

class ItemCardSquares extends StatefulWidget {
  final Product product;
  final bool isWithFavorite;
  final bool isFavoriteScreen;
  final Color? color;
  ItemCardSquares({
    Key? key,
    required this.product,
    this.color,
    this.isWithFavorite = false,
    this.isFavoriteScreen = false,
  }) : super(key: key);

  @override
  State<ItemCardSquares> createState() => _ItemCardSquaresState();
}

class _ItemCardSquaresState extends State<ItemCardSquares> {
  @override
  Widget build(BuildContext context) {
    // final double cardHeight = 200; //300
    // final double cardWidth = 130;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 9,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () => {_animationDialog(context)},
            child: Container(
              // decoration: BoxDecoration(
              //   color: color ?? Theme.of(context).cardColor, //Style.cream,
              //   borderRadius: BorderRadius.vertical(
              //     // bottom: Radius.circular(14),
              //     top: Radius.circular(14),
              //   ),
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    // borderRadius:
                    //     BorderRadius.vertical(top: Radius.circular(28)),
                    child: Container(
                      height: Responsive.isDesktop(context)
                          ? 160
                          : Responsive.isTablet(context)
                              ? 155
                              : Responsive.isMobile(context)
                                  ? 150
                                  : 100,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(24),
                        //   topRight: Radius.circular(24),
                        //   bottomLeft: Radius.circular(24),
                        //   bottomRight: Radius.circular(24),
                        // ),
                      ),
                      child: CommonUI.cachedImage(
                          widget.product.image, ImageAssets.placeholder,
                          fit: BoxFit.cover),
                    ),
                  ),
                  // // :
                  // Expanded(
                  //   child: ConstrainedBox(
                  //       constraints: BoxConstraints(
                  //           minWidth: cardWidth, maxHeight: cardHeight * 0.7),
                  //       // child: ClipRRect(
                  //       //   borderRadius: const BorderRadius.vertical(
                  //       //       top: Radius.circular(28)),
                  //       child: CommonUI.cachedImage(
                  //           product.image, ImageAssets.placeholder,
                  //           fit: BoxFit.cover)),
                  // ),
                  Expanded(
                    child: Container(
                      // height: 240,
                      // width: isWithFavorite ? ScreenUtil.width(context) * 0.7 : null,
                      decoration: BoxDecoration(
                        color: widget.color ??
                            Theme.of(context).cardColor, //Style.cream,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(14),
                          // top: Radius.circular(14),
                        ),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: Responsive.isDesktop(context) ? 10 : 6),

                          SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: SizedBox(
                                // height: 10,
                                child: CommonUI.text(
                                  context: context,
                                  text: ProjectLanguage.isLTR()
                                      ? widget.product.nameEn
                                      : widget.product.nameAr,
                                  textAlign: TextAlign.center,
                                  style: FontStyle.small(
                                      context: context,
                                      fontWeight: FontWeight.bold),

                                  // maxLines: 1
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 1),
                          //     child: SizedBox(
                          //       height: 10,
                          //       child: CommonUI.text(
                          //           context: context,
                          //           text: product.descriptionEn,
                          //           textAlign: TextAlign.center,
                          //           style: FontStyle.normal(
                          //             context: context,
                          //           )),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                              height: Responsive.isDesktop(context) ? 9 : 5),
                          SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: SizedBox(
                                // height: 10,
                                child: CommonUI.text(
                                    context: context,
                                    text: ' JOD ' +
                                        widget.product.price.toString(),
                                    // RhinoLanguage.isLTR()
                                    //     ? product.nameEn
                                    //     : product.nameAr,
                                    textAlign: TextAlign.center,
                                    style: FontStyle.normal(
                                        context: context,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          // SelectableText("JOD 5",
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //         // color: product.isOnSale ? Colors.red : null,
                          //         // decoration: product.isOnSale
                          //         //     ? TextDecoration.lineThrough
                          //         //     : null,
                          //         )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _fromTop = true;

  _animationDialog(context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Product Animation",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 600),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        //  return    showDialog(
        // context: context,
        // builder: (BuildContext context) {
        return Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // SingleChildScrollView(
                      // child:

                      SizedBox(
                        child: Stack(
                          children: <Widget>[
                            // SingleChildScrollView(
                            // child:
                            Container(
                              width: Responsive.isDesktop(context)
                                  ? Responsive.width(context) / 2
                                  : Responsive.width(context),
                              padding: EdgeInsets.only(
                                  top: kDefaultPaddin * 2,
                                  left: kDefaultPaddin,
                                  right: kDefaultPaddin,
                                  bottom: kDefaultPaddin),
                              // height: size.height *1.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                  bottomLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: Hero(
                                      tag: "${widget.product.id}",
                                      child: Image.network(
                                        widget.product.image,
                                        width: 300,
                                        height: 250,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 18),
                                          Text(
                                            ProjectLanguage.isLTR()
                                                ? widget.product.nameEn
                                                : widget.product.nameAr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                          ),
                                          SizedBox(height: 12),

                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(text: "Price\n"),
                                                TextSpan(
                                                  text:
                                                      "\$${widget.product.price}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4!
                                                      .copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 40),
                                          // RichText(
                                          // text: TextSpan(
                                          // style: TextStyle(color: kTextColor),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // SizedBox(height: 35),
                                              Container(
                                                width: Responsive.isDesktop(
                                                        context)
                                                    ? Responsive.width(
                                                            context) /
                                                        2.2
                                                    : Responsive.width(
                                                            context) /
                                                        1.35,
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: "Description\n",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text: ProjectLanguage
                                                                  .isLTR()
                                                              ? "${widget.product.descriptionEn}"
                                                              : "${widget.product.descriptionAr}",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                  height: kDefaultPaddin * 2),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   top: Responsive.isDesktop(context)? 40 : 90,
            //   right: Responsive.isDesktop(context)? 320 :  0,
            //   child: FloatingActionButton(
            //     onPressed: () => Navigator.of(context).pop(),
            //     child: Icon(Icons.close),
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 60,
                height: 60,
                child: FloatingActionButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, _fromTop ? -1 : 1), end: Offset(0, 0))
                  .animate(anim1),
          child: child,
        );
      },
    );
  }
}
