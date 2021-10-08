import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/style/AssetsManager.dart';
import 'package:shop_app/style/CommonUI.dart';

class ProductsItem extends StatelessWidget {
  final Product data;
  const ProductsItem(this.data);

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
              width: 60,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: CommonUI.cachedImage(data.image, ImageAssets.placeholder,
                  fit: BoxFit.cover)),
          SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.nameEn,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  data.descriptionEn,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  data.price.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      fontSize: 12),
                ),
                Row(
                  children: [
                    // TextButton(
                    // onPressed: () {},
                    // child: Icon(
                    // Icons.add,
                    // color: Colors.green,
                    // )),
                    TextButton(
                        onPressed: () {
                          _showDeleteDialog(context);
                        },
                        child: Icon(Icons.delete, color: Colors.red)),
                    TextButton(
                        onPressed: () {},
                        child: Icon(Icons.edit, color: Colors.blue)),
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
                      .doc(data.id)
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
}
