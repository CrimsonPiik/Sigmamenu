import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shop_app/constaints.dart';
import 'package:shop_app/screens/home/components/itemCardData.dart';
import 'package:shop_app/screens/widgets/bannerWithDotsIndicator.dart';
import 'categorries.dart';

StreamController<int> streamController = StreamController<int>.broadcast();

// void getCategoriesFromFirebase() async {
//   var result = await FirebaseFirestore.instance.collection('categories').get();
//   result.docs.forEach((element) {
//     print(element.id);
//     categories.add(element.id);
//     categories.toSet().toList();
//   });
// }

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Sigma Menu",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                // Container(
                // color: Colors.black,
                // child: IconButton(
                // icon: SvgPicture.asset(
                // "assets/icons/search.svg",
                // By default our  icon color is white
                // color: Colors.black,
                // ),
                // onPressed: () {},
                // ),
                // ),
              ],
            ),
          ),
        ),
        BannerWithDotsIndicator(),
        Categories(),
        ItemCardData(streamController.stream),
      ],
    );
  }
}
