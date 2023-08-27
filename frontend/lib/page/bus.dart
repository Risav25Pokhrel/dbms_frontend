import 'package:flutter/material.dart';
import 'package:frontend/requests/fetchdata.dart';
import 'package:frontend/page/subpage/bookticket.dart';
import 'subpage/displaybus.dart';
import 'subpage/displayseat.dart';
import 'package:frontend/widgets/progressindicator.dart';
import 'package:frontend/widgets/error.dart';
import 'package:frontend/widgets/seat.dart';

class BusView extends StatefulWidget {
  const BusView({super.key, required this.trip});
  final Map<dynamic, dynamic> trip;

  @override
  State<BusView> createState() => _BusViewState();
}

class _BusViewState extends State<BusView> {
  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;
    final id = trip['trip_id'];
    final lp = trip['bus_number'];
    final url = trip['bus_img_url'];
    final name = trip['bus_name'];
    final rows = trip['bus_rows'];

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getTakenSeats(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MyProgressIndicator();
            }

            if (snapshot.hasError) {
              return ShowError(errorMessage: snapshot.error.toString());
            } else {

              seatStates = {};

              for (int i = 0; i < rows; i++) {
                final a1 = SeatNum('A', 2 * i + 1);
                final a2 = SeatNum('A', 2 * i + 2);
                final b1 = SeatNum('B', 2 * i + 1);
                final b2 = SeatNum('B', 2 * i + 2);
                seatStates[a1.toString()] = SeatState.free;
                seatStates[a2.toString()] = SeatState.free;
                seatStates[b1.toString()] = SeatState.free;
                seatStates[b2.toString()] = SeatState.free;
              }

              for (final i in snapshot.data!) {
                final s = SeatNum(i[0], i[1]);
                seatStates[s.toString()] = SeatState.taken;
              }

              notifier.value++;

              return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DisplayBus(lp: lp, name: name, url: url),
                    DisplaySeat(rows: rows, seatStates: seatStates),
                    Fillform(trip: trip, seatStates: seatStates),
                  ]);
            }
          }),
    );
  }
}
