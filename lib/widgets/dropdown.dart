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
  });

  final String labelText;
  final dynamic onChanged;
  final dynamic disabledItemFn;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSearchBox: true,
        showSelectedItems: true,
        disabledItemFn: disabledItemFn,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(labelText: labelText),
      ),
      asyncItems: (String _) async {
        List<String> list = [];
        final resp = await get(Uri.parse("http://localhost:8080/stops"));
        final json = jsonDecode(resp.body);
        for (int i = 0; i < json.length; i++) {
          list.add(json[i][0].toString());
        }
        return list;
      },
      onChanged: onChanged,
    );
  }
}
