import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/home/components/customerScreen.dart';

class CategoriesWithDeleteButton extends StatefulWidget {
  final Stream<int> stream;
  CategoriesWithDeleteButton(this.stream);
  @override
  _CategoriesWithDeleteButtonState createState() =>
      _CategoriesWithDeleteButtonState();
}

class _CategoriesWithDeleteButtonState
    extends State<CategoriesWithDeleteButton> {
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
    return
        //  Padding(
        // padding: const EdgeInsets.only(left: 9.0, right: 12.0),
        // child:
        SizedBox(
      height: 60,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoriesList.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
      // ),
      // ),
    );
  }

  Widget buildCategory(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Stack(
        children: [
          Ink(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                streamController.add(selectedIndex);
                print(index.toString());
              },
              child: Container(
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
            ),
          ),
          Align(
            alignment: Alignment(1, -1.6),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                streamController.add(selectedIndex);
                _showDeleteCategoryDialog();
              },
              child: Container(
                width: 20.0,
                height: 20.0,
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 20,
                ),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black, offset: Offset(0, 1), blurRadius: 2),
                ], shape: BoxShape.circle, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showDeleteCategoryDialog() {
    Size size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 230,
                  width: size.width - 20,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 70, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Delete',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        // SizedBox(
                        //   height: 2,
                        // ),
                        Container(
                          padding: EdgeInsets.all(23),
                          child: Text(
                            'Are you sure you want to delete $category category ?',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonTheme(
                                minWidth: 80,
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              ButtonTheme(
                                minWidth: 80,
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    categoriesList.remove(category);

                                    await FirebaseFirestore.instance
                                        .collection('Categories')
                                        .doc(category)
                                        .delete();

                                    ///So it get back to index 0 after deleting the collection
                                    setState(() {
                                      selectedIndex = 0;
                                    });
                                    streamController.add(selectedIndex);
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.redAccent),
                                  ),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: -60,
                    child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 50,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 50,
                      ),
                    )),
              ],
            ));
      },
    );
  }
}
