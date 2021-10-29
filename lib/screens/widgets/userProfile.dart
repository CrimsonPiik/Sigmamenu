import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/style/AssetsManager.dart';
// import 'package:icoffee/backend/firebase/Controller.dart';
// import 'package:icoffee/models/user.dart';
// import 'package:icoffee/style/AssetsManager.dart';
// import 'package:icoffee/style/CommonUI.dart';
// import 'package:icoffee/style/ScreenUtil.dart';
// import 'package:icoffee/style/Style.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/style/ScreenUtil.dart';
import 'package:shop_app/style/Style.dart';

class EditProfileInformation extends StatelessWidget {
  // final AppUser user;
  EditProfileInformation({
    Key? key,
    /* required this.user*/
  }) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future editUserProfile() async {
      // await FirebaseFirestore.instance.collection("users").doc(user.id).update({
      // "name": nameController.text,
      // "phone": phoneController.text,
      // "address": {'formattedAddress': addressController.text}
      // }).catchError((onError) => print("Error with editing User"));
    }

    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              // final ImagePicker _picker = ImagePicker();
              // var x = await _picker.pickImage(source: ImageSource.gallery);
              // final DocumentReference _documentReference =
              //     FirebaseFirestore.instance.collection("users").doc(user.id);
              // await fireBaseUploadFileWeb2("profile").then((value) =>
              //     Controllers().uploadFile(x!, user.id).then(
              //         (value) => _documentReference.update({"image": value})));
              // await Controllers().editProfileImage("gallery", user.id);
            },
            child: Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: Responsive.isDesktop(context) ? 80 : 50,
                    // backgroundImage: NetworkImage(user.image),
                  ),
                ),
                Center(
                  child: Container(
                    height: Responsive.isDesktop(context) ? 160 : 100,
                    width: Responsive.isDesktop(context) ? 160 : 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.brown.withOpacity(0.3)),
                    child: Icon(Icons.camera_alt_outlined,
                        size: Responsive.isDesktop(context) ? 60 : 40,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 60),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context) ? 32 : 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle(context, "Name"),
                    SizedBox(height: 8),
                    CommonUI.textField(
                      context: context,
                      name: "Name",
                      controller: nameController,
                      // hint: user.name
                      validate: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        // FormBuilderValidators.numeric(context),
                      ]),
                    ),
                    SizedBox(height: 16),
                    buildTitle(context, "Phone Number"),
                    SizedBox(height: 8),
                    CommonUI.textField(
                      context: context,
                      name: "phone number",
                      controller: phoneController,
                      // hint: user.phone,
                      validate: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                    ),
                    SizedBox(height: 16),
                    buildTitle(context, "Default Shipping Address"),
                    SizedBox(height: 8),
                    CommonUI.textField(
                      context: context,
                      name: "Name",
                      controller: addressController,
                      // hint: user.address.formattedAddress
                    ),
                    SizedBox(height: 32),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CommonUI.elevatedButton(
                        text: "Save",
                        context: context,
                        click: () async {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            await editUserProfile().whenComplete(() {
                              CommonUI.successDialog(context,
                                  message: "Saved successfully");
                            }).onError((error, stackTrace) => showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      content: Text(error.toString()),
                                    );
                                  },
                                ));
                          }
                        },
                        icon: SvgPicture.asset(
                          SvgAssets.edit,
                          height: 16,
                        ),
                        color: Colors.brown,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitle(BuildContext context, String title) {
    return CommonUI.text(
        text: title,
        style: FontStyle.normal(
            context: context, color: Colors.brown, fontWeight: FontWeight.bold),
        context: context);
  }
}
