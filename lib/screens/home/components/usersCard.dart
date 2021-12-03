import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sigmamenu/models/user.dart';
import 'package:sigmamenu/style/AssetsManager.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class UsersCard extends StatefulWidget {
  final AppUser data;

  const UsersCard({Key? key, required this.data}) : super(key: key);

  @override
  State<UsersCard> createState() => _UsersCardState();
}

class _UsersCardState extends State<UsersCard> {
  final _formKey = GlobalKey<FormBuilderState>();

  late TextEditingController _nameController =
      TextEditingController(text: _name);
  late TextEditingController _emailController =
      TextEditingController(text: _email);
  late TextEditingController _phoneController =
      TextEditingController(text: _phone);

  late String _name;
  late String _phone;
  late String _email;

  @override
  void initState() {
    _name = widget.data.name;
    _email = widget.data.email;
    _phone = widget.data.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      // startActionPane:
      //  ActionPane(
      //   // A motion is a widget used to control how the pane animates.
      //   motion: const ScrollMotion(),

      //   // A pane can dismiss the Slidable.
      //   dismissible: DismissiblePane(onDismissed: () {}),

      //   // All actions are defined in the children parameter.
      //   children: const [
      //     // A SlidableAction can have an icon and/or a label.
      //     SlidableAction(
      //       onPressed: doNothing,
      //       backgroundColor: Color(0xFFFE4A49),
      //       foregroundColor: Colors.white,
      //       icon: Icons.delete,
      //       label: 'Delete',
      //     ),
      //     SlidableAction(
      //       onPressed: doNothing,
      //       backgroundColor: Color(0xFF21B7CA),
      //       foregroundColor: Colors.white,
      //       icon: Icons.edit,
      //       label: 'Edit',
      //     ),
      //   ],
      // ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            // flex: 2,
            onPressed: (context) {
              // Navigator.of(context).push(createRoute(EditProfileInformation()));
              //  setState(() {
              //   _nameEnController = TextEditingController(
              //       text: widget.data.nameEn);
              //   _nameArController = TextEditingController(
              //       text: widget.data.nameAr);
              //   _descriptionEnController =
              //       TextEditingController(
              //           text: widget.data.descriptionEn);
              //   _descriptionArController =
              //       TextEditingController(
              //           text: widget.data.descriptionAr);
              //   _priceController = TextEditingController(
              //       text: widget.data.price.toString());
              //   _imageController = TextEditingController(
              //       text: widget.data.image);
              //   _value = widget.data.weight.toDouble();
              // });
              _showEditDialog(context, widget.data);
            },
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            autoClose: true,
          ),
          SlidableAction(
            onPressed: (context) {
              _showDeleteCategoryDialog(context);
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
      child: Container(
          padding: EdgeInsets.only(top: 8, left: 16, right: 8, bottom: 8),
          child:
              // Row(
              //   children: [
              //     Container(
              //         width: 120,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(4),
              //         ),
              //         child: CommonUI.cachedImage(
              //             widget.data.image, ImageAssets.placeholder,
              //             fit: BoxFit.cover)),
              //     SizedBox(
              //       width: 16,
              //     ),
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             widget.data.name,
              //             overflow: TextOverflow.ellipsis,
              //             maxLines: 1,
              //             style:
              //                 TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              //           ),
              //           SizedBox(
              //             height: 4,
              //           ),
              //           Text(
              //             widget.data.phone,
              //             overflow: TextOverflow.ellipsis,
              //             maxLines: 2,
              //             style:
              //                 TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              //           ),
              //           SizedBox(
              //             height: 4,
              //           ),
              //           Text(
              //             widget.data.phone,
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w300,
              //                 // fontStyle: FontStyle.italic,
              //                 fontSize: 12),
              //           ),
              //           // Row(
              //           //   mainAxisAlignment: MainAxisAlignment.end,
              //           //   children: [
              //           //     SizedBox(width: 20),
              //           //     TextButton(
              //           //         onPressed: () {},
              //           //         child: Icon(Icons.edit, color: Colors.brown)),
              //           //     TextButton(
              //           //         onPressed: () {
              //           //           _showDeleteCategoryDialog();
              //           //         },
              //           //         child: Icon(Icons.delete, color: Colors.red)),
              //           //   ],
              //           // ),
              //         ],
              //       ),
              //     )
              //   ],
              // )
              Row(
            children: [
              Container(
                  width: 120,
                  // height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CommonUI.cachedImage(
                      widget.data.image, ImageAssets.user,
                      fit: BoxFit.fitHeight)),
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
                        widget.data.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                Responsive.isMiniMobile(context) ? 12 : 14),
                      ),
                      SizedBox(
                        height: Responsive.isMiniMobile(context) ? 8 : 16,
                      ),
                      Text(
                        widget.data.email,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                      SizedBox(
                        height: Responsive.isMiniMobile(context) ? 8 : 16,
                      ),
                      Text(
                        widget.data.phone,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====
// =====                                    DELETE                                        =====
// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====

  _showDeleteCategoryDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            content: Text('Are you sure you want to delete this user ?'),
            actions: [
              TextButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.data.id)
                      .delete();

                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'YES',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'NO',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          );
        });
  }

// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====
// =====                                    EDIT                                          =====
// =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====  ===== =====  =====

  _showEditDialog(BuildContext context, AppUser user) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormBuilder(
            key: _formKey,
            child: AlertDialog(
              title: Text(
                "Edit User",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              content: SingleChildScrollView(
                child: Container(
                  width: Responsive.isDesktop(context) ? 350 : 290,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/user.png')),
                        ),
                      ),
                      SizedBox(height: 30),
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
                      SizedBox(height: 4),
                      Container(
                        child: CommonUI.textField(
                          context: context,
                          name: "Email",
                          hint: "Email",
                          isEdit: true,
                          minlines: 1,
                          controller: _emailController,
                          validate: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        child: CommonUI.textField(
                          context: context,
                          name: "Phone Number",
                          hint: "Phone Number",
                          isEdit: true,
                          keyboardtype: TextInputType.number,
                          controller: _phoneController,
                          validate: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                          ]),
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.id)
                          .update({
                        'name': _nameController.text,
                        'phone': _phoneController.text,
                        'email': _emailController.text,
                      }).whenComplete(() {
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
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _nameController = TextEditingController(text: user.name);
                      _emailController = TextEditingController(text: user.email);
                      _phoneController =
                          TextEditingController(text: user.phone.toString());
                    });

                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
