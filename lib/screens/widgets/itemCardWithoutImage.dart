import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/GeneralFunction/constaints.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/style/AssetsManager.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class ItemCardWithoutImage extends StatefulWidget {
  final Product product;
  ItemCardWithoutImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ItemCardWithoutImage> createState() => _ItemCardWithoutImageState();
}

class _ItemCardWithoutImageState extends State<ItemCardWithoutImage> {
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
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(1, 6),
            ),
          ],
        ),
        child: ProjectLanguage.isLTR() // EN
            ? Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ProjectLanguage.isLTR()
                                ? widget.product.nameEn
                                : widget.product.nameAr,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Responsive.isMiniMobile(context) ? 18 : 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                  width: 165,
                                  child: Text(
                                    ProjectLanguage.isLTR()
                                        ? widget.product.descriptionEn
                                        : widget.product.descriptionAr,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: Responsive.isMiniMobile(context)
                                        ? 2
                                        : 3,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, left: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(widget.product.price.toString(),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Responsive.isMiniMobile(context)
                                                    ? 19
                                                    : 23,
                                            color: Colors.black)),
                                    Text(' JOD',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Responsive.isMiniMobile(context)
                                                    ? 19
                                                    : 23,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Row(
                // AR
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          ProjectLanguage.isLTR()
                              ? widget.product.nameEn
                              : widget.product.nameAr,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  Responsive.isMiniMobile(context) ? 12 : 14),
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(widget.product.price.toString(),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Responsive.isMiniMobile(context)
                                        ? 12
                                        : 14,
                                    color: Colors.black)),
                            Text(' JOD',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Responsive.isMiniMobile(context)
                                        ? 12
                                        : 14,
                                    color: Colors.black)),
                          ],
                        ),
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
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                      width: 150,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CommonUI.cachedImage(
                          widget.product.image, ImageAssets.foodplaceholder,
                          fit: BoxFit.cover)),
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
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Dismissible(
          direction: DismissDirection.down,
          onDismissed: (_) {
            Navigator.pop(context);
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
                                          width: 140,
                                          height: 170,
                                          padding: EdgeInsets.only(
                                            top: kDefaultPaddin * 2,
                                          ),
                                          child: CommonUI.cachedImage(
                                              widget.product.image,
                                              ImageAssets.foodplaceholder,
                                              fit: BoxFit.cover)),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 6),
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
                                                TextSpan(
                                                    text:
                                                        ProjectLanguage.isLTR()
                                                            ? "Price\n"
                                                            : "السعر\n"),
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
                                            ProjectLanguage.isLTR()
                                                ? "Description"
                                                : "الوصف",
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
                                        SizedBox(height: 350),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        height: 6,
                        width: 100.0,
                      ),
                    ),
                    // Positioned(
                    //     top: -30,
                    //     child: Center(
                    //       child: CircleAvatar(
                    //         backgroundColor: Colors.grey,
                    //         radius: 30,
                    //         child: GestureDetector(
                    //           onTap: () {
                    //             Navigator.of(context).pop();
                    //           },
                    //           child: Icon(
                    //             Icons.keyboard_arrow_down_sharp,
                    //             color: Colors.white,
                    //             size: 35,
                    //           ),
                    //         ),
                    //       ),
                    //     )),
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
