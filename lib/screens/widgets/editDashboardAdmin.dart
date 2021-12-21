import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reorderableitemsview/reorderableitemsview.dart';
import 'package:sigmamenu/Authentication/AuthService.dart';
import 'package:sigmamenu/models/staggerd.dart';
import 'package:sigmamenu/style/CommonUI.dart';

class EditStaggerdGridView extends StatefulWidget {
  @override
  State<EditStaggerdGridView> createState() => _EditStaggerdGridViewState();
}

List<Widget> tiles = [];

class _EditStaggerdGridViewState extends State<EditStaggerdGridView> {
  @override
  Widget build(BuildContext context) {
    // final tiles = Provider.of<Tiles>(context, listen: true);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('dashboard')
            // .orderBy('indexKey')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);
          List<StaggeredTileExtended> listStaggeredTile = [];
          List<Staggerd> staggerdAdmin = [];
          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            staggerdAdmin
                .add(Staggerd.fromMap(item.data() as Map<String, dynamic>));
          }
          for (int index = 0; index < staggerdAdmin.length; index++) {
            tiles.add(BackGroundTileAdmin(
              key: Key(staggerdAdmin[index].indexKey.toString()),
              background: staggerdAdmin[index].image,
              routeName: staggerdAdmin[index].route,
              text: staggerdAdmin[index].name,
            ));
            staggerdAdmin.length == 10
                ? index == staggerdAdmin.length - 1 // 10 DONE
                    ? listStaggeredTile.add(StaggeredTileExtended.count(2, 2.1))
                    : listStaggeredTile.add(StaggeredTileExtended.count(
                        2, index.isEven ? 2.7 : 2.85))
                : staggerdAdmin.length == 9
                    ? index == staggerdAdmin.length - 1 // 9 DONE
                        ? listStaggeredTile
                            .add(StaggeredTileExtended.count(2, 3.2))
                        : listStaggeredTile.add(StaggeredTileExtended.count(
                            2, index.isEven ? 2.5 : 3.3))
                    : staggerdAdmin.length == 8
                        ? index == staggerdAdmin.length - 1 // 8 DONE
                            ? listStaggeredTile
                                .add(StaggeredTileExtended.count(2, 2.25))
                            : listStaggeredTile.add(StaggeredTileExtended.count(
                                2, index.isEven ? 2.7 : 2.85))
                        : staggerdAdmin.length == 7
                            ? index == staggerdAdmin.length - 1 // 7 DONE
                                ? listStaggeredTile
                                    .add(StaggeredTileExtended.count(2, 2.4))
                                : listStaggeredTile.add(
                                    StaggeredTileExtended.count(
                                        2, index.isEven ? 2.5 : 3.3))
                            : staggerdAdmin.length == 6
                                ? index == staggerdAdmin.length - 1 // 6 DONE
                                    ? listStaggeredTile.add(
                                        StaggeredTileExtended.count(2, 2.1))
                                    : listStaggeredTile.add(
                                        StaggeredTileExtended.count(
                                            2, index.isEven ? 2.9 : 3.3))
                                : staggerdAdmin.length == 5
                                    ? index ==
                                            staggerdAdmin.length - 1 // 5 DONE
                                        ? listStaggeredTile.add(
                                            StaggeredTileExtended.count(2, 2))
                                        : listStaggeredTile.add(
                                            StaggeredTileExtended.count(
                                                2, index.isEven ? 2.5 : 3.5))
                                    : staggerdAdmin.length == 4 // 4 DONE
                                        ? listStaggeredTile.add(StaggeredTileExtended.count(2, index.isEven ? 3.32 : 2.92))
                                        : staggerdAdmin.length == 3
                                            ? index == staggerdAdmin.length - 1 // 3 DONE
                                                ? listStaggeredTile.add(StaggeredTileExtended.count(2, 3.5))
                                                : listStaggeredTile.add(StaggeredTileExtended.count(2, index.isEven ? 2.75 : 6.26))
                                            : staggerdAdmin.length == 2 // 2 DONE
                                                ? listStaggeredTile.add(StaggeredTileExtended.count(2, 6.26))
                                                : listStaggeredTile.add(StaggeredTileExtended // 1 DONE
                                                    .count(4, 6.26));
            // designTiles(i, staggerdAdmin);
          }

          print("DASHBOARD ADMIN: " + staggerdAdmin.toString());
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: 450,
                width: 300,
                child: ReorderableItemsView(
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      tiles.insert(newIndex, tiles.removeAt(oldIndex));
                    });

                    // if (oldIndex < newIndex) newIndex -= 1;
                    // snapshot.data!.docs.insert(
                    //     newIndex, snapshot.data!.docs.removeAt(oldIndex));
                    // final batch = FirebaseFirestore.instance.batch();
                    // for (int pos = 0; pos < snapshot.data!.docs.length; pos++) {
                    //   // snapshot.data!.docs[pos].reference
                    //   //     .update({"indexKey": pos});
                    //   batch.update(snapshot.data!.docs[pos].reference,
                    //   {'indexKey': pos});
                    // }

                    // batch.commit();
                  },
                  crossAxisCount: 4,
                  isGrid: true,
                  staggeredTiles: listStaggeredTile,
                  longPressToDrag: false,
                  children: tiles,
                ),
              ),
            ),
          );
        });
  }
}

class BackGroundTileAdmin extends StatelessWidget {
  final String background;
  final String text;
  final String routeName;
  final Key key;

  BackGroundTileAdmin(
      {required this.key,
      required this.background,
      required this.text,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: <Widget>[
        Center(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/' + routeName);
            },
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(background), fit: BoxFit.cover),
                )),
                Container(
                  decoration: BoxDecoration(color: Color(0x4D303030)),
                  child: Center(
                      child: Text(
                    text, // .toCapitalized(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ),
              ],
            ),
          ),
        ),
      ],
    )));
  }
}

// void designTiles(int index, List<Staggerd> staggerdAdmin) {}

// class Tiles with ChangeNotifier {
//   List<Widget> tiles = [];

//   // An unmodifiable view of the items in the cart.
//   UnmodifiableListView<Widget> get itemList => UnmodifiableListView(tiles);

//   void addToTiles(Widget item) {
//     tiles.add(item);
//     notifyListeners();
//   }

//   // double get totalAmount => tiles.fold(0, (total, current) => total + current.amount);
// }
