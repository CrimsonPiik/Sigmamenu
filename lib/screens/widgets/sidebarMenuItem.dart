import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/GeneralFunction/firebase_uploader_web.dart';
import 'package:shop_app/GeneralFunction/random_id_generator.dart';
import 'package:shop_app/models/model.dart';

class SideBarMenuItem extends StatefulWidget {
  final MenuItem item;
  final bool isDesktop;
  SideBarMenuItem(this.item, [this.isDesktop = false]);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<SideBarMenuItem> {
  var _bgColor = Colors.transparent;
  var _iconColor = Colors.white;
  String id = generateId();
  String imageURL = 'assets/images/placeholder.jpg';
  TextEditingController _nameEnController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionEnController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  ValueNotifier<String?> _image = ValueNotifier<String?>(null);
  String _validatorText = "This field can't be empty";

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (e) {
          setState(() {
            _bgColor = Colors.white;
            _iconColor = Colors.brown;
          });
        },
        onExit: (e) {
          setState(() {
            _bgColor = Colors.transparent;
            _iconColor = Colors.white;
          });
        },
        child: InkWell(
          onTap: () {
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) => CustomDialog());
            showDialogWithFields();
          },
          child: Container(
            width: widget.isDesktop ? null : 44,
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: _bgColor, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: widget.isDesktop
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Icon(
                  widget.item.icon,
                  size: 20,
                  color: _iconColor,
                ),
                if (widget.isDesktop) ...[
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    widget.item.name,
                    style: TextStyle(
                      color: _iconColor,
                    ),
                  )
                ] else
                  SizedBox.shrink(),
              ],
            ),
          ),
        ));
  }

  void showDialogWithFields() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Colors.brown,
            scrollable: true,
            title: Center(child: Text('Create a new Product')),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: TextFormField(
                        validator: (value) => value!.isEmpty
                            ? _validatorText
                            : null, // style: TextStyle(color: Colors.brown),
                        controller: _nameEnController,
                        decoration: InputDecoration(
                          labelText: 'Product Name',
                          icon: Icon(Icons.account_box),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? _validatorText : null,
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Product Price',
                          icon: Icon(Icons.money),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? _validatorText : null,
                        controller: _descriptionEnController,
                        decoration: InputDecoration(
                          labelText: 'Product Description',
                          icon: Icon(Icons.message),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? _validatorText : null,
                            controller: _imageController,
                            onChanged: (value) {
                              _image.value = value;
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.image),
                              labelText: "Product Image",
                            ),
                          ),
                        ),
                        Expanded(
                          child: ValueListenableBuilder(
                            valueListenable: _image,
                            builder: (BuildContext context, dynamic value,
                                Widget? child) {
                              return Container(
                                child: Column(children: [
                                  _image.value != null
                                      ? Container(
                                          height: 60,
                                          width: 70,
                                          child: InteractiveViewer(
                                            child: Image.network(value,
                                                fit: BoxFit.fitHeight),
                                          ),
                                        )
                                      : Container(
                                          height: 60,
                                          width: 70,
                                          color: Colors.black,
                                        ),
                                  TextButton(
                                      onPressed: () async {
                                        _imageController.text =
                                            await fireBaseUploadFileWeb(id);
                                        _image.value = _imageController.text;
                                        print(_imageController.text);
                                      },
                                      child: Text('Upload Image'))
                                ]),
                              );
                            },
                          ),
                        ),
                        // SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: Center(child: Text("Create")),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('drinks')
                        .doc(id)
                        .set({
                      'id': id,
                      'nameEn': _nameEnController.text,
                      'nameAr': 'nameAr',
                      'category': 'drinks',
                      'descriptionAr': 'descriptionAr',
                      'descriptionEn': _descriptionEnController.text,
                      'isPublished': true,
                      'image': _imageController.text,
                      'price': _priceController.text,
                      'rate': 0,
                      'weight': 0,
                      //subCategory: ---
                    });
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }
}
