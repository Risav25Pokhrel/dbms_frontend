import 'package:flutter/material.dart';
import 'package:frontend/utils/fonts.dart';
import 'package:frontend/page/subpage/buslist.dart';

import 'package:frontend/widgets/dropdown.dart';
import 'package:frontend/widgets/datepicker.dart';

String date = '';
String from = '';
String to = '';

final showList = ValueNotifier<bool>(false);

class TripSelection extends StatelessWidget {
  const TripSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Bagmati Bus Service",
              style: MyFont.headline.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white)),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 29, 38, 85),
        ),
        body: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
            ),
            SizedBox(
              width: size.width,
              height: 400,
              child: Image.asset("assets/newbackground.png",
                  fit: BoxFit.cover, filterQuality: FilterQuality.high),
            ),
            Positioned(
              width: size.width,
              height: 200,
              top: 310,
              child: Column(
                children: [
                  Text(
                    "Affordable Bus Travel from Bagmati Bus Service",
                    style: MyFont.headline.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 800,
                    height: 80,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.grey.shade300,
                          Colors.white,
                        ]),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 29, 38, 85),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: StopsDropdown(
                            defaultItem: 1,
                            labelText: "From",
                            onChanged: (String? s) {
                              if (s == null) return;
                              from = s;
                            },
                            disabledItemFn: (String s) => s == to,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: StopsDropdown(
                            defaultItem: 2,
                            labelText: "To",
                            onChanged: (String? s) {
                              if (s == null) return;
                              to = s;
                            },
                            disabledItemFn: (String s) => s == from,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: DatePicker(
                              labelText: "Departure",
                              onChanged: (String? s) {
                                if (s == null) return;
                                date = s;
                              }),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              fixedSize: const Size(100, 52),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          child: const Text("Search"),
                          onPressed: () {
                            if (from == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Please select a starting point.")),
                              );
                            } else if (to == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Please select a destination.")),
                              );
                            } else if (date == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Please select date of departure.")),
                              );
                            } else {
                              showList.value = true;
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 500,
              height: size.height - 600,
              child: Container(
                width: size.width,
                alignment: Alignment.topCenter,
                child: BusList(
                  notifier: showList,
                  width: 800,
                ),
              ),
            ),
          ],
        ));
  }
}
