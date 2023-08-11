import 'package:flutter/material.dart';
import 'package:frontend/models.dart/bus.dart';
import 'package:frontend/page/subpage/bookticket.dart';

import 'subpage/displaybus.dart';
import 'subpage/displayseat.dart';

class BusView extends StatelessWidget {
  const BusView({super.key, required this.bus});
  final Buses bus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DisplayBus(bus: bus),
            DisplaySeat(bus: bus),
            Fillform(bus: bus)
          ]),
    );
  }
}
