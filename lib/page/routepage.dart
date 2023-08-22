import 'package:flutter/material.dart';
import 'package:frontend/page/subpage/buslist.dart';
import 'package:frontend/utils/fonts.dart';
import 'package:frontend/widgets/mycontainer.dart';
import 'package:frontend/widgets/showdestination.dart';
import 'package:intl/intl.dart';

import '../widgets/dropdown.dart';

final isNight = ValueNotifier<bool>(true);
final date = ValueNotifier<DateTime>(DateTime.now());
final from = ValueNotifier<String>('');
final to = ValueNotifier<String>('');

class RouteSelection extends StatelessWidget {
  const RouteSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Welcome To Nepal Bus Service"),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 29, 38, 85),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 390,
                    width: double.infinity,
                    child: Image.asset("assets/newbackground.png",
                        fit: BoxFit.fill, filterQuality: FilterQuality.high),
                  ),
                  Positioned(
                      bottom: -80,
                      right: size.width * 0.17,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Affordable bus travel from Nepal Bus",
                                    style: MyFont.headline.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.white)),
                                const SizedBox(height: 5),
                                Container(
                                  width: size.width * 0.7,
                                  height: 157,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.grey.shade300,
                                        Colors.white,
                                      ]),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 202, 217, 229),
                                            blurStyle: BlurStyle.outer,
                                            offset: Offset(12, 15))
                                      ],
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text("From", style: MyFont.headline),
                                          Text("To",
                                              style: MyFont.headline.copyWith(
                                                  color: Colors.blue,
                                                  fontSize: 30)),
                                          Text("Departure",
                                              style: MyFont.headline)
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Mycontainer(
                                            child: SizedBox(
                                              width: 200,
                                              child: StopsDropdown(
                                                labelText: "From",
                                                onChanged: (String? s) {
                                                  if (s == null) return;
                                                  from.value = s;
                                                },
                                                disabledItemFn: (String s) =>
                                                    s == to.value,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                String temp = from.value;
                                                from.value = to.value;
                                                to.value = temp;
                                              },
                                              icon: const Icon(Icons.swap_horiz,
                                                  size: 30)),
                                          Mycontainer(
                                            child: SizedBox(
                                              width: 200,
                                              child: StopsDropdown(
                                                labelText: "To",
                                                onChanged: (String? s) {
                                                  if (s == null) return;
                                                  to.value = s;
                                                },
                                                disabledItemFn: (String s) =>
                                                    s == from.value,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          ValueListenableBuilder(
                                            valueListenable: date,
                                            builder: (context, value, child) {
                                              final format =
                                                  DateFormat.yMMMMd('en_US');
                                              return TextButton.icon(
                                                  onPressed: () async {
                                                    final newdate =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate: value,
                                                            firstDate:
                                                                DateTime.now(),
                                                            lastDate:
                                                                DateTime(2030));
                                                    if (newdate == null) return;
                                                    date.value = newdate;
                                                  },
                                                  icon: const Icon(
                                                      Icons.calendar_month,
                                                      size: 25),
                                                  label: Text(
                                                      format
                                                          .format(value)
                                                          .toString(),
                                                      style: MyFont.content
                                                          .copyWith(
                                                              fontSize: 25)));
                                            },
                                          ),
                                          const SizedBox(width: 10)
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              const SizedBox(height: 100),
              SizedBox(
                  width: size.width * 0.7,
                  child: const ShowDestination(color: Colors.blue)),
              BusList(width: size.width * 0.7)
            ],
          ),
        ));
  }
}

myrich(
    {required String leading,
    required String trailing,
    Color color = Colors.indigo}) {
  return Text.rich(TextSpan(style: MyFont.headline, text: leading, children: [
    TextSpan(style: MyFont.headline.copyWith(color: color), text: trailing)
  ]));
}
