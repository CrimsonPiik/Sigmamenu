import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sigmamenu/GeneralFunction/constaints.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class ShimmerForPaginatedProducts extends StatelessWidget {
  const ShimmerForPaginatedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: GridView.builder(
          physics: ClampingScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context, index) {
            return ProjectLanguage.isLTR()
                ? Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 150.0,
                          height: 140,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 150.0,
                          height: 140,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                          ),
                        ),
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
    );
  }
}
