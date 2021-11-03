import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/animation/page_slide_widget.dart';
import 'package:shop_app/constaints.dart';
import 'package:shop_app/language/widgets/changeLanguageButton.dart';
import 'package:shop_app/screens/adminPanel.dart';
import 'package:shop_app/screens/home/components/itemCardData.dart';
import 'package:shop_app/screens/widgets/SigningPopUp.dart';
import 'package:shop_app/screens/widgets/bannerWithDotsIndicator.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'categorries.dart';

StreamController<int> streamController = StreamController<int>.broadcast();

class Body extends StatelessWidget {
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
                      Container(
                        // color: Colors.black,
                        child: ChangeLanguageButton(),
                      ),
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
