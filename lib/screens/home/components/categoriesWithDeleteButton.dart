import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/customerScreen.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

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
    return SizedBox(
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
                      ? Colors.orange[300]
                      : Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(1, -1.9),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                streamController.add(selectedIndex);
                _showDeleteCategoryDialog();
              },
              child: Container(
                width: 22.0,
                height: 22.0,
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 22,
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

// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====
// =====                                    DELETE                                        =====
// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====

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
                SingleChildScrollView(
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? size.width / 3
                        : size.width - 20,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 70, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Delete',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Responsive.isMiniMobile(context) ? 15 : 20),
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.fromLTRB(24, 1, 24, 16),
                            child: Text(
                              'Are you sure you want to delete ${category.toLowerCase()} category ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Responsive.isMiniMobile(context)
                                      ? 12
                                      : 17),
                            ),
                          ),
                          SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
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
                                SizedBox(width: 15),
                                ElevatedButton(
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
                                    Navigator.pop(context);
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: -60,
                    child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 50,
                      child: Icon(
                        Icons.delete_outlined,
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
