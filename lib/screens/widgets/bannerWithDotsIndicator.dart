import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/screens/home/components/shimmerForBanner.dart';
import 'package:sigmamenu/screens/widgets/AdsCard.dart';
import 'package:sigmamenu/models/banner.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class BannerWithDotsIndicator extends StatefulWidget {
  BannerWithDotsIndicator({
    Key? key,
  }) : super(key: key);

//   @override
//   _BannerWithDotsIndicatorState createState() =>
//       _BannerWithDotsIndicatorState();
// }

// class _BannerWithDotsIndicatorState extends State<BannerWithDotsIndicator> {
//   // int currentImage = 0;
//   // List<BannerModel> bannerListcheck = [];

//   // void getBanners() {
//   //   FirebaseFirestore.instance
//   //       .collection('Banner')
//   //       .where('isPublished', isEqualTo: true)
//   //       .snapshots()
//   //       .listen((event) {
//   //     for (var item in event.docs) {
//   //       bannerListcheck.add(BannerModel.fromMap(item.data()));
//   //     }
//   //     // print("Banner Bitch : " + bannerListcheck.toString());
//   //   });
//   // }
  @override
  State<BannerWithDotsIndicator> createState() =>
      _BannerWithDotsIndicatorState();
}

class _BannerWithDotsIndicatorState extends State<BannerWithDotsIndicator> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Banner")
            .where('isPublished', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return LoadingSpinner();
            return ShimmerForBanner();
          }
          List<DocumentSnapshot> shots = snapshot.data!.docs;

          // if (!snapshot.hasData || shots.isEmpty)
          //   return Text('Sorry, No Data');
          // else
          // if (snapshot.data == null || snapshot.hasData != true)
          // Text('Sorry, No Data');

          List<BannerModel> bannerList = [];

          for (var item in shots) {
            bannerList
                .add(BannerModel.fromMap(item.data() as Map<String, dynamic>));
          }
          return bannerList.isNotEmpty
              ? CarouselSlider(
                  items: bannerList
                      .map(
                        (item) => AdsCard(
                          item.image,
                          // click: () {
                          //   // application.navigatePush(
                          //   //     context,
                          //   //     AdsDetailScreen(
                          //   //       bannerModel: item,
                          //   //     ));
                          // },
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: Responsive.isMobile(context) ? 125 : 175,
                    aspectRatio: 16 / 9,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 3000),
                    autoPlayInterval: const Duration(milliseconds: 7000),
                    autoPlay: true,
                    // initialPage: currentImage,
                    // enlargeCenterPage: true,
                    //         onPageChanged: (index, reason) {
                    //           setState(() {
                    //             currentImage = index;
                    //           });
                    //         },
                  ),
                )
              : Container();
        });
    // : Container();
    // return Column(
    //   children: [
    //     CarouselSlider(
    //       items: bannerList
    //           .map(
    //             (item) => AdsCard(
    //               image: item.image,
    //               isBanner: true,
    //               // description: RhinoLanguage.isLTR()
    //               // ? item.nameEn
    //               // : item.nameAr,
    //               click: () {
    //                 // application.navigatePush(
    //                 // context,
    //                 // AdsDetailScreen(
    //                 // bannerModel: item,
    //                 // ));
    //               },
    //               // description: '',
    //             ),
    //           )
    //           .toList(),
    //       options: CarouselOptions(
    //         viewportFraction: 1,
    //         height: Responsive.isMobile(context) ? 100 : 175,
    //         aspectRatio: 16 / 9,
    //         autoPlayAnimationDuration: const Duration(seconds: 3),
    //         autoPlayInterval: const Duration(seconds: 7),
    //         autoPlay: true,
    //         initialPage: currentImage,
    //         enlargeCenterPage: true,
    //         onPageChanged: (index, reason) {
    //           setState(() {
    //             currentImage = index;
    //           });
    //         },
    //       ),
    //     ),
    //     // Row(
    //     //   mainAxisAlignment: MainAxisAlignment.center,
    //     //   children: bannerList.map(
    //     //     (image) {
    //     //       int indexx = bannerList.indexOf(image);
    //     //       return Container(
    //     //         width: 8.0,
    //     //         height: 8.0,
    //     //         margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
    //     //         decoration: BoxDecoration(
    //     //             shape: BoxShape.circle,
    //     //             color: currentImage == indexx
    //     //                 ? Color.fromRGBO(0, 0, 0, 0.9)
    //     //                 : Color.fromRGBO(0, 0, 0, 0.4)),
    //     //       );
    //     //     },
    //     //   ).toList(),
    //     // ),
    //   ],
    // );
  }
}
/////////////////////////////////////\\
///

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class BannerSlider extends StatefulWidget {
//   @override
//   _BannerSliderState createState() => _BannerSliderState();
// }

// class _BannerSliderState extends State<BannerSlider> {
//   int _index = 0;
//   int _dataLength = 1;

//   @override
//   void initState() {
//     getSliderImageFromDb();
//     super.initState();
//   }

//   Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
//       getSliderImageFromDb() async {
//     var _fireStore = FirebaseFirestore.instance;
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//         await _fireStore.collection('Banner').get();
//     if (mounted) {
//       setState(() {
//         _dataLength = snapshot.docs.length;
//       });
//     }
//     return snapshot.docs;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         children: [
//           if (_dataLength != 0)
//             FutureBuilder(
//               future: getSliderImageFromDb(),
//               builder: (_,
//                   AsyncSnapshot<
//                           List<QueryDocumentSnapshot<Map<String, dynamic>>>>
//                       snapShot) {
//                 return snapShot.data == null
//                     ? Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.only(top: 4),
//                         child: CarouselSlider.builder(
//                             itemCount: snapShot.data!.length,
//                             itemBuilder: (BuildContext context, index, int) {
//                               DocumentSnapshot<Map<String, dynamic>>
//                                   sliderImage = snapShot.data![index];

//                               dynamic getImage = sliderImage.data();
//                               return SizedBox(
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Image.network(
//                                     getImage['image'],
//                                     fit: BoxFit.fill,
//                                   ));
//                             },
//                             options: CarouselOptions(
//                                 viewportFraction: 1,
//                                 initialPage: 0,
//                                 autoPlay: true,
//                                 height: 150,
//                                 onPageChanged:
//                                     (int i, carouselPageChangedReason) {
//                                   setState(() {
//                                     _index = i;
//                                   });
//                                 })),
//                       );
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
