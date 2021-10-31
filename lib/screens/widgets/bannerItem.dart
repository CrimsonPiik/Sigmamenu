import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shop_app/GeneralFunction/firebase_uploader_web.dart';
import 'package:shop_app/models/banner.dart';
import 'package:shop_app/style/AssetsManager.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/style/ScreenUtil.dart';
import 'package:shop_app/style/Style.dart';

class BannersItem extends StatefulWidget {
  final BannerModel data;
  BannersItem(this.data);

  @override
  State<BannersItem> createState() => _BannersItemState();
}

class _BannersItemState extends State<BannersItem> {
  late TextEditingController _nameBannerController =
      TextEditingController(text: _name);
  late TextEditingController _categoryBannerController =
      TextEditingController(text: _category);
  late TextEditingController _imageBannerController =
      TextEditingController(text: _image);
  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>(null);
  final _formKey = GlobalKey<FormBuilderState>();
  // late OverlayEntry overlayEntry;

  bool editText = false;
  late String _name;
  late String _image;
  late String _category;

  @override
  void initState() {
    _name = widget.data.name;
    _image = widget.data.image;
    _category = widget.data.category;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Responsive.isDesktop(context)
          ? Row(
              children: [
                Container(
                    width: 250,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CommonUI.cachedImage(
                        widget.data.image, ImageAssets.placeholder,
                        fit: BoxFit.cover)),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //   // SizedBox(
                      //   //   height: 20,
                      //   // ),
                      Text(
                        widget.data.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      // CommonUI.text(
                      //   context: context,
                      //   text: widget.data.nameEn,
                      //   // RhinoLanguage.isLTR()
                      //   //     ? product.nameEn
                      //   //     : product.nameAr,
                      //   textAlign: TextAlign.center,
                      //   style: FontStyle.normal(
                      //       context: context, fontWeight: FontWeight.bold),
                      // ),

                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.data.category,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      // CommonUI.text(
                      //   context: context,
                      //   text: widget.data.descriptionEn,
                      //   // RhinoLanguage.isLTR()
                      //   //     ? product.nameEn
                      //   //     : product.nameAr,
                      //   textAlign: TextAlign.center,
                      //   style: FontStyle.normal(
                      //     context: context,
                      //     // fontWeight: FontWeight.bold
                      //   ),
                      // ),

                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Text(
                          //   " widget.data.price.toString()",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w300,
                          //       // fontStyle: FontStyle.italic,
                          //       fontSize: 12),
                          // ),
                          // CommonUI.text(
                          //   context: context,
                          //   text: widget.data.price.toString(),
                          //   // RhinoLanguage.isLTR()
                          //   //     ? product.nameEn
                          //   //     : product.nameAr,
                          //   textAlign: TextAlign.center,
                          //   style: FontStyle.normasl(
                          //       context: context, fontWeight: FontWeight.bold),
                          // ),
                          Container(
                            child: Row(
                              children: [
                                widget.data.isPublished == true
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.toggle_on,
                                          color: Colors.green,
                                          size: 35,
                                        ),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('Banner')
                                              .doc(widget.data.id)
                                              .update({'isPublished': false});
                                        })
                                    : IconButton(
                                        icon: Icon(
                                          Icons.toggle_off,
                                          color: Colors.red,
                                          size: 35,
                                        ),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('Banner')
                                              .doc(widget.data.id)
                                              .update({'isPublished': true});
                                        }),
                                SizedBox(width: 20),
                                TextButton(
                                    onPressed: () {
                                      _showEditDialog(context);
                                    },
                                    child:
                                        Icon(Icons.edit, color: Colors.brown)),
                                TextButton(
                                    onPressed: () {
                                      _showDeleteDialog(context);
                                    },
                                    child:
                                        Icon(Icons.delete, color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          : Row(
              children: [
                Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CommonUI.cachedImage(
                        widget.data.image, ImageAssets.placeholder,
                        fit: BoxFit.cover)),
                SizedBox(
                  width: 14,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      CommonUI.text(
                        context: context,
                        text: widget.data.name,
                        // RhinoLanguage.isLTR()
                        //     ? product.nameEn
                        //     : product.nameAr,
                        textAlign: TextAlign.center,
                        style: FontStyle.normal(
                            context: context, fontWeight: FontWeight.bold),
                      ),

                      // Text(
                      //   widget.data.nameEn,
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold, fontSize: 16),
                      // ),
                      SizedBox(
                        height: 3,
                      ),
                      // Text(
                      //   widget.data.descriptionEn,
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 2,
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w400, fontSize: 14),
                      // ),
                      CommonUI.text(
                        context: context,
                        text: widget.data.category,
                        // RhinoLanguage.isLTR()
                        //     ? product.nameEn
                        //     : product.nameAr,
                        textAlign: TextAlign.center,
                        style: FontStyle.normal(
                          context: context,
                          //  fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      // Text(
                      //   widget.data.price.toString(),
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w300,
                      //       // fontStyle: FontStyle.italic,
                      //       fontSize: 12),
                      // ),
                      // CommonUI.text(
                      //   context: context,
                      //   text: 'widget.data.price.toString()',
                      //   // RhinoLanguage.isLTR()
                      //   //     ? product.nameEn
                      //   //     : product.nameAr,
                      //   textAlign: TextAlign.center,
                      //   style: FontStyle.normal(
                      //       context: context, fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          widget.data.isPublished == true
                              ? IconButton(
                                  icon: Icon(
                                    Icons.toggle_on,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('Banner')
                                        .doc(widget.data.id)
                                        .update({'isPublished': false});
                                  })
                              : IconButton(
                                  icon: Icon(
                                    Icons.toggle_off,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('Banner')
                                        .doc(widget.data.id)
                                        .update({'isPublished': true});
                                  }),

                          SizedBox(
                            width: 45,
                            child: TextButton(
                                onPressed: () {
                                  _showEditDialog(context);
                                },
                                child: Icon(Icons.edit, color: Colors.brown)),
                          ),
                          SizedBox(
                            width: 45,
                            child: TextButton(
                                onPressed: () {
                                  _showDeleteDialog(context);
                                },
                                child: Icon(Icons.delete, color: Colors.red)),
                          ),
                          // ),
                        ],
                      ),
                      // ),
                    ],
                  ),
                ),
                // )
              ],
            ),
    );
  }

  _showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            content: Text('Are you sure you want to delete this banner ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  FirebaseFirestore.instance
                      .collection('Banner')
                      .doc(widget.data.id)
                      .delete();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'YES',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'NO',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          );
        });
  }

  _showEditDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormBuilder(
            key: _formKey,
            child: AlertDialog(
              title: Text(
                "Edit",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              content: Container(
                height: 410,
                // WIDTH IS ALREADY DEFINED
                padding: EdgeInsets.all(16),
                // margin: EdgeInsets.only(bottom: 26),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _imagevalue,
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        return InkWell(
                          onTap: () async {
                            _imageBannerController.text =
                                await fireBaseUploadFileWeb(widget.data.id);
                          },
                          child: Center(
                            child: Container(
                              height: 130,
                              child: Column(children: [
                                // value != null
                                //     ? Stack(children: [
                                //         Container(
                                //           height: 180,
                                //           // width: 180,
                                //           child: InteractiveViewer(
                                //             child: Image.network(value,
                                //                 fit: BoxFit.fitWidth),
                                //           ),
                                //         ),
                                //         Container(
                                //           decoration: BoxDecoration(
                                //               color: Color(0x4D303030)),
                                //           height: 180,
                                //           // width: 180,
                                //         ),
                                //         Padding(
                                //           padding: EdgeInsets.only(top: 145),
                                //           child: Container(
                                //               height: 35,
                                //               // width: 180,
                                //               decoration: BoxDecoration(
                                //                   color: Color(0x4D000000)),
                                //               // child: Center(
                                //               child: Row(
                                //                 mainAxisAlignment:
                                //                     MainAxisAlignment.center,

                                //                 children: [
                                //                   Text(
                                //                     'Edit ',
                                //                     style: TextStyle(
                                //                         color: Colors.white),
                                //                   ),
                                //                   Icon(Icons.edit,
                                //                       color: Colors.white)
                                //                 ],
                                //                 // ),
                                //               )),
                                //         ),
                                //       ])
                                // :
                                Stack(children: [
                                  Container(
                                      height: 130,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: CommonUI.cachedImage(
                                          widget.data.image,
                                          ImageAssets.placeholder,
                                          fit: BoxFit.fitWidth)),
                                  Container(
                                    decoration:
                                        BoxDecoration(color: Color(0x4D303030)),
                                    height: 130,
                                    width: 250,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 95),
                                    child: Container(
                                      height: 35,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Color(0x4D000000)),
                                      // child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Edit ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Icon(Icons.edit, color: Colors.white)
                                        ],
                                      ),
                                      // ),
                                    ),
                                  ),
                                ]),
                              ]),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 50),
                    Container(
                      child: CommonUI.textField(
                        context: context,
                        name: "Name",
                        hint: "Name",
                        isEdit: true,
                        minlines: 1,
                        controller: _nameBannerController,
                        validate: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      child: CommonUI.textField(
                        context: context,
                        name: "Category",
                        hint: "Category",
                        isEdit: true,
                        controller: _categoryBannerController,
                        validate: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      await FirebaseFirestore.instance
                          .collection('Banner')
                          .doc(widget.data.id)
                          .update({
                        'name': _nameBannerController.text,
                        'category': _categoryBannerController.text,
                        'image': _imageBannerController.text
                      }).whenComplete(() {
                        Navigator.of(context).pop();
                        // Future.delayed(Duration(seconds: 1)).then((value) => {
                        // Overlay.of(context)!.insert(overlayEntry);
                        // Timer(
                        // Duration(seconds: 1),
                        // () => OverlayEntry(
                        // builder: (context) =>
                        CommonUI.successDialog(context,
                            message: "Saved successfully");
                        // .remove()));
                        // });
                      }).onError((error, stackTrace) => showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    content: Text(error.toString()),
                                  );
                                },
                              ));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _categoryBannerController =
                        TextEditingController(text: _category);
                    _nameBannerController = TextEditingController(text: _name);
                    _imageBannerController =
                        TextEditingController(text: _image);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
