import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigmamenu/provider/ProjectLanguageProvider.dart';
import '../logic/ProjectLanguage.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.translate,
        color: Colors.white,
      ),

      // Text(ProjectLanguage.isLTR() ? ar['language']! : en['language']!),

      onTap: () {
        ///This will go to 'Provider of RhinoLanguageChangeNotifier'
        ///and change the locale to new one and notify the main to rebuild
        ProjectLanguage.changeLanguage();
        Provider.of<ProjectLanguageChangeNotifier>(context, listen: false)
            .setlocale(ProjectLanguage.locale);
      },
    );
  }
}
