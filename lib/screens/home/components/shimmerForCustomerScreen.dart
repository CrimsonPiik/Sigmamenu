import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/style/AssetsManager.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Session.dart';

class ShimmerForCustomerScreen extends StatelessWidget {
  const ShimmerForCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Session.isList
        ? Expanded(
            child: Shimmer.fromColors(
              child: GridView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              child: Container(
                                height: Responsive.isDesktop(context)
                                    ? 160
                                    : Responsive.isTablet(context)
                                        ? 155
                                        : Responsive.isMobile(context)
                                            ? 150
                                            : 100,
                                width: double.maxFinite,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(14),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: Responsive.isDesktop(context)
                                            ? 10
                                            : 6),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        child: SizedBox(
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: Responsive.isDesktop(context)
                                            ? 9
                                            : 5),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        child: SizedBox(
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
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
              ),
              baseColor: Colors.grey.withOpacity(0.7),
              highlightColor: Colors.grey.withOpacity(0.3),
            ),
          )
        : Expanded(
            child: Shimmer.fromColors(
              child: GridView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 48.0,
                          height: 48.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: 40.0,
                                height: 8.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );

                  // Container(
                  //   padding: EdgeInsets.all(16),
                  //   margin: EdgeInsets.only(bottom: 20),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.withOpacity(0.1),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         width: 120,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(4),
                  //         ),
                  //         // child: ImageAssets(ImageAssets.placeholder),
                  //         //  Icon(Icons.image),
                  //         //     widget.product.image, ImageAssets.placeholder,
                  //         //     fit: BoxFit.cover)
                  //       ),
                  //       SizedBox(
                  //         width: 16,
                  //       ),
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               'widget.product.nameEn,',
                  //               overflow: TextOverflow.ellipsis,
                  //               maxLines: 1,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.bold, fontSize: 16),
                  //             ),
                  //             SizedBox(
                  //               height: 4,
                  //             ),
                  //             Text(
                  //               'widget.product.descriptionEn',
                  //               overflow: TextOverflow.ellipsis,
                  //               maxLines: 2,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w400, fontSize: 14),
                  //             ),
                  //             SizedBox(
                  //               height: 4,
                  //             ),
                  //             Text(
                  //               ' widget.product.price.toString()',
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w300, fontSize: 12),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: Responsive.isDesktop(context)
                        ? MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 3.5)
                        : MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 4.5)),
              ),
              baseColor: Colors.grey.withOpacity(0.7),
              highlightColor: Colors.grey.withOpacity(0.3),
            ),
          );
  }
}
