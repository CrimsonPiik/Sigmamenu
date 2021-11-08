import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sigmamenu/style/AssetsManager.dart';

class LoadingSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //     child: SizedBox(
    //   height: 70,
    //   width: 70,
    //   child: CircularProgressIndicator(
    //     strokeWidth: 7,
    //     backgroundColor: Color(0xFF227c9d),
    //     valueColor:
    //         AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    //   ),
    // ));
    return Center(
      child: Lottie.asset(AnimAssets.loading, height: 50),

      // child: Card(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      //     child: SizedBox(
      //       width: 190,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           Lottie.asset(AnimAssets.loading, height: 50),
      //           Text(
      //             RhinoLanguage.isLTR() ? "Please Wait" : "يرجى الانتظار",
      //             style: FontStyle.normal(context: context),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
