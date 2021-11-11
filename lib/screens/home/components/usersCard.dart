import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/style/AssetsManager.dart';
import 'package:sigmamenu/style/CommonUI.dart';

class UsersCard extends StatelessWidget {
  const UsersCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            //  Responsive.isDesktop(context)
            // ?

            Row(
          children: [
            Container(
                width: 120,
                // height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: CommonUI.cachedImage(
                   ' widget.data.image', ImageAssets.placeholder,
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
                    'widget.data.nameEn',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    'widget.data.descriptionEn',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                   ' widget.data.price.toString()',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        // fontStyle: FontStyle.italic,
                        fontSize: 12),
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

                  // SizedBox(
                  //   height: 4,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // widget.data.weight >= 1
                      //     ? IconButton(
                      //         icon: Icon(
                      //           Icons.toggle_on,
                      //           color: Colors.green,
                      //           size: 35,
                      //         ),
                      //         onPressed: () {
                      //           // FirebaseFirestore.instance
                      //           //     .collection(widget.data.category)
                      //           //     .doc(widget.data.id)
                      //           //     .update({'weight': 0});
                      //         })
                      //     : IconButton(
                      //         icon: Icon(
                      //           Icons.toggle_off,
                      //           color: Colors.red,
                      //           size: 35,
                      //         ),
                      //         onPressed: () {
                      //           // FirebaseFirestore.instance
                      //           //     .collection(widget.data.category)
                      //           //     .doc(widget.data.id)
                      //           //     .update({'weight': 1});
                      //         }),
                      SizedBox(width: 20),
                      TextButton(
                          onPressed: () {
                            // setState(() {
                            //   _nameEnController = TextEditingController(
                            //       text: widget.data.nameEn);
                            //   _descriptionEnController = TextEditingController(
                            //       text: widget.data.descriptionEn);
                            //   _priceController = TextEditingController(
                            //       text: widget.data.price.toString());
                            //   _imageController = TextEditingController(
                            //       text: widget.data.image);
                            //   _value = widget.data.weight.toDouble();
                            // });
                            // _showEditDialog(context, widget.data);
                          },
                          child: Icon(Icons.edit, color: Colors.brown)),
                      TextButton(
                          onPressed: () {
                            // _showDeleteDialog(context);
                          },
                          child: Icon(Icons.delete, color: Colors.red)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
