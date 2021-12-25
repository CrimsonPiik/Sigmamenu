import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class DashBoardTileAdmin extends StatefulWidget {
  final String background;
  final String text;
  final String routeName;
  final String id;
  final String name;

  DashBoardTileAdmin(
      {required this.id,
      required this.name,
      required this.background,
      required this.text,
      required this.routeName});

  @override
  State<DashBoardTileAdmin> createState() => _DashBoardTileAdminState();
}

class _DashBoardTileAdminState extends State<DashBoardTileAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: <Widget>[
        Center(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/' + widget.routeName);
            },
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.background),
                      fit: BoxFit.cover),
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(color: Color(0x4D303030)),
                      child: Center(
                          child: Text(
                        widget.text, // .toCapitalized(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 14),
                          GestureDetector(
                            onTap: () {
                              _showDeleteCategoryDialog();
                            },
                            child: Icon(
                              Icons.delete_outlined,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 14),
                          Icon(
                            Icons.toggle_on_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    )));
  }

// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====
// =====                                    DELETE                                        =====
// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====

  _showDeleteCategoryDialog() {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? size.width / 3
                        : size.width - 20,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 70, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Delete',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Responsive.isMiniMobile(context) ? 15 : 20),
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.fromLTRB(24, 1, 24, 16),
                            child: Text(
                              'Are you sure you want to delete ${widget.name.toLowerCase()} from dashboard ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Responsive.isMiniMobile(context)
                                      ? 12
                                      : 17),
                            ),
                          ),
                          SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('dashboard')
                                        .doc(widget.id)
                                        .delete();

                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.redAccent),
                                  ),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: -60,
                    child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 50,
                      child: Icon(
                        Icons.delete_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    )),
              ],
            ));
      },
    );
  }
}
