import 'package:flutter/material.dart';
import 'package:shop_app/language/logic/ProjectLanguage.dart';
import 'package:shop_app/screens/home/components/SigningButton.dart';
import 'package:shop_app/style/ScreenUtil.dart';
import 'package:shop_app/style/Style.dart';

import 'ProjectFirebaseAuth.dart';

class GuestLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SigningButton(
      text: translate(context, "guest_login"),
      onPressed: () async {
        await ProjectFirebaseAuth().anonymousSignin();
      },
      textStyle: Responsive.isDesktop(context)
          ? FontStyle.small(
              context: context,
              fontWeight: FontWeight.bold,
              color: Style.primary)
          : null,
    );
  }
}

//  Container(
//                   child: Image.asset('assets/images/sigma.jpeg'),
//                 ),