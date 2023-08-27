import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class StopsDropdown extends StatelessWidget {
  const StopsDropdown({
    super.key,
    required this.labelText,
    required this.onChanged,
    required this.disabledItemFn,
    required this.defaultItem,
  });

  final int defaultItem;
  final String labelText;
  final void Function(String?) onChanged;
  final dynamic disabledItemFn;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSearchBox: false,
        showSelectedItems: true,
        disabledItemFn: disabledItemFn,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          icon: const Icon(Icons.location_pin),
          labelText: labelText,
          iconColor: Colors.indigo,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      asyncItems: (String _) async {
        List<String> list = [];
        final resp = await get(Uri.parse("http://localhost:8080/stops"));
        final json = jsonDecode(resp.body);
        for (int i = 0; i < json.length; i++) {
          list.add(json[i][0].toString());
        }
        list.sort();
        return list;
      },
      onChanged: onChanged,
    );
  }
}
