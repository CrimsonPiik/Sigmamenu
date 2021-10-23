import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/adminPanel.dart';
import 'package:shop_app/screens/home/components/categorries.dart';

class DeleteCategoryButton extends StatefulWidget {
  final Stream<int> stream;
  DeleteCategoryButton(this.stream);
  @override
  State<DeleteCategoryButton> createState() => _DeleteCategoryButtonState();
}

// Set<String> s = {};

class _DeleteCategoryButtonState extends State<DeleteCategoryButton> {
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
    // List categoryMenu = [
    //   'drinks',
    //   'maincourses',
    //   'appetizers',
    //   'desserts',
    //   'salads',
    //   'brunch'
    // ];
    setState(() {
      category = categoriesList.elementAt(index);
      // s = categoriesList;
      // category = categoryMenu[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.center,
          child: TextButton.icon(
              onPressed: () {
                _showDeleteCategoryDialog();
              },
              icon: Icon(Icons.remove),
              label: Text('Delete Category')),
        ),
        SizedBox(width: 21),
      ],
    );
  }

  _showDeleteCategoryDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete'),
            content: Text('Are you sure you want to delete this category ?'),
            actions: [
              TextButton(
                onPressed: () async {
                  categoriesList.remove(category);

                  await FirebaseFirestore.instance
                      .collection('Categories')
                      .doc(category)
                      .delete();
                  // Categories();
                  // setState(() {
                  // s = categoriesList;
                  // });
                  // buildCategory(
                  // categoriesList.elementAt(categoriesList.length));

                  // StreamBuilder<QuerySnapshot>(
                  //     stream: FirebaseFirestore.instance
                  //         .collection('Categories')
                  //         .snapshots(),
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<QuerySnapshot> snapshot) {
                  //       if (snapshot.hasError) {
                  //         return CommonUI.error(snapshot.error.toString());
                  //       }
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting)
                  //         return CommonUI.loading(context);
                  //       Set<String> s = {};
                  //       List<DocumentSnapshot> shots = snapshot.data!.docs;
                  //       for (var item in shots) {
                  //         s.add(item.id.toString());
                  //       }
                  //       setState(() {
                  //         categoriesList = s;
                  //       });
                  //       return Container();
                  //     });
                  Navigator.of(context).pop();
                  // });
                },
                child: Text(
                  'YES',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'NO',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        });
  }
}
