import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/style/AssetsManager.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class ItemCardRectangle extends StatefulWidget {
  final Product product;
  // final bool isWithFavorite;
  // final bool isFavoriteScreen;
  ItemCardRectangle({
    Key? key,
    required this.product,
    // this.isWithFavorite = false,
    // this.isFavoriteScreen = false,
  }) : super(key: key);

  @override
  State<ItemCardRectangle> createState() => _ItemCardRectangleState();
}

class _ItemCardRectangleState extends State<ItemCardRectangle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animationDialog(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 9,
              offset: Offset(1, 9),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
                width: Responsive.isDesktop(context)
                    ? 160
                    : Responsive.isTablet(context)
                        ? 155
                        : Responsive.isMobile(context)
                            ? 150
                            : 100,
                height: Responsive.isDesktop(context)
                    ? 160
                    : Responsive.isTablet(context)
                        ? 155
                        : Responsive.isMobile(context)
                            ? 150
                            : 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: CommonUI.cachedImage(
                    widget.product.image, ImageAssets.placeholder,
                    fit: BoxFit.cover)),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  // CommonUI.text(
                  //   context: context,
                  //   text: ProjectLanguage.isLTR()
                  //       ? widget.product.nameEn
                  //       : widget.product.nameAr,
                  //   textAlign: TextAlign.center,
                  //   maxLines: 2,
                  //   style: FontStyle.normal(
                  //       context: context,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black),
                  // ),

                  Text(
                    ProjectLanguage.isLTR()
                        ? widget.product.nameEn
                        : widget.product.nameAr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.isMiniMobile(context) ? 12 : 14),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Text('JOD ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  Responsive.isMiniMobile(context) ? 12 : 14,
                              color: Colors.black)),
                      Text(widget.product.price.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  Responsive.isMiniMobile(context) ? 12 : 14,
                              color: Colors.red)),
                    ],
                  ),
                  // SizedBox(
                  //   height: 25,
                  // ),
                  // CommonUI.text(
                  //   context: context,
                  //   text: ProjectLanguage.isLTR()
                  //       ? widget.product.descriptionEn
                  //       : widget.product.descriptionAr,
                  //   textAlign: TextAlign.start,
                  //   maxLines: 3,
                  //   style: FontStyle.smaller(
                  //       context: context,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black.withOpacity(0.7)),
                  // ),
                  SizedBox(
                    height: Responsive.isMiniMobile(context) ? 5 : 9,
                  ),
                  Text(
                    ProjectLanguage.isLTR()
                        ? widget.product.descriptionEn
                        : widget.product.descriptionAr,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: Responsive.isMiniMobile(context) ? 2 : 3,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _fromTop = false;
  _animationDialog(context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Product Animation",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 600),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Dismissible(
          direction: DismissDirection.down,
          onDismissed: (_) {
            Navigator.of(context).pop();
          },
          key: Key("key"),
          child: SafeArea(
            child: SizedBox.expand(
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              // height:Responsive.isDesktop(context)
                              //     ? 800 : 1000,
                              width: Responsive.isDesktop(context)
                                  ? Responsive.width(context) / 2
                                  : Responsive.width(context),
                              padding: EdgeInsets.only(
                                  left: kDefaultPaddin * 1.5,
                                  right: kDefaultPaddin * 1.5,
                                  bottom: kDefaultPaddin),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: kDefaultPaddin * 2,
                                        ),
                                        //  child: Contianer(
                                        // tag: "${widget.product.id}",
                                        child: Image.network(
                                          widget.product.image,
                                          width: 150,
                                          height: 140,
                                          fit: BoxFit.cover,
                                          // ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:
                                                Responsive.isMiniMobile(context)
                                                    ? 100
                                                    : 140,
                                            child: Text(
                                              ProjectLanguage.isLTR()
                                                  ? widget.product.nameEn
                                                  : widget.product.nameAr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        Responsive.isMiniMobile(
                                                                context)
                                                            ? 16
                                                            : 19,
                                                  ),
                                              maxLines: 3,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(height: 9),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(text: "Price\n"),
                                                TextSpan(
                                                  text:
                                                      "${widget.product.price} JOD",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 25.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Responsive.isDesktop(context)
                                              ? Responsive.width(context) / 2.2
                                              : Responsive.width(context) /
                                                  1.35,
                                          child: Text(
                                            "Description",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Responsive.isMiniMobile(
                                                              context)
                                                          ? 16
                                                          : 19,
                                                ),
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Container(
                                          child: Text(
                                            ProjectLanguage.isLTR()
                                                ? "${widget.product.descriptionEn}"
                                                : "${widget.product.descriptionAr}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontSize:
                                                      Responsive.isMiniMobile(
                                                              context)
                                                          ? 10
                                                          : 12,
                                                ),
                                          ),
                                        ),
                                        SizedBox(height: 300),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                        top: -30,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 30,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, _fromTop ? -1 : 1), end: Offset(0, 0.25))
                  .animate(anim1),
          child: child,
        );
      },
    );
  }
}
