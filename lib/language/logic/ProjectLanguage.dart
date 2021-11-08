import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sigmamenu/GeneralFunction/shared_preferences.dart';
import 'translatedWords.dart';

///Installed flutter localizations,
/// and extended the <State> of MyApp in main.dart.
/// This class will tell flutter to switch UI and use the correct json
class ProjectLanguage {
  ///This  is whre you can access the Language,by default is  english
  ///if you want to access it just call the call and its static  "ProjectLanguage.locale"
  ///.~saleh
  static Locale locale = Locale("en", "US");

  ProjectLanguage(Locale locale) {
    ProjectLanguage.locale = locale;
  }

  ///Add support for other LTR languages here
  static bool isLTR() {
    return locale.toString().contains("en");
  }

  ///This changes the current language in the static locale here.
  ///~saleh
  static changeLanguage() async {
    if (locale.languageCode == "en") {
      StorageProvider().setLanguage("ar");

      locale = Locale('ar', 'JO');
    } else {
      StorageProvider().setLanguage("en");

      locale = Locale("en", "US");
    }
  }

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static ProjectLanguage of(BuildContext context) {
    return Localizations.of<ProjectLanguage>(context, ProjectLanguage) ??
        ProjectLanguage(locale);
  }

  Future<Locale> getSavedLocale() async {
    String _langauge = await StorageProvider().getLanguage();

    if (_langauge == "ar") {
      return Locale("ar", "JO");
    } else {
      return Locale("en", "US");
    }
  }

  get currentLanguage => locale.languageCode;

  get currentLocale => locale;

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<ProjectLanguage> delegate =
      _ProjectLanguageDelegate();

  Map<String, String> _localizedStrings = en;

  Future<bool> load() async {
    Map<String, dynamic> jsonMap = locale.languageCode == 'en' ? en : ar;

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  changeLocale(Locale _locale) async {
    locale = _locale;
    await load();
  }

  /// #### This method will be called from every widget which needs a translated text. Used like this:
  /// ```Text(translate(context, [word]));```
  /// ##### ~Huthaifa
  String translate(String key) {
    return _localizedStrings[key] ?? 'N/A';
  }

  static isRTL() {}
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an ProjectLanguage object
class _ProjectLanguageDelegate extends LocalizationsDelegate<ProjectLanguage> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _ProjectLanguageDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<ProjectLanguage> load(Locale locale) async {
    // ProjectLanguage class is where the JSON loading actually runs
    ProjectLanguage localizations = ProjectLanguage(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_ProjectLanguageDelegate old) => false;
}

/// #### This method will be called from every widget which needs a translated text. Used like this:
///``` Text(translate(context, "word"));```
///
/// [word] refers to the key of the item we want translated. Add the new words to RhinoToolbox/language/logic/translatedWords.dart
/// ##### ~Huthaifa
String translate(BuildContext context, String word) {
  return ProjectLanguage.of(context).translate(word);
}
