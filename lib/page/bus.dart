import 'package:flutter/material.dart';
import 'package:frontend/requests/fetchdata.dart';
import 'package:frontend/page/subpage/bookticket.dart';
import 'subpage/displaybus.dart';
import 'subpage/displayseat.dart';
import 'package:frontend/widgets/progressindicator.dart';
import 'package:frontend/widgets/error.dart';
import 'package:frontend/widgets/seat.dart';

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
              trip['bus_img_url'] = url;

              for (var i = 0; i < rows; i++) {
                final a1 = 'A${2 * i + 1}';
                final a2 = 'A${2 * i + 2}';
                final b1 = 'B${2 * i + 1}';
                final b2 = 'B${2 * i + 2}';
                seatStates[a1] = ValueNotifier<SeatState>(SeatState.free);
                seatStates[a2] = ValueNotifier<SeatState>(SeatState.free);
                seatStates[b1] = ValueNotifier<SeatState>(SeatState.free);
                seatStates[b2] = ValueNotifier<SeatState>(SeatState.free);
              }

              snapshot.data!['seats'].map((i) {
                seatStates[i[0]]?.value = SeatState.taken;
              });

              return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DisplayBus(lp: lp, name: name, url: url),
                    DisplaySeat(rows: rows),
                    Fillform(trip: trip),
                  ]);
            }
          }),
    );
  }
}
