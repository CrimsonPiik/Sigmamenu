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
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionEnController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>('');
  final _formKey = GlobalKey<FormBuilderState>();
  String category = categoriesList.elementAt(0);
  double _value = 50.0;
  bool isImage = false;

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
                    width: Responsive.isDesktop(context) ? 350 : 290,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      // color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ValueListenableBuilder(
                            //   valueListenable: _imagevalue,
                            //   builder: (context, dynamic value, Widget? child) {
                            //     return Center(
                            //       child: Ink(
                            //         width: 130,
                            //         height: 130,
                            //         child: InkWell(
                            //           onTap: () async {
                            //             _imageController.text =
                            //                 await fireBaseUploadFileWeb(id);
                            //             if (_imageController.text != '') {
                            //               _imagevalue.value =
                            //                   _imageController.text;
                            //             } else if (_imageController.text ==
                            //                 '') {
                            //               _imagevalue.value =
                            //                   'assets/images/placeholder.jpg';
                            //             }
                            //             // _imagevalue.value =
                            //             // _imageController.text;
                            //           },
                            //           child: Center(
                            //             child: Container(
                            //               width: 130,
                            //               height: 130,
                            //               child: Stack(children: [
                            //                 _imagevalue.value != null
                            //                     ? Container(
                            //                         height: 130,
                            //                         width: 130,
                            //                         decoration: BoxDecoration(
                            //                           borderRadius:
                            //                               BorderRadius.circular(
                            //                                   4),
                            //                         ),
                            //                         child: InteractiveViewer(
                            //                           child: Image.network(
                            //                             value,
                            //                             fit: BoxFit.cover,
                            //                             loadingBuilder: (context,
                            //                                 child,
                            //                                 loadingProgress) {
                            //                               if (loadingProgress ==
                            //                                   null) {
                            //                                 return child;
                            //                               }
                            //                               return Center(
                            //                                 child:
                            //                                     CircularProgressIndicator(),
                            //                               );
                            //                             },
                            //                           ),
                            //                         ),
                            //                       )
                            //                     : Container(
                            //                         height: 130,
                            //                         width: 130,
                            //                         decoration: BoxDecoration(
                            //                           borderRadius:
                            //                               BorderRadius.circular(
                            //                                   4),
                            //                         ),
                            //                         child: Image.asset(
                            //                           'assets/images/placeholder.jpg',
                            //                           fit: BoxFit.cover,
                            //                         ),
                            //                       ),
                            //                 Container(
                            //                   decoration: BoxDecoration(
                            //                       color: Color(0x4D303030)),
                            //                   height: 130,
                            //                   width: 130,
                            //                 ),
                            //                 Padding(
                            //                   padding: EdgeInsets.only(top: 95),
                            //                   child: Container(
                            //                       height: 35,
                            //                       width: 130,
                            //                       decoration: BoxDecoration(
                            //                           color: Color(0x4D000000)),
                            //                       child: Center(
                            //                           child: Icon(Icons.add,
                            //                               color:
                            //                                   Colors.white))),
                            //                 ),
                            //               ]),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                            ///////////////////////////////////////////////////////
                            SizedBox(width: 20),
                            ValueListenableBuilder(
                              valueListenable: _imagevalue,
                              builder: (context, dynamic value, Widget? child) {
                                return Center(
                                  child: Ink(
                                    width: 130,
                                    height: 130,
                                    child: InkWell(
                                      onTap: () async {
                                        _imagevalue.value =
                                            await fireBaseUploadFileWeb(id);
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
                                                                  .circular(4),
                                                        ),
                                                        child:
                                                            InteractiveViewer(
                                                          child: Image.network(
                                                            value,
                                                            fit: BoxFit.cover,
                                                            loadingBuilder:
                                                                (context, child,
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
                                                          BorderRadius.circular(
                                                              4),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 9,
                                                          offset: Offset(0, 4),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                      size: 60,
                                                    )),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
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
                        Center(
                          child: Text(
                            "Value ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.brown[400]),
                          ),
                        ),
                        SizedBox(height: 4),
                        StatefulBuilder(
                          builder: (context, state) => Center(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.brown[700],
                                inactiveTrackColor: Colors.brown[100],
                                trackShape: RectangularSliderTrackShape(),
                                trackHeight: 4.0,
                                thumbColor: Colors.brown[400],
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                overlayColor: Colors.brown.withAlpha(32),
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
                            maxlength: 600,
                            minlines: 2,
                            controller: _descriptionEnController,
                            validate: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                        )
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
                              id = generateId();
                              _imagevalue.value = _imageController.text;
                              _descriptionEnController.clear();
                              _priceController.clear();
                              _imageController.clear();
                              _nameEnController.clear();
                              Navigator.of(context).pop();
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
                                    .collection(category)
                                    .doc(id)
                                    .set({
                                  'id': id,
                                  'nameEn': _nameEnController.text,
                                  'nameAr': 'nameAr',
                                  'category': category,
                                  'descriptionAr': 'descriptionAr',
                                  'descriptionEn':
                                      _descriptionEnController.text,
                                  'isPublished': true,
                                  'image': _imagevalue.value == ''
                                      ? 'assets/images/placeholder.jpg'
                                      : _imagevalue.value,
                                  'price': _priceController.text,
                                  'rate': 0,
                                  'weight': _value.round(),
                                  //subCategory: ---
                                }).whenComplete(() {
                                  id = generateId();
                                  _imagevalue.value = _imageController.text;
                                  _descriptionEnController.clear();
                                  _priceController.clear();
                                  _imageController.clear();
                                  _nameEnController.clear();
                                  Navigator.of(context).pop();

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
                        Icons.add,
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
