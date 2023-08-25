import 'package:flutter/material.dart';
import 'package:frontend/models.dart/trips.dart';
import 'package:frontend/notifier.dart/notifiers.dart';
import 'package:frontend/utils/fonts.dart';
import 'package:frontend/widgets/messenger.dart';
import 'package:frontend/widgets/mybutton.dart';
import 'package:frontend/widgets/myformfield.dart';
import 'package:frontend/widgets/showdestination.dart';
import 'package:intl/intl.dart';
import '../../widgets/rich.dart';

class Fillform extends StatefulWidget {
  const Fillform({super.key, required this.tx});

  final Trips tx;
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
      width: 500,
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
              leading: "Rate:-", trailing: "RS. ${widget.tx.price.toString()}"),
          const Divider(thickness: 4),
          mytotalrate(widget.tx),
          const SizedBox(height: 20),
          Center(
            child: MyButton(
              title: "Book Ticket",
              onTap: () async {
                await showTicket(context, widget.tx, name.text.toString(),
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
mytotalrate(Trips tx) {
  return ValueListenableBuilder(
    valueListenable: selectedSeat,
    builder: (BuildContext context, dynamic value, Widget? child) {
      final int total = value.length * tx.price;
      return myrich(
          leading: "Grand Total:-", trailing: "RS. ${total.toString()}");
    },
  );
}

showTicket(ctx, Trips tx, String name, String phone) async {
  final datetime = DateTime.parse(tx.departure);
  final depttime = DateFormat('jm').format(datetime);

  await showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 250, width: 250, child: Image.asset(tx.imageUrl)),
          Text(tx.busName,
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
            const SizedBox(
                width: 600, child: ShowDestination(color: Colors.brown)),
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
                    trailing: tx.busNumber,
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
                    trailing:
                        DateFormat.yMMMMd('en_US').format(datetime).toString()),
                myrich(
                    color: Colors.red,
                    leading: "Ticketing Date:-",
                    trailing: DateFormat.yMMMMd('en_US')
                        .format(DateTime.now())
                        .toString()),
              ],
            ),
            const SizedBox(height: 5),
            myrich(leading: "Departure Time:-", trailing: depttime),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mytotalrate(tx),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.asset("assets/qr.png"),
                )
              ],
            ),
            MyButton(
              title: "Confirm",
              onTap: () {
                for (var i in selectedSeat.value) {
                  availableSeat.value.remove(i);
                }
                selectedSeat.value = [];
                Navigator.pop(context);
                Meta().showMessage(ctx,
                    message: "Ticket Booked for $name", color: Colors.green);
              },
            )
          ],
        ),
      ),
    ),
  );
}
