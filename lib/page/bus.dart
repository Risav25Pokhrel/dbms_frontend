import 'package:flutter/material.dart';
import 'package:frontend/models.dart/tickets.dart';
import 'package:frontend/page/subpage/bookticket.dart';
import 'subpage/displaybus.dart';
import 'subpage/displayseat.dart';

class BusView extends StatelessWidget {
  const BusView({super.key, required this.tx});
  final Tickets tx;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DisplayBus(bus: tx.bus),
             DisplaySeat(bus: tx.bus),
             Fillform(tx:tx )
          ]),
    );
  }
}
