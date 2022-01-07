import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/GeneralFunction/storageManager.dart';
import 'package:sigmamenu/models/category.dart';
import 'package:sigmamenu/provider/darkLightMode.dart';
import 'package:sigmamenu/screens/widgets/categories.dart';
import 'package:sigmamenu/screens/widgets/itemCardData.dart';
import 'package:sigmamenu/screens/widgets/bannerWithDotsIndicator.dart';
import 'package:sigmamenu/style/CommonUI.dart';

StreamController<int> streamController = StreamController<int>.broadcast();
StreamController<int> superstreamController = StreamController<int>.broadcast();

bool isLight = true;
Set<String> categoriesList = {};

Set<CategoryModel> categoriesARnames = {};
Set<String> superCat = {};
Set<CategoryModel> superCatAR = {};

class CustomerScreen extends StatefulWidget {
  final String name;
  final ThemeNotifier theme;
  CustomerScreen({required this.theme, required this.name});
  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isList = true;
  @override
  void initState() {
    print(widget.name.toString());
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  mystate() {
    StorageManager.readData('themeMode').then((value) {
      if (value.toString() == 'light') {
        setState(() {
          isLight = true;
        });
      } else {
        setState(() {
          isLight = false;
        });
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('SuperCategories')
            .doc(widget.name)
            .collection(widget.name)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);

          List<DocumentSnapshot> shots = snapshot.data!.docs;
          // List<CategoryModel> productsARnamesList = [];
          categoriesList.clear();

          for (var item in shots) {
            categoriesList.add(item.id.toString());
            // context.read<CategoriesProvider>().addItem(item.id.toString());
          }
          print("Super Categories : " + categoriesList.toString());

          for (var item in shots) {
            categoriesARnames.add(
                CategoryModel.fromMap(item.data() as Map<String, dynamic>));
          }

          return ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15),
              BannerWithDotsIndicator(),
              Categories(),
              ItemCardData(streamController.stream),
            ],
          );
          // });
        });
  }
}
