import 'package:flutter/material.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/screens/widgets/SigningButton.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Style.dart';

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
          ? FontStylee.small(
              context: context,
              fontWeight: FontWeight.bold,
              color: Style.primary)
          : null,
    );
  }
}