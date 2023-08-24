import 'package:flutter/material.dart';
import 'package:frontend/requests/fetchdata.dart';
import 'package:frontend/page/subpage/bookticket.dart';
import 'subpage/displaybus.dart';
import 'subpage/displayseat.dart';
import 'package:frontend/widgets/progressindicator.dart';
import 'package:frontend/widgets/error.dart';

class BusView extends StatelessWidget {
  const BusView({super.key, required this.trip});
  final Map<dynamic, dynamic> trip;

  @override
  Widget build(BuildContext context) {
    final id = trip['trip_id'];
    final lp = trip['bus_number'];
    final name = trip['bus_name'];

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getBusView(lp, id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MyProgressIndicator();
            }

            if (snapshot.hasError) {
              return ShowError(errorMessage: snapshot.error.toString());
            } else {
              final url = snapshot.data!['info'][0][0];
              final rows = snapshot.data!['info'][0][1];
              final taken = snapshot.data!['seats'];
              trip['bus_img_url'] = url;
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    DisplayBus(lp: lp, name: name, url: url),
                    DisplaySeat(rows: rows, taken: taken),
                    Fillform(trip: trip),
                  ]);
            }
          }),
    );
  }
}
