import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sigmamenu/GeneralFunction/Strings.dart';
import 'package:sigmamenu/GeneralFunction/firebase_uploader_web.dart';
import 'package:sigmamenu/GeneralFunction/random_id_generator.dart';
import 'package:sigmamenu/models/staggerd.dart';
import 'package:sigmamenu/screens/widgets/DashboardTile.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class EditStaggerdGridView extends StatefulWidget {
  @override
  State<EditStaggerdGridView> createState() => _EditStaggerdGridViewState();
}

List<Widget> tiles = [];

class _EditStaggerdGridViewState extends State<EditStaggerdGridView> {
  String id = generateId();
  TextEditingController _nameDashboardController = TextEditingController();
  TextEditingController _nameArDashboardController = TextEditingController();
  TextEditingController _routeDashboardController = TextEditingController();
  TextEditingController _superCategoryDashboardController =
      TextEditingController();

  TextEditingController _imageDashboardController = TextEditingController();
  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>('');
  final _formKey = GlobalKey<FormBuilderState>();

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
              background: staggerdAdmin[index].image,
              routeName: staggerdAdmin[index].route,
              text: staggerdAdmin[index].name,
            ));
          }

          print("DASHBOARD ADMIN: " + staggerdAdmin.toString());
          return Expanded(
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                      height: 500,
                      width: 300,
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: staggerdAdmin.length,
                        itemBuilder: (BuildContext context, int index) =>
                            DashBoardTileAdmin(
                                background: staggerdAdmin[index].image,
                                routeName: staggerdAdmin[index].route,
                                text: staggerdAdmin[index].name),
                        staggeredTileBuilder: (index) => staggerdAdmin.length ==
                                10
                            ? index == staggerdAdmin.length - 1 // 10 DONE
                                ? StaggeredTile.count(2, 2.1)
                                : StaggeredTile.count(
                                    2, index.isEven ? 2.7 : 2.85)
                            : staggerdAdmin.length == 9
                                ? index == staggerdAdmin.length - 1 // 9 DONE
                                    ? StaggeredTile.count(2, 3.2)
                                    : StaggeredTile.count(
                                        2, index.isEven ? 2.5 : 3.3)
                                : staggerdAdmin.length == 8
                                    ? index ==
                                            staggerdAdmin.length - 1 // 8 DONE
                                        ? StaggeredTile.count(2, 2.25)
                                        : StaggeredTile.count(
                                            2, index.isEven ? 2.7 : 2.85)
                                    : staggerdAdmin.length == 7
                                        ? index ==
                                                staggerdAdmin.length -
                                                    1 // 7 DONE
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
                                                    ? StaggeredTile.count(
                                                        2, 3.15)
                                                    : StaggeredTile.count(
                                                        2,
                                                        index.isEven
                                                            ? 2.5
                                                            : 4.08)
                                                : staggerdAdmin.length ==
                                                        4 // 4 DONE
                                                    ? StaggeredTile.count(
                                                        2,
                                                        index.isOdd
                                                            ? 3.95
                                                            : 4.18)
                                                    : staggerdAdmin.length == 3
                                                        ? index ==
                                                                staggerdAdmin
                                                                        .length -
                                                                    1 // 3 DONE
                                                            ? StaggeredTile
                                                                .count(2, 4.4)
                                                            : StaggeredTile
                                                                .count(
                                                                    2,
                                                                    index.isEven
                                                                        ? 3.75
                                                                        : 8.13)
                                                        : staggerdAdmin.length ==
                                                                2 // 2 DONE
                                                            ? StaggeredTile
                                                                .count(2, 8.14)
                                                            : StaggeredTile // 1 DONE
                                                                .count(4, 8.14),
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                      )),
                  Positioned(
                      bottom: -40,
                      child: GestureDetector(
                        onTap: () {
                          showDialogWithFields();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 40,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
  // =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====
// =====                                   ADD DASHBOARD SUPER CATEGORY                   =====
// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====

  void showDialogWithFields() {
    // Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FormBuilder(
          key: _formKey,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              AlertDialog(
                scrollable: true,
                // (
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                content:
                    // child:
                    Container(
                  width: Responsive.isDesktop(context) ? 350 : 290,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    // color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // width: Responsive.isDesktop(context)
                  // ? size.width / 3
                  // : size.width - 20,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text(
                          //   'Create Dashboard',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: Responsive.isMiniMobile(context)
                          //           ? 15
                          //           : 20),
                          // ),
                          ValueListenableBuilder(
                            valueListenable: _imagevalue,
                            builder: (BuildContext context, dynamic value,
                                Widget? child) {
                              return Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    _imagevalue.value =
                                        await fireBaseUploadFileWeb(id);
                                    // if (_imageBannerController.text != '') {
                                    //   _imagevalue.value =
                                    //       _imageBannerController.text;
                                    // } else if (_imageBannerController.text ==
                                    //     '') {
                                    //   _imagevalue.value =
                                    //       ImageAssets.placeholder;
                                    // }
                                    // _imagevalue.value =
                                    //     _imageBannerController.text;
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      child: Stack(children: [
                                        _imagevalue.value != ''
                                            ? Stack(
                                                //There's Image
                                                children: [
                                                  Container(
                                                    height: 130,
                                                    width: 130,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: InteractiveViewer(
                                                      child: Image.network(
                                                        value,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 95),
                                                    child: Container(
                                                        height: 35,
                                                        width: 130,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0x4D000000)),
                                                        child: Center(
                                                            child: Icon(
                                                                Icons
                                                                    .edit_outlined,
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                ],
                                              )
                                            : Container(
                                                // There's no Image
                                                height: 130,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 9,
                                                      offset: Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: // _imagevalue.value ==
                                                    // '' &&
                                                    // showProgress
                                                    // ? Center(
                                                    // child:
                                                    // CircularProgressIndicator())
                                                    // :
                                                    Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                  size: 60,
                                                ),
                                              ),
                                      ]),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10),

                          Container(
                            child: CommonUI.textField(
                              context: context,
                              name: "Name",
                              hint: "Name",
                              isEdit: true,
                              minlines: 1,
                              controller: _nameDashboardController,
                              validate: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                          ),

                          SizedBox(height: 4),
                          Container(
                            child: CommonUI.textField(
                              context: context,
                              name: "Arabic Name (Optional)",
                              hint: "Arabic Name (Optional)",
                              isEdit: true,
                              minlines: 1,
                              controller: _nameArDashboardController,
                              // validate: FormBuilderValidators.compose([
                              //   FormBuilderValidators.required(context),
                              // ]),
                            ),
                          ),
                          SizedBox(height: 4),

                          Container(
                            child: CommonUI.textField(
                              context: context,
                              name: "Route",
                              hint: "Route",
                              isEdit: true,
                              minlines: 1,
                              controller: _routeDashboardController,
                              validate: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                          ),
                          SizedBox(height: 4),

                          Container(
                            child: CommonUI.textField(
                              context: context,
                              name: "Super Category",
                              hint: "Super Category",
                              isEdit: true,
                              minlines: 1,
                              controller: _superCategoryDashboardController,
                              validate: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                          ),
                        ],
                      )),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            id = generateId();
                            _imagevalue.value = _imageDashboardController.text;

                            _imageDashboardController.clear();
                            _nameDashboardController.clear();
                            _nameArDashboardController.clear();
                            _routeDashboardController.clear();
                            _superCategoryDashboardController.clear();
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
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () async {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              await FirebaseFirestore.instance
                                  .collection("dashboard")
                                  .doc(id)
                                  .set({
                                'id': id,
                                'indexKey': 0,
                                'name': _nameDashboardController.text
                                    .toCapitalized(),
                                'nameAr': _nameArDashboardController.text == ''
                                    ? _nameDashboardController.text
                                        .toCapitalized()
                                    : _nameArDashboardController.text
                                        .toCapitalized(),
                                'route': _routeDashboardController.text,
                                'superCategory':
                                    _superCategoryDashboardController.text,
                                'isPublished': true,
                                'image': _imagevalue.value == ''
                                    ? 'assets/images/preview.png'
                                    : _imagevalue.value,
                              }).whenComplete(() {
                                id = generateId();
                                _imagevalue.value =
                                    _imageDashboardController.text;

                                _imageDashboardController.clear();
                                _nameDashboardController.clear();
                                _nameArDashboardController.clear();
                                _routeDashboardController.clear();
                                _superCategoryDashboardController.clear();

                                Navigator.of(context).pop();

                                CommonUI.successDialog(context,
                                    message: "Saved successfully");
                              }).onError((error, stackTrrace) => showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            content: Text(error.toString()),
                                          );
                                        },
                                      ));
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          child: Text(
                            'Create',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 50,
                    child: Icon(
                      Icons.photo,
                      color: Colors.white,
                      size: 50,
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
