import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/GeneralFunction/storageManager.dart';
import 'package:sigmamenu/animation/page_slide_widget.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/language/widgets/changeLanguageButton.dart';
import 'package:sigmamenu/models/banner.dart';
import 'package:sigmamenu/provider/darkLightMode.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/home/components/categories.dart';
import 'package:sigmamenu/screens/home/components/itemCardData.dart';
import 'package:sigmamenu/screens/widgets/SigningPopUp.dart';
import 'package:sigmamenu/screens/widgets/bannerWithDotsIndicator.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/Session.dart';

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
    // mystate();
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
          // DateTime.now().millisecondsSinceEpoch.toString());
          return
              //  Container(
              //  child: SingleChildScrollView(
              // scrollDirection: Axis.vertical,
              // child:
              Column(
            // shrinkWrap: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: Container(
                  height: 75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Sigma Menu",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          // IconButton(
                          //   icon: AnimatedIcon(
                          //     icon: AnimatedIcons.view_list,
                          //     progress: animationController,
                          //   ),
                          //   onPressed: () {
                          //     ///toggle controls the animation Forward and Backward
                          //     toggle();
                          //     setState(() {
                          //       Session.isList = !Session.isList;
                          //     });
                          //   },
                          //   // )
                          // ),
                          isLight
                              ? IconButton(
                                  icon: Icon(Icons.dark_mode),
                                  onPressed: () {
                                    setState(() {
                                      isLight = false;
                                    });
                                    widget.theme.setDarkMode();
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.light_mode),
                                  onPressed: () {
                                    setState(() {
                                      isLight = true;
                                    });
                                    widget.theme.setLightMode();
                                  },
                                ),
                          SizedBox(width: 5),
                          Container(
                            child: ChangeLanguageButton(),
                          ),
                          SizedBox(width: 5),
                          IconButton(
                            icon: Icon(Icons.login),
                            // color: Colors.black,
                            onPressed: () {
                              Navigator.of(context)
                                  .push(createRoute(SigningPopUp()));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // bannerList != 
              BannerWithDotsIndicator(),
              // : Container(height: 1,),
              // Row(
              // children: [
              // SizedBox(width: 12),
              Categories(),
              // ],
              // ),
              ItemCardData(streamController.stream),
            ],
            // ),
            //       //  ),
          );
        });
  }
}
