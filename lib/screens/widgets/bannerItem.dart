import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  TextEditingController _nameBannerController = TextEditingController();
  TextEditingController _categoryBannerController = TextEditingController();
  TextEditingController _imageBannerController = TextEditingController();
  ValueNotifier<String?> _image = ValueNotifier<String?>(null);

  bool editText = false;

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
            title: Text('Delete'),
            content: Text('Are you sure you want to delete this product?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  // FirebaseFirestore.instance
                  //     .collection(widget.data.category)
                  //     .doc(widget.data.id)
                  //     .delete();
                },
                child: Container(
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'YES',
                    style: TextStyle(color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'NO',
                    style: TextStyle(color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
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
          return AlertDialog(
            title: Text("Edit"),
            content: Container(
              height: 215,
              // WIDTH IS ALREADY DEFINED
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 26),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: _image,
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        return InkWell(
                          onTap: () async {
                            _imageBannerController.text =
                                await fireBaseUploadFileWeb(widget.data.id);
                          },
                          child: Container(
                            child: Column(children: [
                              value != null
                                  ? Stack(children: [
                                      Container(
                                        height: 180,
                                        // width: 180,
                                        child: InteractiveViewer(
                                          child: Image.network(value,
                                              fit: BoxFit.fitWidth),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0x4D303030)),
                                        height: 180,
                                        // width: 180,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 145),
                                        child: Container(
                                            height: 35,
                                            // width: 180,
                                            decoration: BoxDecoration(
                                                color: Color(0x4D000000)),
                                            // child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,

                                              children: [
                                                Text(
                                                  'Edit ',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Icon(Icons.edit,
                                                    color: Colors.white)
                                              ],
                                              // ),
                                            )),
                                      ),
                                    ])
                                  : Stack(children: [
                                      Container(
                                          height: 180,
                                          // width: 180,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: CommonUI.cachedImage(
                                              widget.data.image,
                                              ImageAssets.placeholder,
                                              fit: BoxFit.fitWidth)),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0x4D303030)),
                                        height: 180,
                                        // width: 180,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 145),
                                        child: Container(
                                          height: 35,
                                          // width: 180,
                                          decoration: BoxDecoration(
                                              color: Color(0x4D000000)),
                                          // child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Edit ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(Icons.edit,
                                                  color: Colors.white)
                                            ],
                                          ),
                                          // ),
                                        ),
                                      ),
                                    ]),
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // editText
                            //     ? Text(
                            //         widget.data.nameEn,
                            //         overflow: TextOverflow.ellipsis,
                            //         maxLines: 1,
                            //         style: TextStyle(
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 21),
                            //       )
                            //     :
                            Container(
                              height: 50,
                              width: Responsive.isDesktop(context) ? 200 : 70,
                              child: CommonUI.textField(
                                  isEdit: true,
                                  context: context,
                                  name: "Name",
                                  controller: _nameBannerController,
                                  hint: widget.data.name),
                            ),
                            // : TextFormField(
                            //     decoration: const InputDecoration(
                            //       icon: Icon(Icons.person),
                            //       hintText: 'What do people call you?',
                            //       labelText: 'Name *',
                            //     ),
                            // onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                            // },
                            // validator: (String? value) {
                            //   return (value != null &&
                            //           value.contains('@'))
                            //       ? 'Do not use the @ char.'
                            //       : null;
                            // },
                            // ),
                            // TextButton(
                            //     onPressed: () {
                            //       editText = true;
                            //     },
                            //     child: Icon(Icons.edit, color: Colors.brown)),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Text(
                            //   widget.data.descriptionEn,
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 2,
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w400, fontSize: 19),
                            // ),
                            Container(
                              height: 50,
                              width: Responsive.isDesktop(context) ? 200 : 70,
                              child: CommonUI.textField(
                                  isEdit: true,
                                  context: context,
                                  name: "category",
                                  controller: _categoryBannerController,
                                  hint: widget.data.category),
                            ),
                            // TextButton(
                            //     onPressed: () {},
                            //     child: Icon(Icons.edit, color: Colors.brown)),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     // Text(
                        //     //   widget.data.price.toString(),
                        //     //   style: TextStyle(
                        //     //       fontWeight: FontWeight.w300,
                        //     //       // fontStyle: FontStyle.italic,
                        //     //       fontSize: 17),
                        //     // ),
                        //     Container(
                        //       height: 50,
                        //       width: Responsive.isDesktop(context) ? 200 : 70,
                        //       child: CommonUI.textField(
                        //           context: context,
                        //           name: "price",
                        //           // keyboardType: TextInputType(number),
                        //           controller: _priceController,
                        //           hint: ' widget.data.price.toString()'),
                        //     ),
                        //     // TextButton(
                        //     //     onPressed: () {},
                        //     //     child: Icon(Icons.edit, color: Colors.brown)),
                        //   ],
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // FirebaseFirestore.instance
                  //     .collection(widget.data.category)
                  //     .doc(widget.data.id)
                  //     .update({
                  //   'nameEn': _nameEnController.text,
                  //   'descriptionEn': _descriptionEnController.text,
                  //   'price': _priceController.text,
                  //   'image': _imageController.text
                  // });
                  Navigator.of(context).pop();
                },
                child: Container(
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
