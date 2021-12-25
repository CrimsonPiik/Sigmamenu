import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/GeneralFunction/firebase_uploader_web.dart';
import 'package:sigmamenu/style/AssetsManager.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class DashBoardTileAdmin extends StatefulWidget {
  final String image;
  final String text;
  final String routeName;
  final String id;
  final String name;
  final String nameAr;
  final String route;
  final String superCategory;

  final bool isPublished;

  DashBoardTileAdmin(
      {required this.id,
      required this.name,
      required this.nameAr,
      required this.route,
      required this.superCategory,
      required this.isPublished,
      required this.image,
      required this.text,
      required this.routeName});

  @override
  State<DashBoardTileAdmin> createState() => _DashBoardTileAdminState();
}

class _DashBoardTileAdminState extends State<DashBoardTileAdmin> {
  late TextEditingController _nameController =
      TextEditingController(text: _name);
  late TextEditingController _nameArController =
      TextEditingController(text: _nameAr);
  late TextEditingController _routeController =
      TextEditingController(text: _route);
  late TextEditingController _superCategoryController =
      TextEditingController(text: _superCategory);
  late TextEditingController _imageController =
      TextEditingController(text: _image);
  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>('');

  final _formKey = GlobalKey<FormBuilderState>();

  late String _name;
  late String _nameAr;

  late String _route;
  late String _superCategory;
  late String _image;

  @override
  void initState() {
    _name = widget.name;
    _nameAr = widget.nameAr;
    _route = widget.route;
    _superCategory = widget.superCategory;
    _image = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: <Widget>[
        Center(
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.image), fit: BoxFit.cover),
              )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(color: Color(0x4D303030)),
                    child: Center(
                        child: Text(
                      widget.text, // .toCapitalized(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            widget.isPublished == true
                                ? await FirebaseFirestore.instance
                                    .collection('dashboard')
                                    .doc(widget.id)
                                    .update({'isPublished': false})
                                : await FirebaseFirestore.instance
                                    .collection('dashboard')
                                    .doc(widget.id)
                                    .update({'isPublished': true});
                          },
                          child: CircleAvatar(
                            backgroundColor: widget.isPublished == true
                                ? Colors.green
                                : Colors.red,
                            child: Icon(
                              widget.isPublished == true
                                  ? Icons.toggle_on_outlined
                                  : Icons.toggle_off_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 14),
                        GestureDetector(
                          onTap: () {
                            _showEditDialog(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 14),
                        GestureDetector(
                          onTap: () {
                            _showDeleteCategoryDialog();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.delete_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    )));
  }

// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====
// =====                                    DELETE                                        =====
// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====

  _showDeleteCategoryDialog() {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
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
                            'Delete',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Responsive.isMiniMobile(context) ? 15 : 20),
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.fromLTRB(24, 1, 24, 16),
                            child: Text(
                              'Are you sure you want to delete ${widget.name.toLowerCase()} from dashboard ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Responsive.isMiniMobile(context)
                                      ? 12
                                      : 17),
                            ),
                          ),
                          SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
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
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('dashboard')
                                        .doc(widget.id)
                                        .delete();

                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.redAccent),
                                  ),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: -60,
                    child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 50,
                      child: Icon(
                        Icons.delete_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    )),
              ],
            ));
      },
    );
  }

// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====
// =====                                    EDIT PRODUCT DIALOG                           =====
// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====

  _showEditDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
            child: FormBuilder(
              key: _formKey,
              // child: Dialog(
              // shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(4.0)),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  AlertDialog(
                    scrollable: true,
                    content: Container(
                      width: Responsive.isDesktop(context) ? 350 : 290,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _imagevalue,
                            builder: (BuildContext context, dynamic value,
                                Widget? child) {
                              return Center(
                                child: Ink(
                                  width: 130,
                                  height: 130,
                                  child: InkWell(
                                    onTap: () async {
                                      _imageController.text =
                                          await fireBaseUploadFileWeb(
                                              widget.id);

                                      print("Controlller " +
                                          _imageController.text);
                                      print("Value  " +
                                          _imagevalue.value.toString());

                                      if (_imageController.text != '') {
                                        _imagevalue.value =
                                            _imageController.text;
                                      } else if (_imageController.text == '') {
                                        _imagevalue.value = widget.image;
                                      }
                                    },
                                    child: Center(
                                      child: Container(
                                        height: 130,
                                        width: 130,
                                        child: Column(children: [
                                          _imagevalue.value != null
                                              ? Stack(children: [
                                                  Container(
                                                    height: 130,
                                                    width: 130,
                                                    child: InteractiveViewer(
                                                      child: Image.network(
                                                        value,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder: (context,
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
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0x4D303030)),
                                                    height: 130,
                                                    width: 130,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 95),
                                                    child: Container(
                                                        height: 35,
                                                        width: 130,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0x4D000000)),
                                                        child: Icon(
                                                            Icons.camera_alt,
                                                            color:
                                                                Colors.white)),
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .center,
                                                    //   children: [
                                                    //     Text(
                                                    //       'Edit ',
                                                    //       style: TextStyle(
                                                    //           color: Colors
                                                    //               .white),
                                                    //     ),
                                                    //     Icon(Icons.edit,
                                                    //         color: Colors
                                                    //             .white)
                                                    //   ],
                                                    // )),
                                                  ),
                                                ])
                                              : Stack(children: [
                                                  Container(
                                                      height: 130,
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child:
                                                          CommonUI.cachedImage(
                                                              widget.image,
                                                              ImageAssets
                                                                  .placeholder,
                                                              fit: BoxFit
                                                                  .cover)),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0x4D303030)),
                                                    height: 130,
                                                    width: 130,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 95),
                                                    child: Container(
                                                        height: 35,
                                                        width: 130,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0x4D000000)),
                                                        child: Icon(
                                                            Icons.camera_alt,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ]),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: CommonUI.textField(
                              context: context,
                              name: "Name",
                              hint: "Name",
                              isEdit: true,
                              minlines: 1,
                              controller: _nameController,
                              validate: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                          ),

                          // ),

                          SizedBox(height: 4),
                          Container(
                            child: CommonUI.textField(
                              context: context,
                              name: "Arabic Name (Optional)",
                              hint: "Arabic Name (Optional)",
                              isEdit: true,
                              minlines: 1,
                              controller: _nameArController,
                              // validate: FormBuilderValidators.compose([
                              //   FormBuilderValidators.required(context),
                              // ]),
                            ),
                          ),
                          SizedBox(height: 4),
                          // Container(
                          //   child: CommonUI.textField(
                          //     context: context,
                          //     name: "price",
                          //     hint: "Price",
                          //     isEdit: true,
                          //     keyboardtype: TextInputType.number,
                          //     controller: _priceController,
                          //     validate: FormBuilderValidators.compose([
                          //       FormBuilderValidators.required(context),
                          //       FormBuilderValidators.numeric(context),
                          //     ]),
                          //   ),
                          // ),
                          // widget.weight != 0
                          //     ? Column(
                          //         children: [
                          //           SizedBox(height: 4),
                          //           Text(
                          //             "Value ",
                          //             style: TextStyle(
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 12,
                          //                 color: Colors.brown[400]),
                          //           ),
                          //           SizedBox(height: 4),
                          //           StatefulBuilder(
                          //             builder: (context, state) => Center(
                          //               child: SliderTheme(
                          //                 data:
                          //                     SliderTheme.of(context).copyWith(
                          //                   activeTrackColor: Colors.brown[700],
                          //                   inactiveTrackColor:
                          //                       Colors.brown[100],
                          //                   trackShape:
                          //                       RectangularSliderTrackShape(),
                          //                   trackHeight: 4.0,
                          //                   thumbColor: Colors.brown[400],
                          //                   thumbShape: RoundSliderThumbShape(
                          //                       enabledThumbRadius: 12.0),
                          //                   overlayColor:
                          //                       Colors.brown.withAlpha(32),
                          //                   overlayShape:
                          //                       RoundSliderOverlayShape(
                          //                           overlayRadius: 28.0),
                          //                 ),
                          //                 child: Slider(
                          //                   value: _value,
                          //                   min: 1.0,
                          //                   max: 101.0,
                          //                   divisions: 2,
                          //                   onChanged: (value) {
                          //                     state(() {
                          //                       _value = value;
                          //                     });
                          //                   },
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       )
                          //     : Container(),
                          // SizedBox(height: 4),
                          Container(
                            child: CommonUI.textField(
                              context: context,
                              name: "Route",
                              hint: "Route",
                              isEdit: true,
                              minlines: 1,
                              controller: _routeController,
                              validate: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            child: CommonUI.textField(
                              context: context,
                              name: "Super Category",
                              hint: "Super Category",
                              isEdit: true,
                              minlines: 1,
                              controller: _superCategoryController,
                              validate: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
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
                                  _nameController =
                                      TextEditingController(text: widget.name);

                                  _nameArController = TextEditingController(
                                      text: widget.nameAr);
                                  _superCategoryController =
                                      TextEditingController(
                                          text: widget.superCategory);
                                  _routeController =
                                      TextEditingController(text: widget.route);
                                  _imageController =
                                      TextEditingController(text: widget.image);
                                });
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
                                      .collection('dashboard')
                                      .doc(widget.id)
                                      .update({
                                    'name': _nameController.text,
                                    'nameAr': _nameArController.text,
                                    'route': _routeController.text,
                                    'superCategory':
                                        _superCategoryController.text,
                                    'image': _imageController.text,
                                  }).whenComplete(() {
                                    Navigator.pop(context);

                                    CommonUI.successDialog(context,
                                        message: "Saved Successfully");
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
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blueAccent),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      top: -30,
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 40,
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 45,
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
