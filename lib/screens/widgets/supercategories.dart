import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/screens/customerScreen.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

int selectedIndexsuper = 0;
int selectedIndex = 0;

class SuperCategories extends StatefulWidget {
  final Stream<int> stream;
  final Stream<int> superstream;

  SuperCategories(this.stream, this.superstream);
  @override
  _SuperCategoriesState createState() => _SuperCategoriesState();
}

class _SuperCategoriesState extends State<SuperCategories> {
  String supercategory = superCat.elementAt(0);
  String category = categoriesList.elementAt(0);

  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) {
      mySetState(index);
    });
    widget.superstream.listen((index) {
      mySuperSetState(index);
    });
  }

  void mySetState(int index) {
    if (!mounted) return;

    setState(() {
      category = categoriesList.elementAt(index);
    });
  }

  void mySuperSetState(int index) {
    if (!mounted) return;

    setState(() {
      supercategory = superCat.elementAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance
    //         .collection('SuperCategories')
    //         .doc(supercategory)
    //         .collection(supercategory)
    //         .snapshots(),
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

    //       for (var item in shots) {
    //         categoriesARnames.add(
    //             CategoryModel.fromMap(item.data() as Map<String, dynamic>));
    //       }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 56,
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
                itemCount: superCat.length,
                itemBuilder: (context, index) => buildSuperCategory(index),
              )),
        ),
        SizedBox(
          height: 60,
          child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child:
                  //  categoriesList.isNotEmpty
                  // ?
                  ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, indexx) => buildSubCategory(indexx),
              )
              // : Container(),
              ),
        )
      ],
    );
    // });
  }

  Widget buildSuperCategory(int index) {
    return GestureDetector(
      onTap: () {
        categoriesList.clear();
        setState(() {
          selectedIndex = 0;
        });
        setState(() {
          selectedIndexsuper = index;
        });
        superstreamController.add(selectedIndexsuper);
        print('Super-Category ' + index.toString());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Row(
          children: [
            SizedBox(width: 7),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                ProjectLanguage.isLTR()
                    ? superCat.elementAt(index)
                    : superCatAR.elementAt(index).nameAr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:
                      selectedIndexsuper == index ? Colors.white : Colors.black,
                ),
              ),
              decoration: BoxDecoration(
                color: selectedIndexsuper == index
                    ? Colors.orange[300]
                    : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubCategory(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Stack(
        children: [
          Ink(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                streamController.add(selectedIndex);
                print('Sub-Category ' + index.toString());
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  ProjectLanguage.isLTR()
                      ? categoriesList.elementAt(index)
                      : categoriesARnames.elementAt(index).nameAr,
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
            child: GestureDetector(
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
// =====                                    DELETE CATEGORY                               =====
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
                                    // setState(() {
                                    //   selectedIndex = 0;
                                    // });
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

                                    print('supercategory **********' +
                                        supercategory);
                                    await FirebaseFirestore.instance
                                        .collection('SuperCategories')
                                        .doc('Drinks')
                                        .collection('Drinks')
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
