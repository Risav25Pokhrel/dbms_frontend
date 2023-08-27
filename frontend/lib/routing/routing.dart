import 'package:flutter/material.dart';

class Routing {
  withReplacement(BuildContext context, {required Widget page}) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  withoutReplacement(BuildContext context, {required Widget page}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
