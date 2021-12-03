import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/screens/home/components/customerScreen.dart';
import 'package:sigmamenu/screens/home/components/categoriesWithDeleteButton.dart';
import 'package:sigmamenu/screens/home/components/itemCardDataAdmin.dart';
import 'package:sigmamenu/screens/home/components/users.dart';
import 'package:sigmamenu/screens/widgets/addBannerButton.dart';
import 'package:sigmamenu/screens/widgets/addCategoryButton.dart';
import 'package:sigmamenu/screens/widgets/addProductButton.dart';
import 'package:sigmamenu/screens/widgets/adminPanelBanners.dart';

class AdminPanelProducts extends StatefulWidget {
  final Stream<int> menu;
  AdminPanelProducts(this.menu);
  @override
  _AdminPanelProductsState createState() => _AdminPanelProductsState();
}

class _AdminPanelProductsState extends State<AdminPanelProducts> {
  int item = 0;

  @override
  void initState() {
    widget.menu.listen((whichMenu) {
      mySetState(whichMenu);
    });
    super.initState();
  }

  void mySetState(int whichMenu) {
    if (!mounted) return;

    setState(() {
      item = whichMenu;
    });
  }

//  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    // AppUser user = Provider.of<UserState>(context, listen: true).appUser;
    return item == 0 //&& isEdit == false //USER
        ? Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                // SizedBox(
                // height: 70,
                // child: Row(
                //   children: [
                //     SizedBox(
                //       height: 10,
                //       width: 25,
                //     ),
                //     Expanded(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             'WELCOME BACK ${user.name} !',
                //             style: TextStyle(
                //                 fontSize:
                //                     Responsive.isDesktop(context) ? 18 : 12,
                //                 fontWeight: FontWeight.w600),
                //           ),
                //           SizedBox(width: 4),
                //           InkWell(
                //             onTap: () {
                //               setState(() {
                //                 isEdit = true;
                //               });
                //             },
                //             child: CircleAvatar(
                //               backgroundImage: NetworkImage(user.image),
                //               // backgroundColor: Colors.brown,
                //             ),
                //           ),
                //         ],
                //       ),
                // ),
                // SizedBox(width: 25),
                // ],
                // ),
                // ),
                // SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 12),
                        Align(
                          alignment: Alignment.topLeft,
                          // child: Padding(
                          // padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Container(
                            height: 40,
                            // padding: EdgeInsets.all(2),
                            child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Users  ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            decoration: BoxDecoration(
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Align(
                          alignment: Alignment.topLeft,
                          // child: Padding(
                          // padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Container(
                            height: 40,
                            // padding: EdgeInsets.all(2),
                            child: TextButton.icon(
                                onPressed: () {
                                  // setState(() {
                                  //   isEdit = true;
                                  // });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'My User  ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            decoration: BoxDecoration(
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Align(
                          alignment: Alignment.topLeft,
                          // child: Padding(
                          // padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Container(
                            height: 40,
                            // padding: EdgeInsets.all(2),
                            child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Add User  ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            decoration: BoxDecoration(
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Users(), 
                //                    EditProfileInformation()

              ],
            ),
          )
        // : item == 0 && isEdit == true
        //     ? Expanded(
        //         // color: primaryLight.withAlpha(100),
        //         // padding: EdgeInsets.symmetric(horizontal: ),
        //         child: Column(
        //           children: [
        //             SizedBox(height: 25),
        //             // child: Row(
        //             //   children: [
        //             //     SizedBox(
        //             //       height: 10,
        //             //       width: 25,
        //             //     ),
        //             //     Expanded(
        //             //       child: Row(
        //             //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             //         children: [
        //             //           Text(
        //             //             'WELCOME BACK ${user.name} !',
        //             //             style: TextStyle(
        //             //                 fontSize: Responsive.isDesktop(context)
        //             //                     ? 18
        //             //                     : 12,
        //             //                 fontWeight: FontWeight.w600),
        //             //           ),
        //             //           SizedBox(width: 4),
        //             //           InkWell(
        //             //             onTap: () {
        //             //               setState(() {
        //             //                 isEdit = false;
        //             //               });
        //             //             },
        //             //             child: CircleAvatar(
        //             //               backgroundImage: NetworkImage(user.image),
        //             //               // backgroundColor: Colors.brown,
        //             //             ),
        //             //           ),
        //             //         ],
        //             //       ),
        //             //     ),
        //             //     SizedBox(width: 25),
        //             //   ],
        //             // ),
        //             // ),
        //             // SizedBox(height: 15),
        //             Padding(
        //               padding: const EdgeInsets.all(12.0),
        //               child: Row(
        //                 children: [
        //                   SizedBox(width: 12),
        //                   Align(
        //                     alignment: Alignment.topLeft,
        //                     // child: Padding(
        //                     // padding: const EdgeInsets.symmetric(horizontal: 6.0),
        //                     child: Container(
        //                       height: 40,
        //                       // padding: EdgeInsets.all(2),
        //                       child: TextButton.icon(
        //                           onPressed: () {
        //                             setState(() {
        //                               isEdit = false;
        //                             });
        //                           },
        //                           icon: Icon(
        //                             Icons.person,
        //                             color: Colors.white,
        //                           ),
        //                           label: Text(
        //                             'Users  ',
        //                             style: TextStyle(
        //                                 color: Colors.white,
        //                                 fontWeight: FontWeight.bold),
        //                           )),
        //                       decoration: BoxDecoration(
        //                         color: isEdit ? Colors.blue[600] : Colors.black,
        //                         borderRadius: BorderRadius.circular(16),
        //                       ),
        //                     ),
        //                   ),
        //                   SizedBox(width: 15),
        //                   Align(
        //                     alignment: Alignment.topLeft,
        //                     // child: Padding(
        //                     // padding: const EdgeInsets.symmetric(horizontal: 6.0),
        //                     child: Container(
        //                       height: 40,
        //                       // padding: EdgeInsets.all(2),
        //                       child: TextButton.icon(
        //                           onPressed: () {},
        //                           icon: Icon(
        //                             Icons.edit,
        //                             color: Colors.white,
        //                           ),
        //                           label: Text(
        //                             'My User  ',
        //                             style: TextStyle(
        //                                 color: Colors.white,
        //                                 //   children: [
        //                                 //     SizedBox(
        //                                 //       height: 10,
        //                                 //       width: 25,
        //                                 //     ),
        //                                 //     Expanded(
        //                                 //       child: Row(
        //                                 //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                 //         children: [
        //                                 //           Text(
        //                                 //             'WELCOME BACK ${user.name} !',
        //                                 //             style: TextStyle(
        //                                 //                 fontSize:
        //                                 //                     Responsive.isDesktop(context) ? 18 : 12,
        //                                 //                 fontWeight: FontWeight.w600),
        //                                 //           ),
        //                                 //           SizedBox(width: 4),
        //                                 //           InkWell(
        //                                 //             onTap: () {
        //                                 //               setState(() {
        //                                 //                 isEdit = true;
        //                                 //               });
        //                                 //             },
        //                                 //             child: CircleAvatar(
        //                                 //               backgroundImage: NetworkImage(user.image),
        //                                 //               // backgroundColor: Colors.brown,
        //                                 //             ),
        //                                 //           ),
        //                                 //         ],
        //                                 //       ),
        //                                 fontWeight: FontWeight.bold),
        //                           )),
        //                       decoration: BoxDecoration(
        //                         color: isEdit == false
        //                             ? Colors.blue[600]
        //                             : Colors.black,
        //                         borderRadius: BorderRadius.circular(16),
        //                       ),
        //                     ),
        //                   ),
        //                   SizedBox(width: 15),
        //                   Align(
        //                     alignment: Alignment.topLeft,
        //                     // child: Padding(
        //                     // padding: const EdgeInsets.symmetric(horizontal: 6.0),
        //                     child: Container(
        //                       height: 40,
        //                       // padding: EdgeInsets.all(2),
        //                       child: TextButton.icon(
        //                           onPressed: () {},
        //                           icon: Icon(
        //                             Icons.add,
        //                             color: Colors.white,
        //                           ),
        //                           label: Text(
        //                             'Add User  ',
        //                             style: TextStyle(
        //                                 color: Colors.white,
        //                                 fontWeight: FontWeight.bold),
        //                           )),
        //                       decoration: BoxDecoration(
        //                         color: Colors.blue[600],
        //                         borderRadius: BorderRadius.circular(16),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             EditProfileInformation()
        //           ],
        //         ),
        //       )
            : item == 1 //DASHBOARD
                ? Expanded(
                    // color: primaryLight.withAlpha(100),
                    // padding: EdgeInsets.symmetric(horizontal: ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        // child: Row(
                        //   children: [
                        //     SizedBox(
                        //       height: 20,
                        //       width: 25,
                        //     ),
                        //     Expanded(
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             'WELCOME BACK ${user.name} !',
                        //             style: TextStyle(
                        //                 fontSize:
                        //                     Responsive.isDesktop(context)
                        //                         ? 18
                        //                         : 12,
                        //                 fontWeight: FontWeight.w600),
                        //           ),
                        //           SizedBox(width: 4),
                        //           CircleAvatar(
                        //             backgroundImage: NetworkImage(user.image),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(width: 25),
                        //   ],
                        // ),
                        // ),

                        // Padding(
                        // padding: const EdgeInsets.all(2.0),
                        // child:
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 12),
                              CategoriesWithDeleteButton(
                                  streamController.stream),
                              SizedBox(width: 12),
                              AddCategoryButton(),
                            ],
                          ),
                        ),
                        // ),
                        SizedBox(height: 12),
                        AddProductButton(streamController.stream),
                        SizedBox(height: 12),
                        ItemCardDataAdmin(streamController.stream),
                      ],
                    ),
                  )
                : Expanded(
                    // BANNERS
                    // color: primaryLight.withAlpha(100),
                    // padding: EdgeInsets.symmetric(horizontal: ),
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        // SizedBox(
                        // height: 70,
                        // child: Row(
                        //   children: [
                        //     SizedBox(
                        //       height: 10,
                        //       width: 25,
                        //     ),
                        //     Expanded(
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             'WELCOME BACK ${user.name} !',
                        //             style: TextStyle(
                        //                 fontSize:
                        //                     Responsive.isDesktop(context)
                        //                         ? 18
                        //                         : 12,
                        //                 fontWeight: FontWeight.w600),
                        //           ),
                        //           SizedBox(width: 4),
                        //           CircleAvatar(
                        //             backgroundImage: NetworkImage(user.image),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(width: 25),
                        //   ],
                        // ),
                        // ),
                        AddBannerButton(),
                        SizedBox(height: 15),
                        AdminPanelBanners()
                      ],
                    ),
                  );
  }
}
