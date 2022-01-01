import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/models/options.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import '../../../style/Style.dart';

class ProductOptions extends StatefulWidget {
  @override
  State<ProductOptions> createState() => _ProductOptionsState();
}

class _ProductOptionsState extends State<ProductOptions> {
  // int listLength = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('options').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);

          List<DocumentSnapshot> shots = snapshot.data!.docs;
          List<OptionsModel> options = [];

          for (var item in shots) {
            options
                .add(OptionsModel.fromMap(item.data() as Map<String, dynamic>));
          }
          print("Options Admin : " + options.toString());

          return Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: options.length,
              itemBuilder: (context, index) {
                // var list = options.elementAt(index).options.values.toList();
                // int listLength = list.where((e) => e == null).length;
                // print('A' + listLength.toString());
                int counter = 0;
                for (var v in options
                    .elementAt(index)
                    .options['${options.elementAt(index).options.keys.first}']
                    .values) {
                  counter++;
                }
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(1, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonUI.text(
                                      context: context,
                                      text: options
                                          .elementAt(index)
                                          .options
                                          .keys
                                          .first
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: FontStyle.normal(
                                          context: context,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Row(
                                    children: [
                                      CommonUI.text(
                                          context: context,
                                          text: 'Example!',
                                          // .product
                                          // .options1[
                                          //     '${widget.product.options1.keys.elementAt(index)}']
                                          // .keys
                                          // .elementAt(index),
                                          textAlign: TextAlign.center,
                                          style: FontStyle.normal(
                                              context: context,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange[700])),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 15,
                                        color: Colors.orange[700],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                height: 1,
                                width: double.maxFinite,
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: counter, //TODO
                              itemBuilder: (context, indexx) {
                                return Column(
                                  children: [
                                    Center(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          height: 1,
                                          width: double.maxFinite),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CommonUI.text(
                                                context: context,
                                                text: options
                                                    .elementAt(index)
                                                    .options[
                                                        '${options.elementAt(index).options.keys.first}']
                                                    .keys
                                                    .elementAt(indexx)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: FontStyle.small(
                                                    context: context,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                            CommonUI.text(
                                                context: context,
                                                text: options
                                                        .elementAt(index)
                                                        .options[
                                                            '${options.elementAt(index).options.keys.first}']
                                                        .values
                                                        .elementAt(indexx)
                                                        .toString() +
                                                    ' JOD',
                                                textAlign: TextAlign.center,
                                                style: FontStyle.small(
                                                    context: context,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                        .withOpacity(0.8))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
          // );
        });
  }
}
