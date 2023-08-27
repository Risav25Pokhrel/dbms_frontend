import 'package:flutter/material.dart';

class Meta {
  showMessage(BuildContext ctx,
      {required String message, Color color = Colors.red}) {
    final snackbar = SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        backgroundColor: color);
    return ScaffoldMessenger.of(ctx).showSnackBar(snackbar);
  }
}
