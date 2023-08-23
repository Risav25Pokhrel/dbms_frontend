import 'package:flutter/material.dart';
import 'package:frontend/models.dart/trips.dart';
import 'package:frontend/page/subpage/bookticket.dart';
import 'subpage/displaybus.dart';
import 'subpage/displayseat.dart';

class BusView extends StatelessWidget {
  const BusView({super.key, required this.tx});
  final Trips tx;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DisplayBus(tx: tx),
             DisplaySeat(tx: tx),
             Fillform(tx:tx)
          ]),
    );
  }
}
