import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/home/components/body.dart';
import 'package:sigmamenu/constaints.dart';

class CategoriesDelete extends StatefulWidget {
  final Stream<int> stream;
  CategoriesDelete(this.stream);
  @override
  _CategoriesDeleteState createState() => _CategoriesDeleteState();
}

class _CategoriesDeleteState extends State<CategoriesDelete> {
  int selectedIndex = 0;
  String category = categoriesList.elementAt(0);

  TextEditingController newCollectionNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) {
      mySetState(index);
    });
  }

  void mySetState(int index) {
    if (!mounted) return;

    setState(() {
      category = categoriesList.elementAt(index);
    });
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          _showDeleteCategoryDialog();
        },
        child: ButtonTheme(
            // minWidth: 120.0,
            // height: 40.0,
            buttonColor: Colors.brown[400],
            child: Stack(children: [
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                child: Text(
                  categoriesList.elementAt(index),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == index ? Colors.black : Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  streamController.add(selectedIndex);
                  print(index.toString());
                  //click actions
                },
              ),
              Positioned(
                // will be positioned in the top right of the container
                top: 0,
                right: 0,
                child: Icon(
                  Icons.cancel,
                ),
              )
            ])),
      ),
    );
  }

  _showDeleteCategoryDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            content: Text('Are you sure you want to delete this category ?'),
            actions: [
              TextButton(
                onPressed: () async {
                  categoriesList.remove(category);

                  await FirebaseFirestore.instance
                      .collection('Categories')
                      .doc(category)
                      .delete();

                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'YES',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'NO',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
