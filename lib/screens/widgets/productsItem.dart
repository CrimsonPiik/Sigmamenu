import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constaints.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/style/AssetsManager.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/style/ScreenUtil.dart';

class ProductsItem extends StatefulWidget {
  final Product data;
  ProductsItem(this.data);

  @override
  State<ProductsItem> createState() => _ProductsItemState();
}

class _ProductsItemState extends State<ProductsItem> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionEnController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool editText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
              width: 80,
              height: 80,
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
                Text(
                  widget.data.nameEn,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.data.descriptionEn,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.data.price.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          _showEditDialog(context);
                        },
                        child: Icon(Icons.edit, color: Colors.blue)),
                    TextButton(
                        onPressed: () {
                          _showDeleteDialog(context);
                        },
                        child: Icon(Icons.delete, color: Colors.red)),
                  ],
                )
              ],
            ),
          )
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

                  FirebaseFirestore.instance
                      .collection('drinks')
                      .doc(widget.data.id)
                      .delete();
                },
                child: Text(
                  'YES',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'NO',
                  style: TextStyle(color: Colors.black),
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
              height: 200,
              // WIDTH IS ALREADY DEFINED
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CommonUI.cachedImage(
                          widget.data.image, ImageAssets.placeholder,
                          fit: BoxFit.cover)),
                  SizedBox(
                    width: 18,
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
                              width: ScreenUtil.isDesktop(context) ? 200 : 70,
                              child: CommonUI.textField(
                                  context: context,
                                  name: "NameEn",
                                  controller: nameController,
                                  hint: widget.data.nameEn),
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
                              width: ScreenUtil.isDesktop(context) ? 200 : 70,
                              child: CommonUI.textField(
                                  context: context,
                                  name: "descriptionEn",
                                  controller: descriptionEnController,
                                  hint: widget.data.descriptionEn),
                            ),
                            // TextButton(
                            //     onPressed: () {},
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
                            //   widget.data.price.toString(),
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w300,
                            //       // fontStyle: FontStyle.italic,
                            //       fontSize: 17),
                            // ),
                            Container(
                              height: 50,
                              width: ScreenUtil.isDesktop(context) ? 200 : 70,
                              child: CommonUI.textField(
                                  context: context,
                                  name: "price",
                                  // keyboardType: TextInputType(number),
                                  controller: priceController,
                                  hint: widget.data.price.toString()),
                            ),
                            // TextButton(
                            //     onPressed: () {},
                            //     child: Icon(Icons.edit, color: Colors.brown)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('drinks')
                      .doc(widget.data.id)
                      .update({
                    'nameEn': nameController.text,
                    'descriptionEn': descriptionEnController.text,
                    'price': priceController.text
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        });
  }
}
