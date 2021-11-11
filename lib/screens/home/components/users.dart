import 'package:flutter/cupertino.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/screens/home/components/usersCard.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: GridView.builder(
            itemCount: 5,
            //products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: Responsive.isDesktop(context)
                    ? MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 3.5)
                    : MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 2.7)
                //       //               // ScreenUtil.isDesktop(context)
                //       //               // ? 7
                //       //               // : ScreenUtil.isTablet(context)
                //       //               // ? 4
                //       //               //  : 2,
                //       //               // mainAxisSpacing: kDefaultPaddin,
                //       //               // crossAxisSpacing: kDefaultPaddin,
                // childAspectRatio: 130.0,
                ),
            itemBuilder: (context, index) =>
                //  TextButton.icon(
                //                   onPressed: () {}, icon: Icon(Icons.add), label: Text('Add')),
                UsersCard(),
          )),
      // ),
      // ],
    );
  }
}
