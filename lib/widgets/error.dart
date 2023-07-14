import 'package:flutter/material.dart';
import 'package:frontend/widgets/messenger.dart';

class Error extends StatelessWidget {
  const Error({super.key, this.errorMessage = "Error in data fetching"});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    Meta().showMessage(context, message: errorMessage);
    return const Center(child: SizedBox());
  }
}
