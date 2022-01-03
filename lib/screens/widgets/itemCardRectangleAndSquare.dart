import 'package:flutter/material.dart';
import 'package:sigmamenu/GeneralFunction/constaints.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/screens/widgets/ItemCardRectangle.dart';
import 'package:sigmamenu/screens/widgets/itemCardWithoutImage.dart';
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
              // ChangeLanguageButton(),

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
                      // physics: NeverScrollableScrollPhysics(),
                      // physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: Responsive.isDesktop(context)
                              ? 8.2
                              : Responsive.isMobile(context)
                                  ? 2.30
                                  : Responsive.isMiniMobile(context)
                                      ? 2.0
                                      : 4.0),
                      itemBuilder: (context, index) => ItemCardRectangle(
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
                      // physics: NeverScrollableScrollPhysics(),
                      // physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: Responsive.isDesktop(context)
                              ? 8.2
                              : Responsive.isMobile(context)
                                  ? 2.40
                                  : Responsive.isMiniMobile(context)
                                      ? 2.0
                                      : 4.0),
                      itemBuilder: (context, index) => ItemCardWithoutImage(
                        product: products[index],
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}


////
///
// ///import 'package:flutter/material.dart';
// import 'package:sigmamenu/GeneralFunction/constaints.dart';
// import 'package:sigmamenu/models/product.dart';
// import 'package:sigmamenu/screens/home/components/ItemCardRectangle.dart';
// import 'package:sigmamenu/screens/home/components/ItemCardSquares.dart';
// import 'package:sigmamenu/screens/home/components/categories.dart';
// import 'package:sigmamenu/screens/widgets/bannerWithDotsIndicator.dart';
// import 'package:sigmamenu/style/ScreenUtil.dart';
// import 'package:sigmamenu/style/Session.dart';

// class ItemCardRectangleAndSquare extends StatefulWidget {
//   final List<Product> productList;
//   final ScrollController? controller;

//   const ItemCardRectangleAndSquare({
//     Key? key,
//     required this.productList,
//     this.controller,
//   }) : super(key: key);

//   @override
//   _ItemCardRectangleAndSquareState createState() =>
//       _ItemCardRectangleAndSquareState();
// }

// class _ItemCardRectangleAndSquareState extends State<ItemCardRectangleAndSquare>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   bool isList = true;
//   @override
//   void initState() {
//     super.initState();
//     animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }

//   void toggle() => animationController.isDismissed
//       ? animationController.forward()
//       : animationController.reverse();

//   @override
//   Widget build(BuildContext context) {
//     List<Product> products = widget.productList;
//     return
//         // Expanded(
//         //   child: Column(
//         //     children: [
          
//         //       Row(
//         //         mainAxisAlignment: MainAxisAlignment.end,
//         //         children: [
//         //           // Align(
//         //           // alignment: Alignment.topRight,
//         //           // padding: const EdgeInsets.symmetric(horizontal: 6),
//         //           // /child:
//         //           IconButton(
//         //             icon: AnimatedIcon(
//         //               icon: AnimatedIcons.view_list,
//         //               progress: animationController,
//         //             ),
//         //             onPressed: () {
//         //               ///toggle controls the animation Forward and Backward
//         //               toggle();
//         //               setState(() {
//         //                 Session.isList = !Session.isList;
//         //               });
//         //             },
//         //             // )
//         //           ),
//         //           SizedBox(width: 20),
//         //         ],
//         //       ),
//         Session.isList
//             ? Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       BannerWithDotsIndicator(),
//                       Categories(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           // Align(
//                           // alignment: Alignment.topRight,
//                           // padding: const EdgeInsets.symmetric(horizontal: 6),
//                           // /child:
//                           IconButton(
//                             icon: AnimatedIcon(
//                               icon: AnimatedIcons.view_list,
//                               progress: animationController,
//                             ),
//                             onPressed: () {
//                               ///toggle controls the animation Forward and Backward
//                               toggle();
//                               setState(() {
//                                 Session.isList = !Session.isList;
//                               });
//                             },
//                             // )
//                           ),
//                           SizedBox(width: 20),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: kDefaultPaddin),
//                         child: GridView.builder(
//                           // physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,

//                           itemCount: products.length,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: Responsive.isDesktop(context)
//                                       ? 7
//                                       : Responsive.isTablet(context)
//                                           ? 4
//                                           : 2,
//                                   mainAxisSpacing: kDefaultPaddin,
//                                   crossAxisSpacing: kDefaultPaddin,
//                                   childAspectRatio:
//                                       Responsive.isDesktop(context)
//                                           ? 0.75
//                                           : Responsive.isMobile(context)
//                                               ? 0.75
//                                               : Responsive.isMiniMobile(context)
//                                                   ? 0.65
//                                                   : 0.80),
//                           itemBuilder: (context, index) => ItemCardSquares(
//                             product: products[index],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             : Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
                    
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           // Align(
//                           // alignment: Alignment.topRight,
//                           // padding: const EdgeInsets.symmetric(horizontal: 6),
//                           // /child:
//                           IconButton(
//                             icon: AnimatedIcon(
//                               icon: AnimatedIcons.view_list,
//                               progress: animationController,
//                             ),
//                             onPressed: () {
//                               ///toggle controls the animation Forward and Backward
//                               toggle();
//                               setState(() {
//                                 Session.isList = !Session.isList;
//                               });
//                             },
//                             // )
//                           ),
//                           SizedBox(width: 20),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: kDefaultPaddin),
//                         child: GridView.builder(
//                           // physics: NeverScrollableScrollPhysics(),
//                           // physics: ClampingScrollPhysics(),
//                           shrinkWrap: true,
//                           scrollDirection: Axis.vertical,
//                           itemCount: products.length,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 1,
//                                   childAspectRatio:
//                                       Responsive.isDesktop(context)
//                                           ? 8.2
//                                           : Responsive.isMobile(context)
//                                               ? 2.30
//                                               : Responsive.isMiniMobile(context)
//                                                   ? 2.0
//                                                   : 4.0),
//                           itemBuilder: (context, index) => ItemCardRectangle(
//                             product: products[index],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // ),
//                 // ],
//                 // ),
//               );
//   }
// }
