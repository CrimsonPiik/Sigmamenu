import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sigmamenu/GeneralFunction/firebase_uploader_web.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/style/AssetsManager.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class ProductsItemAdmin extends StatefulWidget {
  final Product data;
  ProductsItemAdmin(this.data);

  @override
  State<ProductsItemAdmin> createState() => _ProductsItemAdminState();
}

class _ProductsItemAdminState extends State<ProductsItemAdmin> {
  late TextEditingController _nameEnController =
      TextEditingController(text: _name);
  late TextEditingController _nameArController =
      TextEditingController(text: _nameAr);
  late TextEditingController _descriptionEnController =
      TextEditingController(text: _description);
  late TextEditingController _descriptionArController =
      TextEditingController(text: _descriptionAr);
  late TextEditingController _priceController =
      TextEditingController(text: _price.toString());
  late TextEditingController _imageController =
      TextEditingController(text: _image);
  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>(null);
  final _formKey = GlobalKey<FormBuilderState>();
  // bool en = true;

  late String _name;
  late String _nameAr;

  late String _description;
  late String _descriptionAr;

  late double _price;
  late String _image;
  late double _value; //= widget.data.weight.toDouble();

  @override
  void initState() {
    _name = widget.data.nameEn;
    _nameAr = widget.data.nameAr;
    _description = widget.data.descriptionEn;
    _descriptionAr = widget.data.descriptionAr;

    _price = widget.data.price;
    _image = widget.data.image;
    _value = widget.data.weight.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) async {
              widget.data.weight >= 1
                  ? await FirebaseFirestore.instance
                      .collection(widget.data.category)
                      .doc(widget.data.id)
                      .update({'weight': 0})
                  : await FirebaseFirestore.instance
                      .collection(widget.data.category)
                      .doc(widget.data.id)
                      .update({'weight': 1});
            },
            backgroundColor:
                widget.data.weight >= 1 ? Colors.red : Colors.green,
            foregroundColor: Colors.white,
            icon: widget.data.weight >= 1 ? Icons.toggle_off : Icons.toggle_on,
            label: widget.data.weight >= 1 ? "Unpublish" : "Publish",
            autoClose: true,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              setState(() {
                _nameEnController =
                    TextEditingController(text: widget.data.nameEn);
                _nameArController =
                    TextEditingController(text: widget.data.nameAr);
                _descriptionEnController =
                    TextEditingController(text: widget.data.descriptionEn);
                _descriptionArController =
                    TextEditingController(text: widget.data.descriptionAr);
                _priceController =
                    TextEditingController(text: widget.data.price.toString());
                _imageController =
                    TextEditingController(text: widget.data.image);
                _value = widget.data.weight.toDouble();
              });
              _showEditDialog(context);
            },
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            autoClose: true,
          ),
          SlidableAction(
            // flex: 2,
            onPressed: (context) {
              _showDeleteDialog(context);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            autoClose: true,
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: InkWell(
        onTap: () {
          _animationDialog(context);
        },
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(top: 8, left: 16, right: 8, bottom: 8),
                // margin: EdgeInsets.only(bottom: 20),
                // decoration: BoxDecoration(
                //   color: Colors.grey.withOpacity(0.1),
                //   borderRadius: BorderRadius.circular(12),
                // ),
                child: Row(
                  children: [
                    Container(
                        width: 120,
                        // height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CommonUI.cachedImage(
                            widget.data.image, ImageAssets.placeholder,
                            fit: BoxFit.cover)),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data.nameEn,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Responsive.isMiniMobile(context)
                                      ? 12
                                      : 14),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text('JOD ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            Responsive.isMiniMobile(context)
                                                ? 12
                                                : 14,
                                        color: Colors.black)),
                                Text(widget.data.price.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            Responsive.isMiniMobile(context)
                                                ? 12
                                                : 14,
                                        color: Colors.red)),
                              ],
                            ),
                            SizedBox(
                              height: Responsive.isMiniMobile(context) ? 8 : 16,
                            ),
                            Text(
                              widget.data.descriptionEn,
                              overflow: TextOverflow.ellipsis,
                              maxLines:
                                  Responsive.isMiniMobile(context) ? 2 : 3,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              width: 10,
              // padding: EdgeInsets.all(16),
              // margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: widget.data.weight >= 1 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====
// =====                                    DELETE                                        =====
// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====

  _showDeleteDialog(BuildContext context) {
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
                Container(
                  height: 220,
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
                            'Are you sure you want to delete this product ?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMiniMobile(context) ? 12 : 17),
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
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
                            SizedBox(width: 15),
                            ElevatedButton(
                              onPressed: () async {
                                FirebaseFirestore.instance
                                    .collection(widget.data.category)
                                    .doc(widget.data.id)
                                    .delete();
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.redAccent),
                              ),
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
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
                      backgroundColor: Colors.redAccent,
                      radius: 50,
                      child: Icon(
                        Icons.delete,
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
// =====                                    EDIT                                          =====
// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====

  _showEditDialog(BuildContext context) {
    // bool en = true;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
            child: FormBuilder(
              key: _formKey,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Container(
                          width: Responsive.isDesktop(context) ? 350 : 290,
                          padding: EdgeInsets.all(16),
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
                                                  widget.data.id);
                                          _imagevalue.value =
                                              _imageController.text;
                                          // if (_imageController.text != '') {
                                          //   _imagevalue.value =
                                          //       _imageController.text;
                                          // }
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
                                                        child:
                                                            InteractiveViewer(
                                                          child: Image.network(
                                                            value,
                                                            fit:
                                                                BoxFit.fitWidth,
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
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0x4D303030)),
                                                        height: 130,
                                                        width: 130,
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
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Edit ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Icon(Icons.edit,
                                                                    color: Colors
                                                                        .white)
                                                              ],
                                                            )),
                                                      ),
                                                    ])
                                                  : Stack(children: [
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
                                                          child: CommonUI
                                                              .cachedImage(
                                                                  widget.data
                                                                      .image,
                                                                  ImageAssets
                                                                      .placeholder,
                                                                  fit: BoxFit
                                                                      .fitWidth)),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0x4D303030)),
                                                        height: 130,
                                                        width: 130,
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
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Edit ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Icon(Icons.edit,
                                                                    color: Colors
                                                                        .white)
                                                              ],
                                                            )),
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
                              widget.data.weight != 0
                                  ? Column(
                                      children: [
                                        SizedBox(height: 4),
                                        Text(
                                          "Value ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.brown[400]),
                                        ),
                                        SizedBox(height: 4),
                                        StatefulBuilder(
                                          builder: (context, state) => Center(
                                            child: SliderTheme(
                                              data: SliderTheme.of(context)
                                                  .copyWith(
                                                activeTrackColor:
                                                    Colors.brown[700],
                                                inactiveTrackColor:
                                                    Colors.brown[100],
                                                trackShape:
                                                    RectangularSliderTrackShape(),
                                                trackHeight: 4.0,
                                                thumbColor: Colors.brown[400],
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                        enabledThumbRadius:
                                                            12.0),
                                                overlayColor:
                                                    Colors.brown.withAlpha(32),
                                                overlayShape:
                                                    RoundSliderOverlayShape(
                                                        overlayRadius: 28.0),
                                              ),
                                              child: Slider(
                                                value: _value,
                                                min: 1.0,
                                                max: 101.0,
                                                divisions: 2,
                                                onChanged: (value) {
                                                  state(() {
                                                    _value = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
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
                              SizedBox(height: 4),
                              Container(
                                child: CommonUI.textField(
                                  context: context,
                                  name: "Arabic Description (Optional)",
                                  hint: "Arabic Description (Optional)",
                                  maxlength: 600,
                                  minlines: 2,
                                  controller: _descriptionArController,
                                  // validate: FormBuilderValidators.compose([
                                  //   FormBuilderValidators.required(context),
                                  // ]),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _nameEnController =
                                            TextEditingController(
                                                text: widget.data.nameEn);
                                        _descriptionEnController =
                                            TextEditingController(
                                                text:
                                                    widget.data.descriptionEn);
                                        _priceController =
                                            TextEditingController(
                                                text: widget.data.price
                                                    .toString());
                                        _imageController =
                                            TextEditingController(
                                                text: widget.data.image);
                                      });

                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  ElevatedButton(
                                    onPressed: () async {
                                      _formKey.currentState!.save();
                                      if (_formKey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                        await FirebaseFirestore.instance
                                            .collection(widget.data.category)
                                            .doc(widget.data.id)
                                            .update({
                                          'nameEn': _nameEnController.text,
                                          'nameAr': _nameArController.text,
                                          'descriptionEn':
                                              _descriptionEnController.text,
                                          'descriptionAr':
                                              _descriptionArController.text,
                                          'price': _priceController.text,
                                          'image': _imageController.text,
                                          'weight': _value
                                        }).whenComplete(() {
                                          Navigator.of(context).pop();

                                          CommonUI.successDialog(context,
                                              message: "Saved successfully");
                                        }).onError((error, stackTrrace) =>
                                                showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          error.toString()),
                                                    );
                                                  },
                                                ));
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blueAccent),
                                    ),
                                    child: Text(
                                      'Save',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: -60,
                        child: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: 40,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 45,
                          ),
                        )),
                    // Positioned(
                    // bottom: -20,
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           _nameEnController = TextEditingController(
                    //               text: widget.data.nameEn);
                    //           _descriptionEnController =
                    //               TextEditingController(
                    //                   text: widget.data.descriptionEn);
                    //           _priceController = TextEditingController(
                    //               text: widget.data.price.toString());
                    //           _imageController = TextEditingController(
                    //               text: widget.data.image);
                    //         });

                    //         Navigator.of(context).pop();
                    //       },
                    //       style: ButtonStyle(
                    //         backgroundColor:
                    //             MaterialStateProperty.all(Colors.white),
                    //       ),
                    //       child: Text(
                    //         'Cancel',
                    //         style: TextStyle(color: Colors.black),
                    //       ),
                    //     ),
                    //     SizedBox(width: 15),
                    //     ElevatedButton(
                    //       onPressed: () async {
                    //         _formKey.currentState!.save();
                    //         if (_formKey.currentState!.validate()) {
                    //           FocusScope.of(context).unfocus();
                    //           await FirebaseFirestore.instance
                    //               .collection(widget.data.category)
                    //               .doc(widget.data.id)
                    //               .update({
                    //             'nameEn': _nameEnController.text,
                    //             'nameAr': _nameArController.text,
                    //             'descriptionEn':
                    //                 _descriptionEnController.text,
                    //             'descriptionAr':
                    //                 _descriptionArController.text,
                    //             'price': _priceController.text,
                    //             'image': _imageController.text,
                    //             'weight': _value
                    //           }).whenComplete(() {
                    //             Navigator.of(context).pop();

                    //             CommonUI.successDialog(context,
                    //                 message: "Saved successfully");
                    //           }).onError((error, stackTrrace) => showDialog(
                    //                     context: context,
                    //                     builder: (_) {
                    //                       return AlertDialog(
                    //                         content: Text(error.toString()),
                    //                       );
                    //                     },
                    //                   ));
                    //         }
                    //       },
                    //       style: ButtonStyle(
                    //         backgroundColor:
                    //             MaterialStateProperty.all(Colors.blueAccent),
                    //       ),
                    //       child: Text(
                    //         'Save',
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  bool _fromTop = false;
  _animationDialog(context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Product Animation",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 600),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Dismissible(
          direction: DismissDirection.down,
          onDismissed: (_) {
            Navigator.of(context).pop();
          },
          key: Key("key"),
          child: SafeArea(
            child: SizedBox.expand(
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: Responsive.isDesktop(context)
                                  ? Responsive.width(context) / 2
                                  : Responsive.width(context),
                              padding: EdgeInsets.only(
                                  left: kDefaultPaddin * 1.5,
                                  right: kDefaultPaddin * 1.5,
                                  bottom: kDefaultPaddin),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: kDefaultPaddin * 2,
                                        ),
                                        child: Hero(
                                          tag: "${widget.data.id}",
                                          child: Image.network(
                                            widget.data.image,
                                            width: 130,
                                            height: 130,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 24),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            ProjectLanguage.isLTR()
                                                ? widget.data.nameEn
                                                : widget.data.nameAr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Responsive.isMiniMobile(
                                                              context)
                                                          ? 16
                                                          : 19,
                                                ),
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(height: 6),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(text: "Price\n"),
                                                TextSpan(
                                                  text:
                                                      "\$${widget.data.price}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Responsive.isDesktop(context)
                                              ? Responsive.width(context) / 2.2
                                              : Responsive.width(context) /
                                                  1.35,
                                          child: Text(
                                            "Description",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Responsive.isMiniMobile(
                                                              context)
                                                          ? 16
                                                          : 19,
                                                ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          width: Responsive.isDesktop(context)
                                              ? Responsive.width(context) / 2.2
                                              : Responsive.width(context) /
                                                  1.35,
                                          child: Text(
                                            ProjectLanguage.isLTR()
                                                ? "${widget.data.descriptionEn}"
                                                : "${widget.data.descriptionAr}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontSize:
                                                      Responsive.isMiniMobile(
                                                              context)
                                                          ? 10
                                                          : 12,
                                                ),
                                          ),
                                        ),
                                        SizedBox(height: 300),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                        top: -30,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 30,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, _fromTop ? -1 : 1), end: Offset(0, 0.4))
                  .animate(anim1),
          child: child,
        );
      },
    );
  }
}
