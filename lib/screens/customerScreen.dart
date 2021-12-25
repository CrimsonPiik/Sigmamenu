import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/GeneralFunction/storageManager.dart';
import 'package:sigmamenu/provider/darkLightMode.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/home/components/categories.dart';
import 'package:sigmamenu/screens/home/components/itemCardData.dart';
import 'package:sigmamenu/screens/widgets/bannerWithDotsIndicator.dart';
import 'package:sigmamenu/style/CommonUI.dart';

StreamController<int> streamController = StreamController<int>.broadcast();
bool isLight = true;

class CustomerScreen extends StatefulWidget {
  final ThemeNotifier theme;
  CustomerScreen({required this.theme});
  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isList = true;
  @override
  void initState() {
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
        stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);

          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            categoriesList.add(item.id.toString());
          }
          print("Categories : " + categoriesList.toString());

          return
              //  SingleChildScrollView(
              // child: SizedBox(
              // height: MediaQuery.of(context).size.height,
              // child:
              // Expanded(
              // child: SingleChildScrollView(
              // child:
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15),
              BannerWithDotsIndicator(),
              Categories(),
              // BannerWithDotsIndicator(),
              // BannerWithDotsIndicator(),
              // BannerWithDotsIndicator(),
              // BannerWithDotsIndicator(),
              // BannerWithDotsIndicator(),
              // BannerWithDotsIndicator(),
              // BannerWithDotsIndicator(),
              // BannerWithDotsIndicator(),
              // BannerWithDotsIndicator(),

              ItemCardData(streamController.stream),
            ],
            // ),
            // ),
            // ),
            // ),
          );
        });
  }
}
