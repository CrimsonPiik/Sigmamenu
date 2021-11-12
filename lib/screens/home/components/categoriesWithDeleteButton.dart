import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/home/components/body.dart';
import 'package:sigmamenu/constaints.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPaddin),
      child: SizedBox(
        height: 56,
        child: ListView.builder(
          shrinkWrap: true,
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
          )),
          //   ],
          // ),
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
      ), // ElevatedButton(
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
            content:
                Text('Are you sure you want to delete ${category} category ?'),
            actions: [
              TextButton(
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
