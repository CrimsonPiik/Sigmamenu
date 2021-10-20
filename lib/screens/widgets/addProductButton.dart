import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/GeneralFunction/firebase_uploader_web.dart';
import 'package:shop_app/GeneralFunction/random_id_generator.dart';

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
  ValueNotifier<String?> _image = ValueNotifier<String?>(null);
  String _validatorText = "This field can't be empty";

  String category = 'drinks';

  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) {
      mySetState(index);
    });
  }

  void mySetState(int index) {
    List categoryMenu = [
      'drinks',
      'maincourses',
      'appetizers',
      'desserts',
      'salads',
      'brunch'
    ];
    setState(() {
      category = categoryMenu[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          showDialogWithFields();
        },
        icon: Icon(Icons.add),
        label: Text('Add'));
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _image,
                          builder: (BuildContext context, dynamic value,
                              Widget? child) {
                            return value != null
                                ? InkWell(
                                    onTap: () async {
                                      CircularProgressIndicator();
                                      _imageController.text =
                                          await fireBaseUploadFileWeb(id);
                                      _image.value = _imageController.text;
                                      // print(_imageController.text);
                                    },
                                    child: Container(
                                      height: 100,
                                      // width: 120,
                                      child: InteractiveViewer(
                                        child: Image.network(value,
                                            fit: BoxFit.fitWidth),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      CircularProgressIndicator();
                                      _imageController.text =
                                          await fireBaseUploadFileWeb(id);
                                      _image.value = _imageController.text;
                                      // print(_imageController.text);
                                    },
                                    child: Container(
                                      height: 100,
                                      // width: 120,
                                      child: Image.asset(
                                        'assets/images/placeholder.jpg',
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
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
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: Center(child: Text("Create")),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection(category)
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
