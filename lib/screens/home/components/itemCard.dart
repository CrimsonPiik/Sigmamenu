import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/style/AssetsManager.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/style/ScreenUtil.dart';
import '../../../style/Style.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final bool isBordered;
  final bool isWithFavorite;
  final bool isFavoriteScreen;
  final Color? color;
  const ItemCard({
    Key? key,
    required this.product,
    required this.isBordered,
    this.color,
    this.isWithFavorite = false,
    this.isFavoriteScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double cardHeight = 200; //300
    final double cardWidth = 130;
    return Container(
      decoration: BoxDecoration(
        // border: isBordered ? Border.all(color: Style.beigeBrown) : null,
        borderRadius: BorderRadius.all(Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: isBordered ? 2 : 1,
            blurRadius: isBordered ? 9 : 9,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    product: product,
                  ),
                ),
              ),
            },
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
                  // isBordered
                  // ?
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
                      child: CommonUI.cachedImage(
                          product.image, ImageAssets.placeholder,
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
                        color:
                            color ?? Theme.of(context).cardColor, //Style.cream,
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
                            width: isBordered ? double.maxFinite : cardWidth,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: SizedBox(
                                // height: 10,
                                child: CommonUI.text(
                                  context: context,
                                  text: product.nameEn,
                                  // RhinoLanguage.isLTR()
                                  //     ? product.nameEn
                                  //     : product.nameAr,
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
                          //   width: isBordered ? double.maxFinite : cardWidth,
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
                            width: isBordered ? double.maxFinite : cardWidth,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: SizedBox(
                                // height: 10,
                                child: CommonUI.text(
                                    context: context,
                                    text: ' JOD ' + product.price.toString(),
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
}
