import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home/components/itemCardData.dart';
import 'categorries.dart';

StreamController<int> streamController = StreamController<int>();

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Center(
            child: Text(
              "Coffee Shop",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Categories(),
        ItemCardData(streamController.stream),
      ],
    );
  }
}
