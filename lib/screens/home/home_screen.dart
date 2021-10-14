import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/body.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // getCategoriesFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(),
      body: Body(),
    );
  }
}
