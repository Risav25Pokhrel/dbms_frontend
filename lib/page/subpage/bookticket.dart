import 'package:flutter/material.dart';
import 'package:frontend/models.dart/bus.dart';
import 'package:frontend/notifier.dart/notifiers.dart';
import 'package:frontend/utils/fonts.dart';
import 'package:frontend/widgets/mybutton.dart';
import 'package:frontend/widgets/myformfield.dart';
import 'package:frontend/widgets/showdestination.dart';
import 'package:intl/intl.dart';

class Fillform extends StatefulWidget {
  const Fillform({super.key, required this.bus});

  final Buses bus;
  @override
  State<Fillform> createState() => _FillformState();
}

class _FillformState extends State<Fillform> {
  final name = TextEditingController();
  final phone = TextEditingController();
  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.yMMMMd('en_US');
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(format.format(DateTime.now()).toString(),
              style: MyFont.headline.copyWith(fontSize: 18)),
          const SizedBox(height: 10),
          const ShowDestination(color: Colors.indigo),
          const SizedBox(height: 10),
          MyTextFormField(
              controller: name, labelText: "Name", prefixIcon: Icons.person),
          MyTextFormField(
              controller: phone,
              labelText: "Phone no.",
              prefixIcon: Icons.phone),
          myseats(),
          myrich(
              leading: "Rate:-", trailing: "RS. ${widget.bus.rate.toString()}"),
          const Divider(thickness: 4),
          mytotalrate(widget.bus),
          const SizedBox(height: 20),
          Center(
            child: MyButton(
              title: "Book Ticket",
              onTap: () async {
                await showTicket(context, widget.bus, name.text.toString(),
                    phone.text.toString());
              },
            ),
          )
        ],
      ),
    );
  }
}

myseats() => ValueListenableBuilder(
      valueListenable: selectedSeat,
      builder: (BuildContext context, dynamic value, Widget? child) {
        return myrich(
            leading: "Seats:-",
            trailing: value.toString().replaceAll("[", "").replaceAll("]", ""));
      },
    );
mytotalrate(Buses bus) {
  return ValueListenableBuilder(
    valueListenable: selectedSeat,
    builder: (BuildContext context, dynamic value, Widget? child) {
      final double total = value.length * bus.rate;
      return myrich(
          leading: "Grand Total:-", trailing: "RS. ${total.toString()}");
    },
  );
}

myrich(
    {required String leading,
    required String trailing,
    Color color = Colors.indigo}) {
  return Text.rich(TextSpan(style: MyFont.headline, text: leading, children: [
    TextSpan(style: MyFont.headline.copyWith(color: color), text: trailing)
  ]));
}

showTicket(ctx, Buses bus, String name, String phone) async {
  await showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 250, width: 250, child: Image.asset("assets/${bus.url}")),
          Text(bus.busname,
              style:
                  MyFont.headline.copyWith(fontSize: 55, color: Colors.teal)),
        ],
      ),
      content: SizedBox(
        height: 240,
        width: 800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
                width: 400, child: ShowDestination(color: Colors.brown)),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myrich(leading: "Name:- ", trailing: name),
                myrich(leading: "Phone:- ", trailing: phone)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myseats(),
                myrich(
                    leading: "Bus Number:- ",
                    trailing: bus.licensePlate,
                    color: Colors.pink)
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myrich(
                    color: Colors.red,
                    leading: "Departure Date:-",
                    trailing: DateFormat.yMMMMd('en_US')
                        .format(DateTime.now())
                        .toString()),
                myrich(
                    color: Colors.red,
                    leading: "Ticketing Date:-",
                    trailing: DateFormat.yMMMMd('en_US')
                        .format(DateTime.now())
                        .toString()),
              ],
            ),
            const SizedBox(height: 5),
            myrich(leading: "Departure Time:-", trailing: bus.deptime),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mytotalrate(bus),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.asset("assets/qr.png"),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
