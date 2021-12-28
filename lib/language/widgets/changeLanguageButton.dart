import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigmamenu/provider/ProjectLanguageProvider.dart';
import '../logic/ProjectLanguage.dart';

class ChangeLanguageButton extends StatefulWidget {
  const ChangeLanguageButton({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageButton> createState() => _ChangeLanguageButtonState();
}

bool _languageEn = true;

class _ChangeLanguageButtonState extends State<ChangeLanguageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _languageEn = !_languageEn;
        });

        ///This will go to 'Provider of RhinoLanguageChangeNotifier'
        ///and change the locale to new one and notify the main to rebuild
        ProjectLanguage.changeLanguage();
        Provider.of<ProjectLanguageChangeNotifier>(context, listen: true)
            .setlocale(ProjectLanguage.locale);
      },
      child: Stack(
        children: [
          Icon(
            Icons.language_outlined,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 15.0),
            child: Container(
                width: 18,
                height: 14,
                decoration: BoxDecoration(color: Colors.black),
                child: Text(_languageEn ? "EN" : "AR",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }
}
