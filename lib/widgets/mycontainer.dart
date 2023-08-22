import 'package:flutter/material.dart';

class Mycontainer extends StatelessWidget {
  const Mycontainer(
      {super.key,
      this.leading = false,
      required this.child,
      this.leadingwidget = const SizedBox()});

  final bool leading;
  final Widget child;
  final Widget leadingwidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (leading)
            leadingwidget
          else
            SizedBox(
                height: 20,
                width: 20,
                child: Image.asset("assets/notselected.png")),
          child
        ],
      )),
    );
  }
}
