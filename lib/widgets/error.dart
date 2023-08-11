import 'package:flutter/material.dart';
import 'package:frontend/widgets/messenger.dart';

class ShowError extends StatefulWidget {
  const ShowError({super.key, this.errorMessage = "Error in data fetching"});

  final String errorMessage;

  @override
  State<ShowError> createState() => _ShowErrorState();
}

class _ShowErrorState extends State<ShowError> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500)).then(
        (value) => Meta().showMessage(context, message: widget.errorMessage));
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: SizedBox());
  }
}
