import 'package:flutter/material.dart';
import 'package:frontend/utils/fonts.dart';

myrich(
    {required String leading,
    required String trailing,
    double size=20,
    Color color = Colors.indigo}) {
  return Text.rich(TextSpan(style: MyFont.headline.copyWith(fontSize: size), text: leading, children: [
    TextSpan(style: MyFont.headline.copyWith(color: color,fontSize: size-4), text: trailing)
  ]));
}