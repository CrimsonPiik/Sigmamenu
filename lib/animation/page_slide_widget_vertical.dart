// onPressed: () => Navigator.of(context).push(
// createRoute(ChatScreen(ordersList[index].transactionId, false)),
import 'package:flutter/material.dart';

Route createRouteV(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        // UserTitle(email: email, image: userProfilePicture, name: fullName),
        page,
    transitionDuration: Duration(milliseconds: 500),

    ///RTL slide transition///
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    ),
  );
}
