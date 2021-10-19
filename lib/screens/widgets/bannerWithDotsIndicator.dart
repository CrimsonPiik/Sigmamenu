import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/widgets/AdsCard.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/models/banner.dart';
import 'package:shop_app/style/ScreenUtil.dart';

class BannerWithDotsIndicator extends StatefulWidget {
  BannerWithDotsIndicator({
    Key? key,
  }) : super(key: key);

  @override
  _BannerWithDotsIndicatorState createState() =>
      _BannerWithDotsIndicatorState();
}

class _BannerWithDotsIndicatorState extends State<BannerWithDotsIndicator> {
  int currentImage = 0;
  // final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('banner')
            .where('isPublished', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);
          List<BannerModel> bannerList = [];

          for (var item in snapshot.data!.docs) {
            bannerList
                .add(BannerModel.fromMap(item.data() as Map<String, dynamic>));
          }
          return Column(
            children: [
              CarouselSlider(
                // carouselController: _carouselController,
                items: bannerList
                    .map(
                      (item) => AdsCard(
                        image: item.image,
                        isBanner: true,
                        // description: RhinoLanguage.isLTR()
                        // ? item.nameEn
                        // : item.nameAr,
                        click: () {
                          // application.navigatePush(
                          // context,
                          // AdsDetailScreen(
                          // bannerModel: item,
                          // ));
                        },
                        // description: '',
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: Responsive.isMobile(context) ? 100 : 180,
                  aspectRatio: 16 / 9,
                  autoPlayAnimationDuration: const Duration(milliseconds: 3000),
                  autoPlayInterval: const Duration(milliseconds: 4000),
                  autoPlay: true,
                  initialPage: currentImage,
                  enlargeCenterPage: true,
                  // onPageChanged: (index, reason) {
                  //   // print(index);
                  //   setState(() {
                  //     currentImage = index;
                  //   });
                  // },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: bannerList.map(
              //     (image) {
              //       int indexx = bannerList.indexOf(image);

              //       return Container(
              //         width: 8.0,
              //         height: 8.0,
              //         margin:
              //             EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: currentImage == indexx
              //                 ? Color.fromRGBO(0, 0, 0, 0.9)
              //                 : Color.fromRGBO(0, 0, 0, 0.4)),
              //       );
              //     },
              //   ).toList(),
              // ),
            ],
          );
        });
  }
}
