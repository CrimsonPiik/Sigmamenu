import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constaints.dart';
import 'package:shop_app/screens/home/components/itemCardData.dart';
import 'categorries.dart';

StreamController<int> streamController = StreamController<int>.broadcast();

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
                    "Coffee Shop",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
              
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: SvgPicture.asset(
                      "assets/icons/search.svg",
                      // By default our  icon color is white
                      color: kTextColor,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        Categories(),
        ItemCardData(streamController.stream),
      ],
    );
  }
}
