import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/GeneralFunction/Strings.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class AddCategoryButton extends StatefulWidget {
  @override
  State<AddCategoryButton> createState() => _AddCategoryButtonState();
}

class _AddCategoryButtonState extends State<AddCategoryButton> {
  TextEditingController newCollectionNameController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 40,
            child: TextButton.icon(
                onPressed: () {
                  _showDeleteDialog(context);
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text(
                  'Category  ',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            decoration: BoxDecoration(
              color: Colors.green[600],
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        SizedBox(width: 19),
      ],
    );
  }

  _showDeleteDialog(BuildContext context) {
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
                            'Add Category',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Responsive.isMiniMobile(context) ? 15 : 20),
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.fromLTRB(24, 16, 24, 1),
                            child: CommonUI.textField(
                              context: context,
                              name: "Category Name",
                              hint: 'e.g Drinks',
                              maxlines: 1,
                              controller: newCollectionNameController,
                              validate: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                _formKey.currentState!.save();
                
                                if (_formKey.currentState!.validate()) {
                                  await FirebaseFirestore.instance
                                      .collection(newCollectionNameController.text
                                          .toLowerCase()
                                          .toTitleCase())
                                      .add({});
                                  FocusScope.of(context).unfocus();
                                  await FirebaseFirestore.instance
                                      .collection('Categories')
                                      .doc(newCollectionNameController.text
                                          .toLowerCase()
                                          .toTitleCase())
                                      .set({}).whenComplete(() {
                                    Navigator.of(context).pop();
                                    newCollectionNameController.clear();
                
                                    CommonUI.successDialog(context,
                                        message: "Added successfully");
                                  }).onError(
                                    (error, stackTrrace) => showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content: Text(error.toString()),
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                              ),
                              child: Text(
                                'Add',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                        // ),
                        // ],
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
            ),
          ),
        );
      },
    );
  }

  // void _showAddCollectionDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return FormBuilder(
  //           key: _formKey,
  //           child: AlertDialog(
  //             title: Text(
  //               'Add Category',
  //               style: TextStyle(fontWeight: FontWeight.bold),
  //             ),
  //             actions: [
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.all(16),
  //                     child: CommonUI.textField(
  //                       context: context,
  //                       name: "Name",
  //                       hint: 'Name',
  //                       maxlines: 1,
  //                       controller: newCollectionNameController,
  //                       validate: FormBuilderValidators.compose([
  //                         FormBuilderValidators.required(context),
  //                       ]),
  //                     ),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Container(
  //                         padding: EdgeInsets.all(4),
  //                         child: TextButton(
  //                           onPressed: () async {
  //                             _formKey.currentState!.save();

  //                             if (_formKey.currentState!.validate()) {
  //                               await FirebaseFirestore.instance
  //                                   .collection(newCollectionNameController.text
  //                                       .toLowerCase()
  //                                       .toTitleCase())
  //                                   .add({});
  //                               FocusScope.of(context).unfocus();
  //                               await FirebaseFirestore.instance
  //                                   .collection('Categories')
  //                                   .doc(newCollectionNameController.text
  //                                       .toLowerCase()
  //                                       .toTitleCase())
  //                                   .set({}).whenComplete(() {
  //                                 Navigator.of(context).pop();
  //                                 newCollectionNameController.clear();

  //                                 CommonUI.successDialog(context,
  //                                     message: "Saved successfully");
  //                               }).onError(
  //                                 (error, stackTrrace) => showDialog(
  //                                   context: context,
  //                                   builder: (_) {
  //                                     return AlertDialog(
  //                                       content: Text(error.toString()),
  //                                     );
  //                                   },
  //                                 ),
  //                               );
  //                             }
  //                           },
  //                           child: Text(
  //                             'Add',
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.black),
  //                           ),
  //                         ),
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey.withOpacity(0.2),
  //                           borderRadius: BorderRadius.circular(16),
  //                         ),
  //                       ),
  //                       SizedBox(width: 10),
  //                       Container(
  //                         padding: EdgeInsets.all(4),
  //                         child: TextButton(
  //                           onPressed: () {
  //                             newCollectionNameController.clear();
  //                             Navigator.of(context).pop();
  //                           },
  //                           child: Text(
  //                             'Cancel',
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.black),
  //                           ),
  //                         ),
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey.withOpacity(0.2),
  //                           borderRadius: BorderRadius.circular(16),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
