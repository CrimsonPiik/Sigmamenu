import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/GeneralFunction/random_id_generator.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Style.dart';

class AddOptionButton extends StatefulWidget {
  @override
  State<AddOptionButton> createState() => _AddOptionButtonState();
}

class _AddOptionButtonState extends State<AddOptionButton> {
  String id = generateId();

  TextEditingController _optionNameController = TextEditingController();
  TextEditingController _optionOneKeyController = TextEditingController();
  TextEditingController _optionOneValueController = TextEditingController();

  TextEditingController _optionTwoKeyController = TextEditingController();
  TextEditingController _optionTwoValueController = TextEditingController();

  TextEditingController _optionThreeKeyController = TextEditingController();
  TextEditingController _optionThreeValueController = TextEditingController();

  TextEditingController _optionFourKeyController = TextEditingController();
  TextEditingController _optionFourValueController = TextEditingController();

  TextEditingController _optionFiveKeyController = TextEditingController();
  TextEditingController _optionFiveValueController = TextEditingController();

  TextEditingController _optionSixKeyController = TextEditingController();
  TextEditingController _optionSixValueController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 21),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 40,
            child: TextButton.icon(
                onPressed: () {
                  showDialogWithFields();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text(
                  'Option ',
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

  bool added = false;

  void showDialogWithFields() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FormBuilder(
              key: _formKey,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    content: Container(
                      width: Responsive.isDesktop(context) ? 350 : 290,
                      padding: EdgeInsets.all(20.0),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: Offset(1, 6),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // CommonUI.text(
                                    //     context: context,
                                    //     text: 'options',
                                    //     textAlign: TextAlign.center,
                                    //     style: FontStylee.normal(
                                    //         context: context,
                                    //         fontWeight: FontWeight.bold,
                                    //         color: Colors.black)),
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        child: CommonUI.smallertextField(
                                          context: context,
                                          name: "Options",
                                          hint: "Options",
                                          // isEdit: true,
                                          minlines: 1,
                                          controller: _optionNameController,
                                          validate:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(
                                                context),
                                          ]),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 15,
                                          color: Colors.orange[700],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    height: 1,
                                    width: double.maxFinite,
                                  ),
                                ),

                                Column(
                                  children: [
                                    Center(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          height: 1,
                                          width: double.maxFinite),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 50,
                                              child: CommonUI.smallertextField(
                                                context: context,
                                                name: "Key",
                                                hint: "Key",
                                                minlines: 1,
                                                controller:
                                                    _optionOneKeyController,
                                                validate: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(context),
                                                ]),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              height: 50,
                                              child: CommonUI.smallertextField(
                                                context: context,
                                                name: "Value",
                                                hint: "Value",
                                                minlines: 1,
                                                controller:
                                                    _optionOneValueController,
                                                validate: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators
                                                      .required(context),
                                                ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    added
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  child:
                                                      CommonUI.smallertextField(
                                                    context: context,
                                                    name: "Key (Optional)",
                                                    hint: "Key (Optional)",
                                                    minlines: 1,
                                                    controller:
                                                        _optionTwoKeyController,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  child:
                                                      CommonUI.smallertextField(
                                                    context: context,
                                                    name: "Value (Optional)",
                                                    hint: "Value (Optional)",
                                                    minlines: 1,
                                                    controller:
                                                        _optionTwoValueController,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          added = true;
                                        });
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 20,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 50,
                                    //         child: CommonUI.smallertextField(
                                    //           context: context,
                                    //           name: "Key (Optional)",
                                    //           hint: "Key (Optional)",
                                    //           minlines: 1,
                                    //           controller:
                                    //               _optionThreeKeyController,

                                    //         ),
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: 10),
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 50,
                                    //         child: CommonUI.smallertextField(
                                    //           context: context,
                                    //           name: "Value (Optional)",
                                    //           hint: "Value (Optional)",
                                    //           minlines: 1,
                                    //           controller:
                                    //               _optionThreeValueController,

                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 50,
                                    //         child: CommonUI.smallertextField(
                                    //           context: context,
                                    //           name: "Key (Optional)",
                                    //           hint: "Key (Optional)",
                                    //           minlines: 1,
                                    //           controller:
                                    //               _optionFourKeyController,

                                    //         ),
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: 10),
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 50,
                                    //         child: CommonUI.smallertextField(
                                    //           context: context,
                                    //           name: "Value (Optional)",
                                    //           hint: "Value (Optional)",
                                    //           minlines: 1,
                                    //           controller:
                                    //               _optionFourValueController,

                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 50,
                                    //         child: CommonUI.smallertextField(
                                    //           context: context,
                                    //           name: "Key (Optional)",
                                    //           hint: "Key (Optional)",
                                    //           minlines: 1,
                                    //           controller:
                                    //               _optionFiveKeyController,

                                    //         ),
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: 10),
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 50,
                                    //         child: CommonUI.smallertextField(
                                    //           context: context,
                                    //           name: "Value (Optional)",
                                    //           hint: "Value (Optional)",
                                    //           minlines: 1,
                                    //           controller:
                                    //               _optionFiveValueController,

                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 50,
                                    //         child: CommonUI.smallertextField(
                                    //           context: context,
                                    //           name: "Key (Optional)",
                                    //           hint: "Key (Optional)",
                                    //           minlines: 1,
                                    //           controller:
                                    //               _optionSixKeyController,

                                    //         ),
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: 10),
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 50,
                                    //         child: CommonUI.smallertextField(
                                    //           context: context,
                                    //           name: "Value (Optional)",
                                    //           hint: "Value (Optional)",
                                    //           minlines: 1,
                                    //           controller:
                                    //               _optionSixValueController,

                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                )
                                // },
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // id = generateId();
                              // _imagevalue.value =
                              //     _imageBannerController.text;

                              // _imageBannerController.clear();
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
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                await FirebaseFirestore.instance
                                    .collection('options')
                                    .doc(id)
                                    .set({
                                  'id': id,
                                  'options': {
                                    _optionNameController.text: {
                                      _optionOneKeyController.text:
                                          _optionOneValueController.text,
                                      _optionTwoKeyController.text:
                                          _optionTwoValueController.text,
                                    }
                                  },
                                }).whenComplete(() {
                                  id = generateId();
                                  _optionNameController.clear();
                                  _optionOneKeyController.clear();
                                  _optionOneValueController.clear();
                                  _optionTwoKeyController.clear();
                                  _optionTwoValueController.clear();

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
                    ],
                  ),
                  // Positioned(
                  //     top: 180,
                  //     child: CircleAvatar(
                  //       backgroundColor: Colors.green,
                  //       radius: 30,
                  //       child: Icon(
                  //         Icons.add,
                  //         color: Colors.white,
                  //         size: 30,
                  //       ),
                  //     )),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
