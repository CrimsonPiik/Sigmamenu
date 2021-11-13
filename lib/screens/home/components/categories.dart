import 'package:flutter/material.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/home/components/customerScreen.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.hasError) {
    //         return CommonUI.error(snapshot.error.toString());
    //       }
    //       if (snapshot.connectionState == ConnectionState.waiting)
    //         return CommonUI.loading(context);

    //       List<DocumentSnapshot> shots = snapshot.data!.docs;
    //       for (var item in shots) {
    //         categoriesList.add(item.id.toString());
    //       }

    //       print("Categories : " + categoriesList.toString());

    return 
    // Padding(
      // padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      // child: 
      SizedBox(
        height: 56,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoriesList.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      // ),
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
        child: Row(
          children: [
            SizedBox(width: 20),
            // Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // children: <Widget>[
            Container(
              // margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Text(
                categoriesList.elementAt(index),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index ? Colors.white : Colors.black,
                ),
              ),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? Colors.brown[400]
                    : Colors.grey.withOpacity(0.3),
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
            // ],
            // ),
          ],
        ),
      ),
    );
  }
}
