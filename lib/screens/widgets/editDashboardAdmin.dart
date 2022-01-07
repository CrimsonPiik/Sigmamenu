import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sigmamenu/GeneralFunction/random_id_generator.dart';
import 'package:sigmamenu/models/staggerd.dart';
import 'package:sigmamenu/screens/widgets/DashboardTileAdmin.dart';
import 'package:sigmamenu/style/CommonUI.dart';

class EditStaggerdGridView extends StatefulWidget {
  @override
  State<EditStaggerdGridView> createState() => _EditStaggerdGridViewState();
}

List<Widget> tiles = [];

class _EditStaggerdGridViewState extends State<EditStaggerdGridView> {
  String id = generateId();
  // TextEditingController _nameDashboardController = TextEditingController();
  // TextEditingController _nameArDashboardController = TextEditingController();
  // TextEditingController _routeDashboardController = TextEditingController();
  // TextEditingController _superCategoryDashboardController =
  //     TextEditingController();

  // TextEditingController _imageDashboardController = TextEditingController();
  // ValueNotifier<String?> _imagevalue = ValueNotifier<String?>('');
  // final _formKey = GlobalKey<FormBuilderState>();
  bool showProgress = false;

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
          List<Staggerd> staggerdAdmin = [];
          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            staggerdAdmin
                .add(Staggerd.fromMap(item.data() as Map<String, dynamic>));
          }
          for (int index = 0; index < staggerdAdmin.length; index++) {
            tiles.add(DashBoardTileAdmin(
              name: staggerdAdmin[index].name,
              nameAr: staggerdAdmin[index].nameAr,
              id: staggerdAdmin[index].id,
              isPublished: staggerdAdmin[index].isPublished,
              // superCategory: staggerdAdmin[index].superCategory,
              // route: staggerdAdmin[index].route,
              image: staggerdAdmin[index].image,
              // routeName: staggerdAdmin[index].route,
              text: staggerdAdmin[index].name,
            ));
          }

          print("DASHBOARD ADMIN: " + staggerdAdmin.toString());
          return Expanded(
            child: Center(
              child: Container(
                  height: double.maxFinite,
                  width: 400,
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: staggerdAdmin.length,
                    itemBuilder: (BuildContext context, int index) =>
                        DashBoardTileAdmin(
                            name: staggerdAdmin[index].name,
                            nameAr: staggerdAdmin[index].nameAr,
                            // route: staggerdAdmin[index].route,
                            // superCategory: staggerdAdmin[index].superCategory,
                            id: staggerdAdmin[index].id,
                            isPublished: staggerdAdmin[index].isPublished,
                            image: staggerdAdmin[index].image,
                            // routeName: staggerdAdmin[index].route,
                            text: staggerdAdmin[index].name),
                    staggeredTileBuilder: (index) => staggerdAdmin.length == 10
                        ? index == staggerdAdmin.length - 1 // 10 DONE
                            ? StaggeredTile.count(2, 2.1)
                            : StaggeredTile.count(2, index.isEven ? 2.7 : 2.85)
                        : staggerdAdmin.length == 9
                            ? index == staggerdAdmin.length - 1 // 9 DONE
                                ? StaggeredTile.count(2, 3.2)
                                : StaggeredTile.count(
                                    2, index.isEven ? 2.5 : 3.3)
                            : staggerdAdmin.length == 8
                                ? index == staggerdAdmin.length - 1 // 8 DONE
                                    ? StaggeredTile.count(2, 2.25)
                                    : StaggeredTile.count(
                                        2, index.isEven ? 2.7 : 2.85)
                                : staggerdAdmin.length == 7
                                    ? index ==
                                            staggerdAdmin.length - 1 // 7 DONE
                                        ? StaggeredTile.count(2, 2.4)
                                        : StaggeredTile.count(
                                            2, index.isEven ? 2.5 : 3.3)
                                    : staggerdAdmin.length == 6
                                        ? index ==
                                                staggerdAdmin.length -
                                                    1 // 6 DONE
                                            ? StaggeredTile.count(2, 2.1)
                                            : StaggeredTile.count(
                                                2, index.isEven ? 2.9 : 3.3)
                                        : staggerdAdmin.length == 5
                                            ? index ==
                                                    staggerdAdmin.length -
                                                        1 // 5 DONE
                                                ? StaggeredTile.count(2, 3.15)
                                                : StaggeredTile.count(2,
                                                    index.isEven ? 2.5 : 4.08)
                                            : staggerdAdmin.length ==
                                                    4 // 4 DONE
                                                ? StaggeredTile.count(2,
                                                    index.isOdd ? 3.95 : 4.18)
                                                : staggerdAdmin.length == 3
                                                    ? index ==
                                                            staggerdAdmin
                                                                    .length -
                                                                1 // 3 DONE
                                                        ? StaggeredTile.count(
                                                            2, 4.4)
                                                        : StaggeredTile.count(
                                                            2,
                                                            index.isEven
                                                                ? 3.75
                                                                : 8.13)
                                                    : staggerdAdmin.length ==
                                                            2 // 2 DONE
                                                        ? StaggeredTile.count(
                                                            2, 8.14)
                                                        : StaggeredTile // 1 DONE
                                                            .count(4, 8.14),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  )),
            ),
          );
        });
  }
}
