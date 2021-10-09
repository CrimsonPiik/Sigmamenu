
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  TextEditingController nameEnController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionEnController = TextEditingController();

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
                    TextFormField(
                      // style: TextStyle(color: Colors.brown),
                      controller: nameEnController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        icon: Icon(Icons.account_box),
                      ),
                    ),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: 'Product Price',
                        icon: Icon(Icons.money),
                      ),
                    ),
                    TextFormField(
                      controller: descriptionEnController,
                      decoration: InputDecoration(
                        labelText: 'Product Description',
                        icon: Icon(Icons.message),
                      ),
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     labelText: 'Product Image',
                    //     icon: Icon(Icons.image),
                    //   ),
                    // ),
                    TextButton(
                        onPressed: () async {
                        },
                        child: Text('Import a photo'))
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
                      'nameEn': nameEnController.text,
                      'nameAr': 'nameAr',
                      'category': 'category',
                      'descriptionAr': 'descriptionAr',
                      'descriptionEn': descriptionEnController.text,
                      'isPublished': true,
                      'image': imageURL,
                      'price': priceController.text,
                      'rate': 0,
                      'weight': 0,
                    });
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
//   }

// Future uploadProfilePhotoToFirebase() async {
//     FilePickerResult? result =
//       await FilePicker.platform.pickFiles(withData: true);

//     String extension0 = result!.files.first.extension!;
//     // print(extension0);
//     String imageId = id + (".") + extension0;
//   // String fileName = basename(_image.path);  //Get File Name - Or set one
//   Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('images/$imageId');
//   TaskSnapshot uploadTask = await firebaseStorageRef.putFile();
//   String url = await uploadTask.ref.getDownloadURL(); //Get URL
//   return await FirebaseFirestore.instance.collection('drinks').doc(id).update({ //Update url in Firestore (if required)
//     'image': url,
//   });
}

}
