import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sigmamenu/animation/page_slide_widget.dart';
import 'package:sigmamenu/language/widgets/changeLanguageButton.dart';
import 'package:sigmamenu/models/staggerd.dart';
import 'package:sigmamenu/screens/backGroundTile.dart';
import 'package:sigmamenu/screens/widgets/LoginForm.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class StaggerdGridView extends StatefulWidget {
  @override
  State<StaggerdGridView> createState() => _StaggerdGridViewState();
}

class _StaggerdGridViewState extends State<StaggerdGridView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('dashboard').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);
          List<Staggerd> staggerd = [];
          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            staggerd.add(Staggerd.fromMap(item.data() as Map<String, dynamic>));
          }

          print("DASHBOARD : " + staggerd.toString());

          return Scaffold(
            body: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      height: 75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.login),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(createRoute(LoginForm()));
                                },
                              ),
                            ],
                          ),
                          Container(
                            height: Responsive.isDesktop(context) ? 60 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Image.asset(
                              'assets/images/sigmabanner.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     isLight
                          //         ? IconButton(
                          //             icon:
                          //                 Icon(Icons.dark_mode, color: Colors.white),
                          //             onPressed: () {
                          //               // setState(() {
                          //               //   isLight = false;
                          //               // });
                          //               // widget.theme.setDarkMode();
                          //             },
                          //           )
                          //         : IconButton(
                          //             icon:
                          //                 Icon(Icons.light_mode, color: Colors.white),
                          //             onPressed: () {
                          //               // setState(() {
                          //               //   isLight = true;
                          //               // });
                          //               // widget.theme.setLightMode();
                          //             },
                          //           ),
                          //     SizedBox(width: 5),
                          Container(
                            child: ChangeLanguageButton(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: staggerd.length,
                      itemBuilder: (BuildContext context, int index) =>
                          BackGroundTile(
                              background: staggerd[index].image,
                              routeName: staggerd[index].route,
                              text: staggerd[index].name),
                      staggeredTileBuilder: (index) => staggerd.length == 10
                          ? index == staggerd.length - 1 // 10 DONE
                              ? StaggeredTile.count(2, 2.1)
                              : StaggeredTile.count(
                                  2, index.isEven ? 2.7 : 2.85)
                          : staggerd.length == 9
                              ? index == staggerd.length - 1 // 9 DONE
                                  ? StaggeredTile.count(2, 3.2)
                                  : StaggeredTile.count(
                                      2, index.isEven ? 2.5 : 3.3)
                              : staggerd.length == 8
                                  ? index == staggerd.length - 1 // 8 DONE
                                      ? StaggeredTile.count(2, 2.25)
                                      : StaggeredTile.count(
                                          2, index.isEven ? 2.7 : 2.85)
                                  : staggerd.length == 7
                                      ? index == staggerd.length - 1 // 7 DONE
                                          ? StaggeredTile.count(2, 2.4)
                                          : StaggeredTile.count(
                                              2, index.isEven ? 2.5 : 3.3)
                                      : staggerd.length == 6
                                          ? index ==
                                                  staggerd.length - 1 // 6 DONE
                                              ? StaggeredTile.count(2, 2.1)
                                              : StaggeredTile.count(
                                                  2, index.isEven ? 2.9 : 3.3)
                                          : staggerd.length == 5
                                              ? index ==
                                                      staggerd.length -
                                                          1 // 5 DONE
                                                  ? StaggeredTile.count(2, 3.15)
                                                  : StaggeredTile.count(2,
                                                      index.isEven ? 2.5 : 4.08)
                                              : staggerd.length == 4 // 4 DONE
                                                  ? StaggeredTile.count(2,
                                                      index.isOdd ? 3.95 : 4.18)
                                                  : staggerd.length == 3
                                                      ? index ==
                                                              staggerd.length -
                                                                  1 // 3 DONE
                                                          ? StaggeredTile.count(
                                                              2, 4.4)
                                                          : StaggeredTile.count(
                                                              2,
                                                              index.isEven
                                                                  ? 3.75
                                                                  : 8.13)
                                                      : staggerd.length ==
                                                              2 // 2 DONE
                                                          ? StaggeredTile.count(
                                                              2, 8.14)
                                                          : StaggeredTile // 1 DONE
                                                              .count(4, 8.14),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    )
                        //     :
                        //     StaggeredGridView.count(
                        //   crossAxisCount: 4,
                        //   staggeredTiles: listStaggeredTile,
                        //   children: tiles,
                        //   mainAxisSpacing: 4.0,
                        //   crossAxisSpacing: 4.0,
                        // ),
                        ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
