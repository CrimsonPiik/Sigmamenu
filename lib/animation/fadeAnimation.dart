import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProjectFadeIn extends StatefulWidget {
  final Widget child;
  int? durationMS;
  ProjectFadeIn({required this.child, required this.durationMS});

  @override
  _ProjectFadeInState createState() => _ProjectFadeInState();
}

class _ProjectFadeInState extends State<ProjectFadeIn> {
  @override
  void initState() {
    super.initState();

    _currentOpacity = 0;
    timer();
  }

  timer() async {
    await Future.delayed(Duration(milliseconds: 200));
    if (mounted)
      setState(() {
        _currentOpacity = 1;
      });
  }

  late double _currentOpacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _currentOpacity,
      duration: Duration(milliseconds: widget.durationMS ?? 500),
      child: widget.child,
    );
  }
}
