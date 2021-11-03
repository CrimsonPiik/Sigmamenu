import 'package:flutter/material.dart';


///This is Provider for  Locale change only main listing to it
///.>saleh
class ProjectLanguageChangeNotifier with ChangeNotifier {
  Locale locale = Locale("en", "US");

  void setlocale(Locale locale) {
    this.locale = locale;
    notifyListeners();
  }
}
