import 'package:flutter/material.dart';

class CategoriesProvider with ChangeNotifier {
  Set<String> _subCategories = {};

  int get count => _subCategories.length;
  Set<String> get subCategories => _subCategories;
  void addItem(String item) {
    _subCategories.add(item);
    notifyListeners();
  }
}
