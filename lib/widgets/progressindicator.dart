import 'package:flutter/material.dart';

class MyProgressIndicator extends StatefulWidget {
  const MyProgressIndicator(
      {super.key,
      this.begin = Colors.red,
      this.end = Colors.indigo,
      this.strokewidth = 2});

  final Color begin;
  final Color end;
  final double strokewidth;
  @override
  State<MyProgressIndicator> createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: CircularProgressIndicator.adaptive(
            strokeWidth: widget.strokewidth,
            valueColor: animationController
                .drive(ColorTween(begin: widget.begin, end: widget.end))),
      ),
    );
  }
}
