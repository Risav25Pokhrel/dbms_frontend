import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final List<TextInputFormatter>? formatter;
  final VoidCallback? todo;
  final String? Function(String?)? validator;

  const MyTextFormField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.prefixIcon,
      this.obscureText = false,
      this.formatter,
      this.validator,
      this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.justify,
        obscureText: obscureText,
        inputFormatters: formatter,
        onFieldSubmitted: (value) async => todo,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
