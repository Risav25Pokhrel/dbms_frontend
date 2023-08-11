import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/fonts.dart';
import 'package:frontend/widgets/markplace.dart';

import '../notifier.dart/notifiers.dart';

class ShowDestination extends StatelessWidget {
  const ShowDestination({super.key, this.color = Colors.white});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedroute,
      builder: (context, value, child) {
        String from;
        List<String> to = [];
        try {
          from = routeID[value[0]]!;
        } catch (e) {
          from = '';
        }
        try {
          for (int i = 0; i < value.length; i++) {
            if (i != 0) {
              to.add(routeID[value[i]]!);
            }
          }
        } catch (e) {
          to = [];
        }
        return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText.rich(TextSpan(
                  text: "FROM : ",
                  style: MyFont.headline
                      .copyWith(color: Colors.black, fontSize: 25),
                  children: [
                    TextSpan(
                        text: from,
                        style: MyFont.headline.copyWith(color: color))
                  ])),
              AutoSizeText.rich(TextSpan(
                  text: "TO: ",
                  style: MyFont.headline
                      .copyWith(fontSize: 25, color: Colors.black),
                  children: [
                    TextSpan(
                        text: to
                            .toString()
                            .replaceAll('[', "")
                            .replaceAll(']', ""),
                        style: MyFont.headline
                            .copyWith(color: color, fontSize: 24))
                  ])),
            ]);
      },
    );
  }
}
