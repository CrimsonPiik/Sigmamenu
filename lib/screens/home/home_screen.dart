import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigmamenu/provider/darkLightMode.dart';
import 'package:sigmamenu/screens/staggeredGridView.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme.getTheme(),
              home: Scaffold(
                // appBar: buildAppBar(),
                body: StaggerdGridView(
                  // theme: theme,
                ),
              ),
            ));
  }
}
