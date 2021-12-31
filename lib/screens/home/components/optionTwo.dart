import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import '../../../style/Style.dart';

class Options2 extends StatefulWidget {
  final Product product;

  const Options2({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<Options2> createState() => _Options2State();
}

class _Options2State extends State<Options2> {
  bool _menu = false;
  int counter = 0;
  int subCounter = 0;
  String noName = '';
  void countItemBaby() {
    for (var v in widget.product.options2.keys) {
      counter++;
    }
  }

  @override
  void initState() {
    countItemBaby();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Center(
        //   child: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(24),
        //       color: Colors.grey.withOpacity(0.5),
        //     ),
        //     height: 1,
        //     width: 250,
        //   ),
        // ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: counter,
          itemBuilder: (context, index) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    subCounter = 0;
                    noName = '${widget.product.options2.keys.elementAt(index)}';
                    for (var v in widget
                        .product
                        .options2[
                            '${widget.product.options2.keys.elementAt(index)}']
                        .keys) {
                      subCounter++;
                      print(subCounter);
                    }

                    setState(() {
                      _menu = !_menu;
                      // _selectedItem = widget
                      //     .product
                      //     .options2[widget.product.options2.keys.elementAt(index)]
                      //     .keys
                      //     .elementAt(index);
                    });

                    // String vvv =
                    //     widget.product.options2.keys.elementAt(0); //Size
                    // print('MAP: ' + vvv);
                    // print('KEYS: ' +
                    //     widget.product.options2[vvv].keys
                    //         .elementAt(index)); // Index 0 in Size = 1.90

                    // print('VALUES: ' +
                    //     widget.product.options2[vvv].values
                    //         .elementAt(index)); // Index 0 in Size = 1.90
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonUI.text(
                          context: context,
                          text: widget.product.options2.keys.elementAt(index),
                          textAlign: TextAlign.center,
                          style: FontStyle.normal(
                              context: context,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Row(
                        children: [
                          CommonUI.text(
                              context: context,
                              text: // _selectedItem,
                                  widget
                                      .product
                                      .options2[
                                          '${widget.product.options2.keys.elementAt(index)}']
                                      .keys
                                      .elementAt(index),
                              textAlign: TextAlign.center,
                              style: FontStyle.normal(
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[300])),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                            color: Colors.orange[300],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        dropdownoptions2(noName),
        // SizedBox(height: 50),
      ],
    );
  }

  Widget dropdownoptions2(String noNAme) {
    return _menu
        ? Column(
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
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: subCounter,
                itemBuilder: (context, indexx) => Column(
                  children: [
                     Center(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          height: 1,
                          width: double.maxFinite),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          // setState(() {
                          // _selectedItem = 'Venti® 20 fl. oz';
                          // _selectedPrice = '5.24 JOD';
                          // });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonUI.text(
                                context: context,
                                text: widget
                                    .product
                                    .options2[noNAme

                                        // widget.product.options2.keys
                                        //   .elementAt(index)
                                        ]
                                    .keys
                                    .elementAt(indexx),
                                textAlign: TextAlign.center,
                                style: FontStyle.small(
                                    context: context,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.8))),
                            CommonUI.text(
                                context: context,
                                text: widget
                                        .product
                                        .options2[noNAme
                                            // widget.product.options2.keys
                                            //   .elementAt(index)
                                            ]
                                        .values
                                        .elementAt(indexx) +
                                    ' JOD',
                                textAlign: TextAlign.center,
                                style: FontStyle.small(
                                    context: context,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.8))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container();
  }
}
