import 'package:flutter/material.dart';

// stands for vertical space
class VSpace extends StatelessWidget {
  /// stands for vertical space
  const VSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.05,
    );
  }
}
