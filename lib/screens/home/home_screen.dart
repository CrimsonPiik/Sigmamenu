import 'package:flutter/material.dart';
import 'package:sigmamenu/screens/home/components/customerScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(),
      body: CustomerScreen(),
    );
  }
}
