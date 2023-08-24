import 'package:flutter/material.dart';
import '../../utils/fonts.dart';
import '../../widgets/seat.dart';
import '../buildseat.dart';

class DisplaySeat extends StatelessWidget {
  const DisplaySeat({
    super.key,
    required this.rows,
    required this.taken,
  });

  final int rows;
  final List<dynamic> taken;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Bus Seat",
              style:
                  MyFont.headline.copyWith(fontSize: 40, color: Colors.brown)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 220),
              SizedBox(
                  height: 90, width: 90, child: Image.asset("assets/steer.png"))
            ],
          ),
          Text("Door", style: MyFont.headline),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 40),
              BuildSeats(side: "A", rows: rows),
              BuildSeats(side: "B", rows: rows),
            ],
          )
        ],
      ),
    );
  }
}
