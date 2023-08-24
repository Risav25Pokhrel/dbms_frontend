import 'package:flutter/material.dart';
import 'package:frontend/notifier.dart/notifiers.dart';
import 'package:frontend/utils/fonts.dart';
import 'package:frontend/widgets/mybutton.dart';
import 'package:frontend/widgets/myformfield.dart';
import 'package:intl/intl.dart';

class Fillform extends StatefulWidget {
  const Fillform({super.key, required this.trip});
  final Map<dynamic, dynamic> trip;

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
          const SizedBox(height: 10),
          MyTextFormField(
              controller: name, labelText: "Name", prefixIcon: Icons.person),
          MyTextFormField(
              controller: phone,
              labelText: "Phone no.",
              prefixIcon: Icons.phone),
          myseats(),
          myrich(
              leading: "Rate:-",
              trailing: "RS. ${widget.trip['price'].toString()}"),
          const Divider(thickness: 4),
          mytotalrate(widget.trip['price']),
          const SizedBox(height: 20),
          Center(
            child: MyButton(
              title: "Book Ticket",
              onTap: () async {
                await showTicket(context, widget.trip, name.text.toString(),
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

mytotalrate(int price) {
  return ValueListenableBuilder(
    valueListenable: selectedSeat,
    builder: (BuildContext context, dynamic value, Widget? child) {
      final double total = value.length * price;
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

showTicket(ctx, Map<dynamic, dynamic> tr, String name, String phone) async {
  await showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 250,
              width: 250,
              child: Image.asset("assets/${tr['bus_img_url']}")),
          Text(tr['bus_name'],
              style:
                  MyFont.headline.copyWith(fontSize: 55, color: Colors.teal)),
        ],
      ),
      content: SizedBox(
        height: 300,
        width: 800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myrich(leading: "Name:- ", trailing: name.toUpperCase()),
                myrich(leading: "Phone:- ", trailing: phone)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myseats(),
                myrich(
                    leading: "Bus Number:- ",
                    trailing: tr['bus_number'],
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
            myrich(
                leading: "Departure Time:-",
                trailing: DateFormat('yyyy-MM-dd hh:mm')
                    .format(DateTime.parse(tr['departure']))),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mytotalrate(tr['price']),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.asset("assets/qr.png"),
                )
              ],
            ),
            MyButton(
              title: "Confirm",
              onTap: () {},
            )
          ],
        ),
      ),
    ),
  );
}
