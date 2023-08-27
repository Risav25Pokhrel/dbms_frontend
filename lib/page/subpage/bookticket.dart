import 'package:flutter/material.dart';
import 'package:frontend/utils/fonts.dart';
import 'package:frontend/widgets/mybutton.dart';
import 'package:frontend/widgets/myformfield.dart';
import 'package:intl/intl.dart';
import 'package:frontend/widgets/seat.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Fillform extends StatefulWidget {
  const Fillform({super.key, required this.trip, required this.seatStates});
  final Map<dynamic, dynamic> trip;
  final dynamic seatStates;

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
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ const SizedBox(height: 10),
          MyTextFormField(
              controller: name, labelText: 'Name', prefixIcon: Icons.person),
          MyTextFormField(
              controller: phone,
              labelText: 'Phone No.',
              prefixIcon: Icons.phone),
          _myRich(
              leading: 'Rate: ',
              trailing: 'Rs. ${widget.trip['price'].toString()}'),
          const Divider(thickness: 4),
          const SizedBox(height: 20),
          Center(
            child: MyButton(
              title: 'Book Ticket',
              onTap: () async {
                List<SeatNum> selected = [];
                widget.seatStates.forEach((k, v) {
                  if (v == SeatState.selected) {
                    final ll = k.length == 2 ? k[1] : k[1] + k[2];
                    selected.add(SeatNum(k[0], int.parse(ll)));
                  }
                });

                if (name.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter your name.")));
                } else if (phone.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter your phone number.")));
                } else if (selected.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please select atleast one seat.")));
                } else {
                  await _showTicket(context, selected);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _myRich(
      {required String leading,
      required String trailing,
      Color color = Colors.indigo}) {
    return Text.rich(TextSpan(style: MyFont.headline, text: leading, children: [
      TextSpan(style: MyFont.headline.copyWith(color: color), text: trailing)
    ]));
  }

  _showTicket(ctx, selected) async {
    await showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 250,
                width: 250,
                child: Image.asset('assets/${widget.trip['bus_img_url']}')),
            Text(widget.trip['bus_name'],
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
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _myRich(leading: 'Name: ', trailing: name.text),
                  _myRich(leading: 'Phone: ', trailing: phone.text)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _myRich(leading: 'Seats: ', trailing: selected.join(', ')),
                  _myRich(
                      leading: 'Bus Number',
                      trailing: widget.trip['bus_number'],
                      color: Colors.pink)
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _myRich(
                      color: Colors.red,
                      leading: 'Departure Date: ',
                      trailing: DateFormat.yMMMMd('en_US')
                          .format(DateTime.now())
                          .toString()),
                  _myRich(
                      color: Colors.red,
                      leading: 'Ticketing Date: ',
                      trailing: DateFormat.yMMMMd('en_US')
                          .format(DateTime.now())
                          .toString()),
                ],
              ),
              const SizedBox(height: 5),
              _myRich(
                  leading: 'Departure Time: ',
                  trailing: DateFormat('yyyy-MM-dd hh:mm')
                      .format(DateTime.parse(widget.trip['departure']))),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _myRich(
                      leading: 'Grand Total: ',
                      trailing:
                          'Rs. ${widget.trip['price'] * selected.length}'),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Image.asset('assets/qr.png'),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    title: 'Confirm',
                    onTap: () async {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();

                      final a = [];
                      final b = [];

                      for (final i in selected) {
                        a.add(i.num);
                        b.add(i.col);
                      }

                      final body = {
                        'name': name.text,
                        'phone': phone.text,
                        'seat_nums': a,
                        'seat_cols': b,
                        'trip_id': widget.trip['trip_id'],
                        'booking_time': DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
                      };

                      final resp = await post(Uri.http('localhost:8080', '/book'), body: json.encode(body));
                      final psid = json.decode(resp.body)[0][0];
                      await showDialog(
                        context: ctx,
                        builder: (context) => AlertDialog(
                          title: const Text("Success"),
                          content: Row(
                            children: [
                              Text("Created Booking With Passenger ID $psid"),
                              const SizedBox(width: 30),
                              TextButton(
                                child: const Text("Back To Home Page"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          )
                        )
                      );
                    },
                  ),
                  MyButton(
                    title: 'Cancel',
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
