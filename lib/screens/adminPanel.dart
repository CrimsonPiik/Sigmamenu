import 'package:flutter/material.dart';
import 'package:shop_app/screens/model.dart';
import 'package:shop_app/screens/widgets/news_item.dart';

final news = <News>[
  News('5 minutes ago', 'Product Name', 'assets/images/placeholder.jpg',
      'Product Desription'),
  News('5 minutes ago', 'Product Name', 'assets/images/placeholder.jpg',
      'Product Desription'),
  News('5 minutes ago', 'Product Name', 'assets/images/placeholder.jpg',
      'Product Desription'),
  News('5 minutes ago', 'Product Name', 'assets/images/placeholder.jpg',
      'Product Desription'),
  News('5 minutes ago', 'Product Name', 'assets/images/placeholder.jpg',
      'Product Desription'),
  News('5 minutes ago', 'Product Name', 'assets/images/placeholder.jpg',
      'Product Desription'),
  News('5 minutes ago', 'Product Name', 'assets/images/placeholder.jpg',
      'Product Desription'),
  News('5 minutes ago', 'Product Name', 'assets/images/placeholder.jpg',
      'Product Desription'),
  News('5 minutes ago', 'Product Name', 'assets/images/placeholder.jpg',
      'Product Desription'),
];

class AdminPanel extends StatelessWidget {
  final bool showDesktop;
  const AdminPanel([this.showDesktop = false]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: primaryLight.withAlpha(100),
        // padding: EdgeInsets.symmetric(horizontal: componentPadding),
        child: Column(
          children: [
            Container(
              // height: topBarHeight,
              child: Row(
                children: [
                  this.showDesktop
                      ? SizedBox.shrink()
                      : IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                  Expanded(
                      child: Center(
                    child: Text(
                      'Admin Dashboard',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ))
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: news.map((e) => NewsItem(e)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Container(
//           child: Column(
//             children: <Widget>[
//               // Text(spec_list[0]),
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: speclistlen,
//                 itemBuilder: (context, index) {
//                   return Text(spec_list[index]);
//                 },
//               )
//             ],
//           ),
//         );