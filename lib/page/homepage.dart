import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? to;
    String? from;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Bus Ticket")),
      ),
      body: Center(
        child: Card(
          elevation: 50,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                StopsDropdown(
                  labelText: "From",
                  onChanged: (String? s) {
                    from = s;
                  },
                  disabledItemFn: (String s) => s == to,
                ),
                SizedBox(height: 10),
                StopsDropdown(
                  labelText: "To",
                  onChanged: (String? s) {
                    to = s;
                  },
                  disabledItemFn: (String s) => s == from,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StopsDropdown extends StatelessWidget {
  const StopsDropdown({
    super.key,
    required this.labelText,
    required this.onChanged,
    required this.disabledItemFn,
  });

  final labelText;
  final onChanged;
  final disabledItemFn;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSearchBox: true,
        showSelectedItems: true,
        disabledItemFn: disabledItemFn,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(labelText: this.labelText),
      ),
      asyncItems: (String _) async {
        final resp = await get(Uri.parse("http://localhost:8080/stops"));
        final json = jsonDecode(resp.body);
        final list = (json as List).map((e) => e[1] as String).toList();
        return list;
      },
      onChanged: onChanged,
    );
  }
}
