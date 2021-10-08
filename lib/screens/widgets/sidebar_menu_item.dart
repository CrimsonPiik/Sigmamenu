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
            showDialogWithFields();
            String id = generateId();
            FirebaseFirestore.instance.collection('drinks').doc(id).set({
              'id': id,
              'nameEn': 'nameEn',
              'nameAr': 'nameAr',
              'category': 'category',
              'descriptionAr': 'descriptionAr',
              'descriptionEn': 'descriptionEn',
              'isPublished': true,
              'image':
                  'https://images.pexels.com/photos/2878711/pexels-photo-2878711.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
              'price': 4,
              'rate': 0,
              'weight': 0,
            });
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
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        icon: Icon(Icons.account_box),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Product Price',
                        icon: Icon(Icons.money),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Product Description',
                        icon: Icon(Icons.message),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Product Image',
                        icon: Icon(Icons.image),
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
                    // your code
                  })
            ],
          );
        });
  }
}
