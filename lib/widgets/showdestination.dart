import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/fonts.dart';

import '../notifier.dart/notifiers.dart';

class ShowDestination extends StatelessWidget {
  const ShowDestination({super.key, this.color = Colors.white});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: from,
        builder: (context, fromValue, child) => ValueListenableBuilder(
              valueListenable: to,
              builder: (context, toValue, child) {
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
                                text: fromValue,
                                style: MyFont.headline.copyWith(color: color))
                          ])),
                      AutoSizeText.rich(TextSpan(
                          text: "TO: ",
                          style: MyFont.headline
                              .copyWith(fontSize: 25, color: Colors.black),
                          children: [
                            TextSpan(
                                text: toValue,
                                style: MyFont.headline
                                    .copyWith(color: color, fontSize: 24))
                          ])),
                    ]);
              },
            ));
  }
}
