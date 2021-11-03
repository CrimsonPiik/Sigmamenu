import 'package:flutter/material.dart';
import '../logic/ProjectLanguage.dart';
import '../logic/translatedWords.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Icon(Icons.language),
          Text(ProjectLanguage.isLTR() ? ar['language']! : en['language']!),
        ],
      ),
      onTap: () {
        ///This will go to 'Provider of RhinoLanguageChangeNotifier'
        ///and change the locale to new one and notify the main to rebuild
        ///.~saleh
        ProjectLanguage.changeLanguage();

     
      },
    );
  }
}
