import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shop_app/GeneralFunction/firebase_uploader_web.dart';
import 'package:shop_app/GeneralFunction/random_id_generator.dart';
import 'package:shop_app/screens/adminPanel.dart';
import 'package:shop_app/style/CommonUI.dart';

class AddBannerButton extends StatefulWidget {
  @override
  State<AddBannerButton> createState() => _AddBannerButtonState();
}

class _AddBannerButtonState extends State<AddBannerButton> {
  String id = generateId();
  String imageURL = 'assets/images/placeholder.jpg';
  TextEditingController _nameBannerController = TextEditingController();
  TextEditingController _categoryBannerController = TextEditingController();
  TextEditingController _imageBannerController = TextEditingController();
  ValueNotifier<String?> _image = ValueNotifier<String?>(null);
  final _formKey = GlobalKey<FormBuilderState>();

  String category = categoriesList.elementAt(0);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 21),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
              onPressed: () {
                showDialogWithFields();
              },
              icon: Icon(Icons.add),
              label: Text('Banner')),
        ),
      ],
    );
  }

  void showDialogWithFields() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormBuilder(
            key: _formKey,
            child: AlertDialog(
              scrollable: true,
              title: Text('Create a new Banner',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              content: Container(
                // WIDTH IS ALREADY DEFINED
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ValueListenableBuilder(
                      valueListenable: _image,
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        return InkWell(
                          onTap: () async {
                            CircularProgressIndicator();
                            _imageBannerController.text =
                                await fireBaseUploadFileWeb(id);
                            _image.value = _imageBannerController.text;
                          },
                          child: Center(
                            child: Container(
                              height: 130,
                              child: Stack(children: [
                                Container(
                                  height: 130,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Image.asset(
                                    'assets/images/placeholder.jpg',
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'ADD ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Icon(Icons.add, color: Colors.white)
                                        ],
                                      )),
                                ),
                              ]),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 40),
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
                          .collection("Banner")
                          .doc(id)
                          .set({
                        'id': id,
                        'name': _nameBannerController.text,
                        'category': _categoryBannerController.text,
                        'isPublished': true,
                        'image': _imageBannerController.text,
                        //subCategory: ---
                      }).whenComplete(() {
                        Navigator.of(context).pop();
                        _categoryBannerController.clear();
                        _nameBannerController.clear();
                        _imageBannerController.clear();

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
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Create',
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
                    _categoryBannerController.clear();
                    _nameBannerController.clear();
                    _imageBannerController.clear();

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
