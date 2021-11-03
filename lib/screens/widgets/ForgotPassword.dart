import 'package:flutter/material.dart';
import 'package:shop_app/language/logic/ProjectLanguage.dart';
import 'package:shop_app/screens/widgets/ForgotPasswordScreen.dart';
import 'package:shop_app/style/Style.dart';

// ignore: must_be_immutable
class FortgotPasswordButton extends StatelessWidget {
  Color? textColor = Style.primary;
  VoidCallback? click;
  final BuildContext ctx;
  FortgotPasswordButton({Key? key, required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            showDialog(
              context: ctx,
              builder: (_) => ForgotPasswordScreen(),
            );
          },
          child: Text(translate(context, "forgotPassword"),
              style: FontStyle.normal(
                  context: context,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
