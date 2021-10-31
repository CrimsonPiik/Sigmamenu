import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shop_app/GeneralFunction/firebase_uploader_web.dart';
import 'package:shop_app/GeneralFunction/random_id_generator.dart';
import 'package:shop_app/screens/adminPanel.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/style/ScreenUtil.dart';

class AddProductButton extends StatefulWidget {
  final Stream<int> stream;

  AddProductButton(this.stream);

  @override
  State<AddProductButton> createState() => _AddProductButtonState();
}

class _AddProductButtonState extends State<AddProductButton> {
  String id = generateId();
  String imageURL = 'assets/images/placeholder.jpg';
  TextEditingController _nameEnController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionEnController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>(null);
  final _formKey = GlobalKey<FormBuilderState>();
  String category = categoriesList.elementAt(0);

  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) {
      mySetState(index);
    });
  }

  void mySetState(int index) {
    if (!mounted) return;

    setState(() {
      category = categoriesList.elementAt(index);
    });
  }

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
              label: Text('Product')),
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
              title: Text('Create a new Product',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              content: Container(
                width: Responsive.isDesktop(context) ? 350 : 290,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ValueListenableBuilder(
                      valueListenable: _imagevalue,
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        return InkWell(
                          onTap: () async {
                            // CircularProgressIndicator();
                            _imageController.text =
                                await fireBaseUploadFileWeb(id);
                                    setState(() {
                                _imagevalue.value = _imageController.text;
                              });
                          },
                          child: Center(
                            child: Container(
                              width: 180,
                              height: 180,
                              child: Stack(children: [
                                Container(
                                  height: 180,
                                  width: 180,
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
                                  height: 180,
                                  width: 180,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 145),
                                  child: Container(
                                      height: 35,
                                      width: 180,
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
                        controller: _nameEnController,
                        validate: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      child: CommonUI.textField(
                        context: context,
                        name: "price",
                        hint: "Price",
                        isEdit: true,
                        keyboardtype: TextInputType.number,
                        controller: _priceController,
                        validate: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.numeric(context),
                        ]),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      child: CommonUI.textField(
                        context: context,
                        name: "Description",
                        hint: "Description",
                        maxlength: 600,
                        minlines: 2,
                        controller: _descriptionEnController,
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
                          .collection(category)
                          .doc(id)
                          .set({
                        'id': id,
                        'nameEn': _nameEnController.text,
                        'nameAr': 'nameAr',
                        'category': category,
                        'descriptionAr': 'descriptionAr',
                        'descriptionEn': _descriptionEnController.text,
                        'isPublished': true,
                        'image': _imageController.text,
                        'price': _priceController.text,
                        'rate': 0,
                        'weight': 0,
                        //subCategory: ---
                      }).whenComplete(() {
                        Navigator.of(context).pop();
                        _descriptionEnController.clear();
                        _priceController.clear();
                        _imageController.clear();
                        _nameEnController.clear();

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
                    _descriptionEnController.clear();
                    _priceController.clear();
                    _imageController.clear();
                    _nameEnController.clear();
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
