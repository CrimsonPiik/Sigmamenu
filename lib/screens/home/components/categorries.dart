import 'package:flutter/material.dart';
import 'package:shop_app/screens/adminPanel.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/constaints.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

// List<String> categories = [];

// void getCategories() async {
//   final QuerySnapshot result =
//       await FirebaseFirestore.instance.collection('categories').get();
//   final List<DocumentSnapshot> documents = result.docs;
//   // categories.toSet().toList();

//   // for (int i = 0; i < documents.length; i++) {
//   categories.add(documents[documents.length - 1].id);
//   // }
// }

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 56,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoriesList.length,
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
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        // padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin), //20.0
        child: Row(
          children: [
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    categoriesList.elementAt(index),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          selectedIndex == index ? Colors.black : Colors.white,
                    ),
                    // borderRadius: BorderRadius.circular(5.0),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    // borderRadius: BorderRadius.circular(5.0)
                    // border: Border.all(
                    //   color: Colors.red,
                    //   width: 5.0,
                    // ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
                //   height: 2,
                //   width: 40,

                //   // width: categories[selectedIndex].length * 6.6,
                //   color: selectedIndex == index ? Colors.black : Colors.transparent,
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
