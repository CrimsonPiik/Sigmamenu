import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sigmamenu/GeneralFunction/firebase_uploader_web.dart';
import 'package:sigmamenu/GeneralFunction/constaints.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/models/options.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/style/AssetsManager.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class ProductsItemAdmin extends StatefulWidget {
  final Product product;
  final List<OptionsModel> options;
  ProductsItemAdmin(this.product, this.options);

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
// _imageController.text

  late String _name;
  late String _nameAr;

  late String _description;
  late String _descriptionAr;

  late double _price;
  late String _image;
  late double _value; //= widget.product.weight.toDouble();

  @override
  void initState() {
    _name = widget.product.nameEn;
    _nameAr = widget.product.nameAr;
    _description = widget.product.descriptionEn;
    _descriptionAr = widget.product.descriptionAr;

    _price = widget.product.price;
    _image = widget.product.image;
    _value = widget.product.weight.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _imagevalue.value = widget.product.image;

    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) async {
              widget.product.weight >= 1
                  ? await FirebaseFirestore.instance
                      .collection(widget.product.category)
                      .doc(widget.product.id)
                      .update({'weight': 0})
                  : await FirebaseFirestore.instance
                      .collection(widget.product.category)
                      .doc(widget.product.id)
                      .update({'weight': 1});
            },
            backgroundColor:
                widget.product.weight >= 1 ? Colors.red : Colors.green,
            foregroundColor: Colors.white,
            icon: widget.product.weight >= 1
                ? Icons.toggle_off_outlined
                : Icons.toggle_on_outlined,
            label: widget.product.weight >= 1 ? "Unpublish" : "Publish",
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
                    TextEditingController(text: widget.product.nameEn);
                _nameArController =
                    TextEditingController(text: widget.product.nameAr);
                _descriptionEnController =
                    TextEditingController(text: widget.product.descriptionEn);
                _descriptionArController =
                    TextEditingController(text: widget.product.descriptionAr);
                _priceController = TextEditingController(
                    text: widget.product.price.toString());
                _imageController =
                    TextEditingController(text: widget.product.image);
                _value = widget.product.weight.toDouble();

                _imagevalue.value = widget.product.image;
              });
              _showEditDialog(context);
            },
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            icon: Icons.edit_outlined,
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
            icon: Icons.delete_outlined,

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
                // padding: EdgeInsets.only(top: 8, left: 16, right: 8, bottom: 8),
                child: Row(
              children: [
                Container(
                    width: 150,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CommonUI.cachedImage(
                        widget.product.image, ImageAssets.placeholder,
                        fit: BoxFit.cover)),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        widget.product.nameEn,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                Responsive.isMiniMobile(context) ? 12 : 14),
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
                                  fontSize: Responsive.isMiniMobile(context)
                                      ? 12
                                      : 14,
                                  color: Colors.black)),
                          Text(widget.product.price.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Responsive.isMiniMobile(context)
                                      ? 12
                                      : 14,
                                  color: Colors.red)),
                        ],
                      ),
                      SizedBox(
                        height: Responsive.isMiniMobile(context) ? 8 : 16,
                      ),
                      Text(
                        widget.product.descriptionEn,
                        overflow: TextOverflow.ellipsis,
                        maxLines: Responsive.isMiniMobile(context) ? 2 : 3,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            Container(
              width: 10,
              // padding: EdgeInsets.all(16),
              // margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: widget.product.weight >= 1 ? Colors.green : Colors.red,
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
                              'Are you sure you want to delete this product ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Responsive.isMiniMobile(context)
                                      ? 12
                                      : 17),
                            ),
                          ),
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
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    FirebaseFirestore.instance
                                        .collection(widget.product.category)
                                        .doc(widget.product.id)
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
                                              widget.product.id);

                                      print("Controlller " +
                                          _imageController.text);
                                      print("Value  " +
                                          _imagevalue.value.toString());

                                      if (_imageController.text != '') {
                                        _imagevalue.value =
                                            _imageController.text;
                                      } else if (_imageController.text == '') {
                                        _imagevalue.value =
                                            widget.product.image;
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
                                                              widget.product
                                                                  .image,
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
                              controller: _nameEnController,
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
                          widget.product.weight != 0
                              ? Column(
                                  children: [
                                    SizedBox(height: 4),
                                    Text(
                                      "Value ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.orange[300]),
                                    ),
                                    SizedBox(height: 4),
                                    StatefulBuilder(
                                      builder: (context, state) => Center(
                                        child: SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor:
                                                Colors.orange[700],
                                            inactiveTrackColor:
                                                Colors.orange[100],
                                            trackShape:
                                                RectangularSliderTrackShape(),
                                            trackHeight: 4.0,
                                            thumbColor: Colors.orange[300],
                                            thumbShape: RoundSliderThumbShape(
                                                enabledThumbRadius: 12.0),
                                            overlayColor:
                                                Colors.orange.withAlpha(32),
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
                              name: "Arabic Description (Optional)",
                              hint: "Arabic Description (Optional)",
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
                                  _nameEnController = TextEditingController(
                                      text: widget.product.nameEn);
                                  _descriptionEnController =
                                      TextEditingController(
                                          text: widget.product.descriptionEn);
                                  _priceController = TextEditingController(
                                      text: widget.product.price.toString());
                                  _imageController = TextEditingController(
                                      text: widget.product.image);
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
                                      .collection(widget.product.category)
                                      .doc(widget.product.id)
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

  bool _fromTop = false;
  _animationDialog(context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Product Animation",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Dismissible(
          direction: DismissDirection.down,
          onDismissed: (_) {
            Navigator.pop(context);
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
                                          width: 140,
                                          height: 170,
                                          padding: EdgeInsets.only(
                                            top: kDefaultPaddin * 2,
                                          ),
                                          child: CommonUI.cachedImage(
                                              widget.product.image,
                                              ImageAssets.placeholder,
                                              fit: BoxFit.cover)),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 6),
                                          Container(
                                            width:
                                                Responsive.isMiniMobile(context)
                                                    ? 100
                                                    : 140,
                                            child: Text(
                                              ProjectLanguage.isLTR()
                                                  ? widget.product.nameEn
                                                  : widget.product.nameAr,
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
                                              maxLines: 3,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(height: 9),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(text: "Price\n"),
                                                TextSpan(
                                                  text:
                                                      "${widget.product.price} JOD",
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
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          FirebaseFirestore.instance
                                              .collection(
                                                  widget.product.category)
                                              .doc(widget.product.id)
                                              .update({
                                            'options1': {
                                              widget.options
                                                  .elementAt(0)
                                                  .options
                                                  .keys
                                                  .first
                                                  .toString(): {
                                                'A': '1.00',
                                                'B': '2.00',
                                                'C': '3.00'
                                              }
                                            }
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 20,
                                          child: Text(
                                            widget.options
                                                .elementAt(0)
                                                .options
                                                .keys
                                                .first
                                                .toString()
                                                .substring(0, 1),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      GestureDetector(
                                        onTap: () async {
                                          FirebaseFirestore.instance
                                              .collection(
                                                  widget.product.category)
                                              .doc(widget.product.id)
                                              .update({
                                            'options2': {
                                              widget.options
                                                  .elementAt(1)
                                                  .options
                                                  .keys
                                                  .first
                                                  .toString(): {
                                                'A': '1.00',
                                                'B': '2.00',
                                                'C': '3.00'
                                              }
                                            }
                                          });
                                        },
                                        child: CircleAvatar(
                                            backgroundColor: Colors.green,
                                            radius: 20,
                                            child: Text(
                                              widget.options
                                                  .elementAt(1)
                                                  .options
                                                  .keys
                                                  .first
                                                  .toString()
                                                  .substring(0, 1),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      SizedBox(width: 5),
                                      GestureDetector(
                                        onTap: () async {
                                          FirebaseFirestore.instance
                                              .collection(
                                                  widget.product.category)
                                              .doc(widget.product.id)
                                              .update({
                                            'options3': {
                                              widget.options
                                                  .elementAt(2)
                                                  .options
                                                  .keys
                                                  .first
                                                  .toString(): {
                                                'A': '1.00',
                                                'B': '2.00',
                                                'C': '3.00'
                                              }
                                            }
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 20,
                                          child: Text(
                                            widget.options
                                                .elementAt(2)
                                                .options
                                                .keys
                                                .first
                                                .toString()
                                                .substring(0, 1),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                       
                                        ),
                                       
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        height: 6,
                        width: 100.0,
                      ),
                    ),
                    // Positioned(
                    //     top: -30,
                    //     child: Center(
                    //       child: CircleAvatar(
                    //         backgroundColor: Colors.grey,
                    //         radius: 30,
                    //         child: GestureDetector(
                    //           onTap: () {
                    //             Navigator.of(context).pop();
                    //           },
                    //           child: Icon(
                    //             Icons.keyboard_arrow_down_sharp,
                    //             color: Colors.white,
                    //             size: 35,
                    //           ),
                    //         ),
                    //       ),
                    //     )),
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
              Tween(begin: Offset(0, _fromTop ? -1 : 1), end: Offset(0, 0.25))
                  .animate(anim1),
          child: child,
        );
      },
    );
  }
}
