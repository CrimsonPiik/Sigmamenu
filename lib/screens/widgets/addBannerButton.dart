import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/GeneralFunction/firebase_uploader_web.dart';
import 'package:sigmamenu/GeneralFunction/random_id_generator.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
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
  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>(null);
  final _formKey = GlobalKey<FormBuilderState>();
  String category = categoriesList.elementAt(0);

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
                  _imagevalue.value = _imageBannerController.text;
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

  // void showDialogWithFields() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return FormBuilder(
  //           key: _formKey,
  //           child: AlertDialog(
  //             scrollable: true,
  //             title: Text('Create Banner',
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold, color: Colors.black)),
  //             content: Container(
  //               width: Responsive.isDesktop(context) ? 350 : 290,
  //               padding: EdgeInsets.all(16),
  //               decoration: BoxDecoration(
  //                 color: Colors.grey.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   ValueListenableBuilder(
  //                     valueListenable: _imagevalue,
  //                     builder:
  //                         (BuildContext context, dynamic value, Widget? child) {
  //                       return Center(
  //                         child: Ink(
  //                           width: 180,
  //                           height: 180,
  //                           child: InkWell(
  //                             onTap: () async {
  //                               _imageBannerController.text =
  //                                   await fireBaseUploadFileWeb(id);
  //                               _imagevalue.value = _imageBannerController.text;
  //                             },
  //                             child: Center(
  //                               child: Container(
  //                                 height: 130,
  //                                 width: 250,
  //                                 child: Column(
  //                                   children: [
  //                                     Stack(children: [
  //                                       _imagevalue.value != null
  //                                           ? Container(
  //                                               height: 130,
  //                                               width: 250,
  //                                               decoration: BoxDecoration(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(4),
  //                                               ),
  //                                               child: InteractiveViewer(
  //                                                 child: Image.network(
  //                                                   value,
  //                                                   fit: BoxFit.fitWidth,
  //                                                   loadingBuilder: (context,
  //                                                       child,
  //                                                       loadingProgress) {
  //                                                     if (loadingProgress ==
  //                                                         null) {
  //                                                       return child;
  //                                                     }
  //                                                     return Center(
  //                                                       child:
  //                                                           CircularProgressIndicator(),
  //                                                     );
  //                                                   },
  //                                                 ),
  //                                               ),
  //                                             )
  //                                           : Container(
  //                                               height: 130,
  //                                               width: 250,
  //                                               decoration: BoxDecoration(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(4),
  //                                               ),
  //                                               child: Image.asset(
  //                                                 'assets/images/placeholder.jpg',
  //                                                 fit: BoxFit.fitWidth,
  //                                               ),
  //                                             ),
  //                                       Container(
  //                                         decoration: BoxDecoration(
  //                                             color: Color(0x4D303030)),
  //                                         height: 130,
  //                                         width: 250,
  //                                       ),
  //                                       Padding(
  //                                         padding: EdgeInsets.only(top: 95),
  //                                         child: Container(
  //                                             height: 35,
  //                                             width: 250,
  //                                             decoration: BoxDecoration(
  //                                                 color: Color(0x4D000000)),
  //                                             child: Row(
  //                                               mainAxisAlignment:
  //                                                   MainAxisAlignment.center,
  //                                               children: [
  //                                                 Text(
  //                                                   'ADD ',
  //                                                   style: TextStyle(
  //                                                       color: Colors.white),
  //                                                 ),
  //                                                 Icon(Icons.add,
  //                                                     color: Colors.white)
  //                                               ],
  //                                             )),
  //                                       ),
  //                                     ]),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                   // SizedBox(height: 40),
  //                   // Container(
  //                   //   child: CommonUI.textField(
  //                   //     context: context,
  //                   //     name: "Name",
  //                   //     hint: "Name",
  //                   //     isEdit: true,
  //                   //     minlines: 1,
  //                   //     controller: _nameBannerController,
  //                   //     validate: FormBuilderValidators.compose([
  //                   //       FormBuilderValidators.required(context),
  //                   //     ]),
  //                   //   ),
  //                   // ),
  //                   // SizedBox(height: 4),
  //                   // Container(
  //                   //   child: CommonUI.textField(
  //                   //     context: context,
  //                   //     name: "Category",
  //                   //     hint: "Category",
  //                   //     isEdit: true,
  //                   //     controller: _categoryBannerController,
  //                   //     validate: FormBuilderValidators.compose([
  //                   //       FormBuilderValidators.required(context),
  //                   // ]),
  //                   // ),
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () async {
  //                   _formKey.currentState!.save();
  //                   if (_formKey.currentState!.validate()) {
  //                     FocusScope.of(context).unfocus();
  //                     await FirebaseFirestore.instance
  //                         .collection("Banner")
  //                         .doc(id)
  //                         .set({
  //                       'id': id,
  //                       // 'name': _nameBannerController.text,
  //                       // 'category': _categoryBannerController.text,
  //                       'isPublished': true,
  //                       'image': _imageBannerController.text,
  //                       //subCategory: ---
  //                     }).whenComplete(() {
  //                       // _categoryBannerController.clear();
  //                       // _nameBannerController.clear();
  //                       id = generateId();
  //                       _imagevalue.value = 'assets/images/placeholder.jpg';

  //                       _imageBannerController.clear();
  //                       Navigator.of(context).pop();

  //                       CommonUI.successDialog(context,
  //                           message: "Saved successfully");
  //                     }).onError((error, stackTrrace) => showDialog(
  //                               context: context,
  //                               builder: (_) {
  //                                 return AlertDialog(
  //                                   content: Text(error.toString()),
  //                                 );
  //                               },
  //                             ));
  //                   }
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.all(10),
  //                   child: Text(
  //                     'Create',
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold, color: Colors.black),
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey.withOpacity(0.5),
  //                     borderRadius: BorderRadius.circular(16),
  //                   ),
  //                 ),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   // _categoryBannerController.clear();
  //                   // _nameBannerController.clear();
  //                   id = generateId();
  //                   _imagevalue.value = 'assets/images/placeholder.jpg';

  //                   _imageBannerController.clear();

  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.all(10),
  //                   child: Text(
  //                     'Cancel',
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold, color: Colors.black),
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey.withOpacity(0.5),
  //                     borderRadius: BorderRadius.circular(16),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

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
                              'Create Banner',
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
                                      _imageBannerController.text =
                                          await fireBaseUploadFileWeb(id);
                                      // if (_imageBannerController.text != '') {
                                      //   _imagevalue.value =
                                      //       _imageBannerController.text;
                                      // } else if (_imageBannerController.text ==
                                      //     '') {
                                      //   _imagevalue.value =
                                      //       ImageAssets.placeholder;
                                      // }
                                      _imagevalue.value =
                                          _imageBannerController.text;
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
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      id = generateId();
                                      _imagevalue.value =
                                          _imageBannerController.text;

                                      _imageBannerController.clear();
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
                                            .collection("Banner")
                                            .doc(id)
                                            .set({
                                          'id': id,
                                          // 'name': _nameBannerController.text,
                                          // 'category': _categoryBannerController.text,
                                          'isPublished': true,
                                          'image': _imageBannerController
                                                      .text ==
                                                  ' '
                                              ? 'assets/images/placeholder.jpg'
                                              : _imageBannerController.text,
                                          //subCategory: ---
                                        }).whenComplete(() {
                                          // _categoryBannerController.clear();
                                          // _nameBannerController.clear();
                                          id = generateId();
                                          _imagevalue.value =
                                              _imageBannerController.text;

                                          _imageBannerController.clear();
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
