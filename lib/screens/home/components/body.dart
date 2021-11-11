import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/animation/page_slide_widget.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/language/widgets/changeLanguageButton.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/home/components/categories.dart';
import 'package:sigmamenu/screens/home/components/itemCardData.dart';
import 'package:sigmamenu/screens/widgets/SigningPopUp.dart';
import 'package:sigmamenu/screens/widgets/bannerWithDotsIndicator.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/Session.dart';

StreamController<int> streamController = StreamController<int>.broadcast();

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isList = true;
  @override
  void initState() {
    // Provider.of<MKHM>(context, listen: false).getSubCategories();
    // isSearchON = false;

    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              child: IconButton(
                                icon: AnimatedIcon(
                                  icon: AnimatedIcons.view_list,
                                  progress: animationController,
                                ),
                                onPressed: () {
                                  ///toggle controls the animation Forward and Backward
                                  toggle();
                                  setState(() {
                                    Session.isList = !Session.isList;
                                  });
                                },
                              )),
                          Container(
                            // color: Colors.black,
                            child: ChangeLanguageButton(),
                          ),
                          SizedBox(width: 5),
                          IconButton(
                            icon: Icon(Icons.login),
                            color: Colors.black,
                            // ),
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
              BannerWithDotsIndicator(),
              Categories(),
              
              ItemCardData(streamController.stream),
            ],
          );
        });
  }
}
