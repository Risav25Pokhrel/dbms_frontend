import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.labelText,
    required this.onChanged,
  });

  final String labelText;
  final void Function(String?) onChanged;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    widget.onChanged(controller.text);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enableInteractiveSelection: false,
      readOnly: true,
      decoration: InputDecoration(
        icon: const Icon(Icons.calendar_month),
        iconColor: Colors.indigo,
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      mouseCursor: SystemMouseCursors.click,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2024));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          widget.onChanged(formattedDate);
          setState(() {
            controller.text = formattedDate;
          });
        }
      },
    );
  }
}
