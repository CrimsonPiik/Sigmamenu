import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/GeneralFunction/Strings.dart';
import 'package:sigmamenu/GeneralFunction/firebase_uploader_web.dart';
import 'package:sigmamenu/GeneralFunction/random_id_generator.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class AddDashboardButton extends StatefulWidget {
  // final Stream<int> stream;

  // AddDashboardButton(this.stream);

  @override
  State<AddDashboardButton> createState() => _AddDashboardButtonState();
}

class _AddDashboardButtonState extends State<AddDashboardButton> {
  String id = generateId();
  TextEditingController _nameDashboardController = TextEditingController();
  TextEditingController _nameArDashboardController = TextEditingController();
  TextEditingController _routeDashboardController = TextEditingController();
  TextEditingController _superCategoryDashboardController =
      TextEditingController();

  TextEditingController _imageDashboardController = TextEditingController();
  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>(null);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // _imagevalue.value = _imageBannerController.text;
    return Row(
      children: [
        SizedBox(width: 21),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 40,
            child: TextButton.icon(
                onPressed: () {
                  // _imagevalue.value = _imageBannerController.text;
                  showDialogWithFields();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text(
                  'Dashboard  ',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            decoration: BoxDecoration(
              color: Colors.green[600],
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }

  void showDialogWithFields() {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FormBuilder(
          key: _formKey,
          child: Dialog(
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
                              'Create Dashboard',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Responsive.isMiniMobile(context)
                                      ? 15
                                      : 20),
                            ),
                            SizedBox(height: 10),
                            ValueListenableBuilder(
                              valueListenable: _imagevalue,
                              builder: (BuildContext context, dynamic value,
                                  Widget? child) {
                                return Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      _imageDashboardController.text =
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
                                        height: 130,
                                        width: 250,
                                        child: Column(
                                          children: [
                                            Stack(children: [
                                              _imagevalue.value != null
                                                  ? Container(
                                                      height: 130,
                                                      width: 250,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
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
                                                    )
                                                  : Container(
                                                      height: 130,
                                                      width: 250,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/placeholder.jpg',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0x4D303030)),
                                                height: 130,
                                                width: 250,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 95),
                                                child: Container(
                                                    height: 35,
                                                    width: 250,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0x4D000000)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // Text(
                                                        //   'ADD ',
                                                        //   style: TextStyle(
                                                        //       color:
                                                        //           Colors.white),
                                                        // ),
                                                        Icon(Icons.camera_alt,
                                                            color: Colors.white)
                                                      ],
                                                    )),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // ),
                                );
                              },
                            ),
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

                            // ),

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
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      id = generateId();
                                      _imagevalue.value =
                                          _imageDashboardController.text;

                                      _imageDashboardController.clear();
                                      _nameDashboardController.clear();
                                      _nameArDashboardController.clear();
                                      _routeDashboardController.clear();
                                      _superCategoryDashboardController.clear();
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
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
                                          'nameAr': _nameArDashboardController
                                                      .text ==
                                                  ''
                                              ? _nameDashboardController.text
                                                  .toCapitalized()
                                              : _nameArDashboardController.text
                                                  .toCapitalized(),
                                          'route':
                                              _routeDashboardController.text,
                                          'superCategory':
                                              _superCategoryDashboardController
                                                  .text,
                                          'isPublished': true,
                                          'image': _imageDashboardController
                                                      .text ==
                                                  ' '
                                              ? 'assets/images/placeholder.jpg'
                                              : _imageDashboardController.text,
                                        }).whenComplete(() {
                                          id = generateId();
                                          _imagevalue.value =
                                              _imageDashboardController.text;

                                          _imageDashboardController.clear();
                                          _nameDashboardController.clear();
                                          _nameArDashboardController.clear();
                                          _routeDashboardController.clear();
                                          _superCategoryDashboardController
                                              .clear();

                                          Navigator.of(context).pop();

                                          CommonUI.successDialog(context,
                                              message: "Saved successfully");
                                        }).onError((error, stackTrrace) =>
                                                showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          error.toString()),
                                                    );
                                                  },
                                                ));
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green),
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
                      ),
                    ),
                  ),
                  Positioned(
                      top: -60,
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 50,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 50,
                        ),
                      )),
                ],
              )),
        );
      },
    );
  }
}
