import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/GeneralFunction/firebase_uploader_web.dart';
import 'package:sigmamenu/GeneralFunction/random_id_generator.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class AddBannerButton extends StatefulWidget {
  @override
  State<AddBannerButton> createState() => _AddBannerButtonState();
}

class _AddBannerButtonState extends State<AddBannerButton> {
  String id = generateId();
  String imageURL = 'assets/images/placeholder.jpg';
  // TextEditingController _nameBannerController = TextEditingController();
  // TextEditingController _categoryBannerController = TextEditingController();
  TextEditingController _imageBannerController = TextEditingController();
  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>('');
  final _formKey = GlobalKey<FormBuilderState>();
  // String category = categoriesList.elementAt(0);
  // bool error = false;
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 21),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 40,
            child: TextButton.icon(
                onPressed: () {
                  showDialogWithFields();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text(
                  'Banner  ',
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
                        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text(
                            //   'Create Banner',
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: Responsive.isMiniMobile(context)
                            //           ? 15
                            //           : 20),
                            // ),
                            // SizedBox(height: 10),
                            ValueListenableBuilder(
                              valueListenable: _imagevalue,
                              builder: (BuildContext context, dynamic value,
                                  Widget? child) {
                                return StatefulBuilder(
                                  builder: (context, state) => Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        state(() {
                                          showProgress = true;
                                        });
                                        _imagevalue.value =
                                            await fireBaseUploadFileWeb(id);
                                        if (_imagevalue.value == '') {
                                          state(() {
                                            showProgress = false;
                                          });
                                        }
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
                                          height: 150,
                                          width: 250,
                                          child: Stack(children: [
                                            _imagevalue.value != ''
                                                ? Stack(
                                                    //There's Image
                                                    children: [
                                                      Container(
                                                        height: 150,
                                                        width: 250,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child:
                                                            InteractiveViewer(
                                                          child: Image.network(
                                                            value,
                                                            fit: BoxFit.cover,
                                                            loadingBuilder:
                                                                (context, child,
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
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 115),
                                                        child: Container(
                                                            height: 35,
                                                            width: 250,
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
                                                    height: 150,
                                                    width: 250,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
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
                                                    child: showProgress
                                                        ? Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : Icon(
                                                            Icons.add,
                                                            color: Colors.black,
                                                            size: 60,
                                                          )),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            // error ? Text('Error!!') : Container(),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        showProgress = false;
                                      });
                                      id = generateId();
                                      _imagevalue.value =
                                          _imageBannerController.text;

                                      _imageBannerController.clear();
                                      Navigator.pop(context);
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
                                      setState(() {
                                        showProgress = false;
                                      });
                                      if (_imagevalue.value!.isEmpty) {
                                        Navigator.pop(context);
                                      } else {
                                        _formKey.currentState!.save();
                                        if (_formKey.currentState!.validate()) {
                                          FocusScope.of(context).unfocus();
                                          await FirebaseFirestore.instance
                                              .collection("Banner")
                                              .doc(id)
                                              .set({
                                            'id': id,
                                            'isPublished': true,
                                            'image': _imagevalue.value == ''
                                                ? 'assets/images/preview.png'
                                                : _imagevalue.value,
                                            //subCategory: ---
                                          }).whenComplete(() {
                                            id = generateId();
                                            _imagevalue.value =
                                                _imageBannerController.text;

                                            _imageBannerController.clear();
                                            Navigator.pop(context);

                                            CommonUI.successDialog(context,
                                                message: "Added successfully");
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
                          Icons.photo,
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
