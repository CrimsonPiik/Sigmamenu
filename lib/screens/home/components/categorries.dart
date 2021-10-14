import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/constaints.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

// List<String> categories = [];

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "Drinks",
    "Food",
    "Appetizers",
    "Desserts",
    "Salads",
    "Brunch"
  ];
  // By default our first item will be selected
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
    // });
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        streamController.add(selectedIndex);
        print(index.toString());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 40,
              // width: categories[selectedIndex].length * 6.6,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
