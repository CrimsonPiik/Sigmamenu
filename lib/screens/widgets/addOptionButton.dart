import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/GeneralFunction/firebase_uploader_web.dart';
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
  // String imageURL = 'assets/images/placeholder.jpg';
  // TextEditingController _nameBannerController = TextEditingController();
  // TextEditingController _categoryBannerController = TextEditingController();
  TextEditingController _imageBannerController = TextEditingController();
  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>('');
  final _formKey = GlobalKey<FormBuilderState>();
  // String category = categoriesList.elementAt(0);
  // bool error = false;

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

  void showDialogWithFields() {
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
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
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonUI.text(
                                        context: context,
                                        text: 'options',
                                        textAlign: TextAlign.center,
                                        style: FontStylee.normal(
                                            context: context,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    Row(
                                      children: [
                                        CommonUI.text(
                                            context: context,
                                            text: 'Example!',
                                            // .product
                                            // .options1[
                                            //     '${widget.product.options1.keys.elementAt(index)}']
                                            // .keys
                                            // .elementAt(index),
                                            textAlign: TextAlign.center,
                                            style: FontStylee.normal(
                                                context: context,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange[700])),
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
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 1, //TODO
                                itemBuilder: (context, indexx) {
                                  return Column(
                                    children: [
                                      Center(
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            height: 1,
                                            width: double.maxFinite),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CommonUI.text(
                                                  context: context,
                                                  text: 'options',
                                                  // .elementAt(index)
                                                  // .options[
                                                  //     '${options.elementAt(index).options.keys.first}']
                                                  // .keys
                                                  // .elementAt(indexx)
                                                  // .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: FontStylee.small(
                                                      context: context,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black
                                                          .withOpacity(0.8))),
                                              CommonUI.text(
                                                  context: context,
                                                  text: 'options' +
                                                      // .elementAt(index)
                                                      // .options[
                                                      //     '${options.elementAt(index).options.keys.first}']
                                                      // .values
                                                      // .elementAt(indexx)
                                                      // .toString() +
                                                      ' JOD',
                                                  textAlign: TextAlign.center,
                                                  style: FontStylee.small(
                                                      context: context,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black
                                                          .withOpacity(0.8))),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
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
              )),
        );
      },
    );
  }
}
