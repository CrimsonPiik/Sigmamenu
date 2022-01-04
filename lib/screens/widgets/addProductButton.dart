import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/GeneralFunction/firebase_uploader_web.dart';
import 'package:sigmamenu/GeneralFunction/random_id_generator.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

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
  TextEditingController _nameArController = TextEditingController();

  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionEnController = TextEditingController();
  TextEditingController _descriptionArController = TextEditingController();

  TextEditingController _imageController = TextEditingController();
  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>('');
  final _formKey = GlobalKey<FormBuilderState>();
  String category = categoriesList.elementAt(0);
  double _value = 50.0;
  bool showProgress = false;

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
        SizedBox(width: 19),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 40,
            child: TextButton.icon(
                onPressed: () {
                  _imagevalue.value = '';
                  showDialogWithFields();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text(
                  'Product  ',
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

// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====
// =====                                   ADD PRODUCT DIALOG                             =====
// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====

  void showDialogWithFields() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormBuilder(
            key: _formKey,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                AlertDialog(
                  scrollable: true,
                  // title: Text('Create Product',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold, color: Colors.black)),
                  content: Container(
                    width: Responsive.isDesktop(context) ? 700 : 600,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      // color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///////////////////////////////////////////////////////
                            ValueListenableBuilder(
                              valueListenable: _imagevalue,
                              builder: (context, dynamic value, Widget? child) {
                                return StatefulBuilder(
                                  builder: (context, state) => Center(
                                    child: Ink(
                                      width: 130,
                                      height: 130,
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
                                        },
                                        child: Center(
                                          child: Container(
                                            width: 130,
                                            height: 130,
                                            child: Stack(children: [
                                              _imagevalue.value != ''
                                                  ? Stack(
                                                      //There's Image
                                                      children: [
                                                        Container(
                                                          height: 130,
                                                          width: 130,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child:
                                                              InteractiveViewer(
                                                            child:
                                                                Image.network(
                                                              value,
                                                              fit: BoxFit.cover,
                                                              loadingBuilder:
                                                                  (context,
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
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 95),
                                                          child: Container(
                                                              height: 35,
                                                              width: 130,
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
                                                      height: 130,
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 2,
                                                            blurRadius: 9,
                                                            offset:
                                                                Offset(0, 4),
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
                                                              color:
                                                                  Colors.black,
                                                              size: 60,
                                                            )),
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
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
                            name: "Name in Arabic (Optional)",
                            hint: "Name in Arabic (Optional)",
                            isEdit: true,
                            minlines: 1,
                            controller: _nameArController,
                            // validate: FormBuilderValidators.compose([
                            //   FormBuilderValidators.required(context),
                            // ]),
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
                        Center(
                          child: Text(
                            "Value ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.orange[300]),
                          ),
                        ),
                        SizedBox(height: 4),
                        StatefulBuilder(
                          builder: (context, state) => Center(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.orange[700],
                                inactiveTrackColor: Colors.orange[100],
                                trackShape: RectangularSliderTrackShape(),
                                trackHeight: 4.0,
                                thumbColor: Colors.orange[300],
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                overlayColor: Colors.orange.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
                              ),
                              child: Slider(
                                value: _value,
                                min: 1.0,
                                max: 101.0,
                                divisions: 2,
                                onChanged: (value) {
                                  state(() {
                                    _value = value + 1;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          child: CommonUI.textField(
                            context: context,
                            name: "Description",
                            hint: "Description",
                            maxlength: 350,
                            minlines: 2,
                            controller: _descriptionEnController,
                            validate: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          child: CommonUI.textField(
                            context: context,
                            name: "Description in Arabic (Optional)",
                            hint: "Description in Arabic (Optional)",
                            maxlength: 350,
                            minlines: 2,
                            controller: _descriptionArController,
                            // validate: FormBuilderValidators.compose([
                            //   FormBuilderValidators.required(context),
                            // ]),
                          ),
                        ),
                      ],
                    ),
                  ),

                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showProgress = false;
                              });
                              id = generateId();
                              _imagevalue.value = _imageController.text;
                              _descriptionEnController.clear();
                              _descriptionArController.clear();
                              _priceController.clear();
                              _imageController.clear();
                              _nameEnController.clear();
                              _nameArController.clear();

                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
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
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                await FirebaseFirestore.instance
                                    .collection(category)
                                    .doc(id)
                                    .set({
                                  'id': id,
                                  'nameEn': _nameEnController.text,
                                  'nameAr': _nameArController.text == ''
                                      ? _nameEnController.text
                                      : _nameArController.text,
                                  'category': category,
                                  'descriptionAr':
                                      _descriptionArController.text == ''
                                          ? _descriptionEnController.text
                                          : _descriptionArController.text,
                                  'descriptionEn':
                                      _descriptionEnController.text,
                                  'isPublished': true,
                                  'image': _imagevalue.value == ''
                                      ? 'assets/images/preview.png'
                                      : _imagevalue.value,
                                  'price': _priceController.text,
                                  'rate': 0,
                                  'weight': _value.round(),
                                  'options1': {},
                                  'options2': {},
                                  'options3': {},

                                  //subCategory: ---
                                }).whenComplete(() {
                                  id = generateId();
                                  _imagevalue.value = _imageController.text;
                                  _descriptionEnController.clear();
                                  _descriptionArController.clear();
                                  _priceController.clear();
                                  _imageController.clear();
                                  _nameEnController.clear();
                                  _nameArController.clear();

                                  Navigator.pop(context);

                                  CommonUI.successDialog(context,
                                      message: "Added Successfully");
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
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
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
                Positioned(
                    top: -10,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 40,
                      child: Icon(
                        Icons.photo,
                        color: Colors.white,
                        size: 45,
                      ),
                    )),
              ],
            ),
          );
        });
  }
}
