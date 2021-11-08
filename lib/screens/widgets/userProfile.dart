import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sigmamenu/GeneralFunction/firebase_uploader_web.dart';
import 'package:sigmamenu/models/user.dart';
import 'package:sigmamenu/provider/userStateProvider.dart';
import 'package:sigmamenu/style/AssetsManager.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Style.dart';

class EditProfileInformation extends StatefulWidget {
  EditProfileInformation({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileInformation> createState() => _EditProfileInformationState();
}

class _EditProfileInformationState extends State<EditProfileInformation> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool editmode = false;
  TextEditingController _nameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _imageController = TextEditingController();

  ValueNotifier<String?> _imagevalue = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserState>(context, listen: true).appUser;

    Future editUserProfile() async {
      await FirebaseFirestore.instance.collection("users").doc(user.id).update({
        "name": _nameController.text,
        "phone": _phoneController.text,
        'image': _imageController.text,
      }).catchError((onError) => print("Error with editing User"));
      setState(() {
        editmode = false;
      });
    }

    return editmode == true
        ? FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                  valueListenable: _imagevalue,
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    return Center(
                      child: Ink(
                        width: 180,
                        height: 180,
                        child: InkWell(
                          onTap: () async {
                            _imageController.text =
                                await fireBaseUploadFileWeb(user.id);
                            _imagevalue.value = _imageController.text;
                          },
                          child: _imagevalue.value != null
                              ? Center(
                                  child: Stack(children: [
                                    Container(
                                      height: 180,
                                      width: 180,
                                      child: InteractiveViewer(
                                        child: Image.network(
                                          _imageController.text,
                                          fit: BoxFit.fitWidth,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
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
                                          color: Color(0x4D303030)),
                                      height: 180,
                                      width: 180,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 145),
                                      child: Container(
                                          height: 35,
                                          width: 180,
                                          decoration: BoxDecoration(
                                              color: Color(0x4D000000)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Edit ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(Icons.edit,
                                                  color: Colors.white)
                                            ],
                                          )),
                                    ),
                                  ]),
                                )
                              : Center(
                                  child: Stack(children: [
                                    Container(
                                        height: 180,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: CommonUI.cachedImage(
                                            user.image, ImageAssets.placeholder,
                                            fit: BoxFit.fitWidth)),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(0x4D303030)),
                                      height: 180,
                                      width: 180,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 145),
                                      child: Container(
                                          height: 35,
                                          width: 180,
                                          decoration: BoxDecoration(
                                              color: Color(0x4D000000)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Edit ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(Icons.edit,
                                                  color: Colors.white)
                                            ],
                                          )),
                                    ),
                                  ]),
                                ),
                        ),
                      ),
                    );
                  },
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
                            isEdit: true,
                            controller: _nameController,
                            validate: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                          SizedBox(height: 16),
                          buildTitle(context, "Phone Number"),
                          SizedBox(height: 8),
                          CommonUI.textField(
                            context: context,
                            name: "phone number",
                            isEdit: true,
                            controller: _phoneController,
                            validate: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.numeric(context),
                            ]),
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
                                    }).onError((error, stackTrace) =>
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              content: Text(error.toString()),
                                            );
                                          },
                                        ));
                                  }
                                },
                                icon: Icon(Icons.save, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                    radius: Responsive.isDesktop(context) ? 80 : 50,
                    backgroundImage:
                        NetworkImage(user.image)
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
                        buildTitle(context, "Name  :  ${user.name}"),
                        SizedBox(height: 16),
                        buildTitle(context, "Phone Number  :  ${user.phone}"),
                        SizedBox(height: 32),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CommonUI.elevatedButton(
                            text: "Edit",
                            context: context,
                            click: () async {
                              setState(() {
                                editmode = true;
                              });
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
