import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Session.dart';

class ShimmerForCustomerScreen extends StatelessWidget {
  const ShimmerForCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Session.isList
        ? Expanded(
            // Squaree
            child: Shimmer.fromColors(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPaddin, vertical: kDefaultPaddin * 2),
                child: GridView.builder(
                  itemCount: Responsive.isDesktop(context) ? 7 : 4,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
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
                      childAspectRatio: Responsive.isDesktop(context)
                          ? 0.75
                          : Responsive.isMobile(context)
                              ? 0.75
                              : Responsive.isMiniMobile(context)
                                  ? 0.65
                                  : 0.80),
                ),
              ),
              baseColor: Colors.grey.withOpacity(0.4),
              highlightColor: Colors.grey.withOpacity(0.2),
            ),
          )
        : Expanded(
            //Rectangle
            child: Shimmer.fromColors(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPaddin, vertical: kDefaultPaddin * 2),
                child: GridView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 9,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 150.0,
                            height: double.maxFinite,
                            // color: Colors.white,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          // Expanded(
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       SizedBox(height: 10),
                          //       Container(
                          //         width: 90,
                          //         height: 8.0,
                          //         color: Colors.white,
                          //       ),
                          //       SizedBox(
                          //         height: 6,
                          //       ),
                          //       Container(
                          //         width: 30,
                          //         height: 8.0,
                          //         color: Colors.white,
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: Responsive.isDesktop(context)
                          ? 8.2
                          : Responsive.isMobile(context)
                              ? 2.30
                              : Responsive.isMiniMobile(context)
                                  ? 2.0
                                  : 4.0),
                ),
              ),
              baseColor: Colors.grey.withOpacity(0.4),
              highlightColor: Colors.grey.withOpacity(0.2),
            ),
          );
  }
}
