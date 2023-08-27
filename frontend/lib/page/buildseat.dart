import 'package:flutter/material.dart';
import 'package:frontend/widgets/seat.dart';

class BuildSeats extends StatefulWidget {
  const BuildSeats({
    super.key,
    required this.side,
    required this.rows,
    required this.seatStates,
  });
  final String side;
  final int rows;
  final dynamic seatStates;

  @override
  State<BuildSeats> createState() => _BuildSeatsState();
}

class _BuildSeatsState extends State<BuildSeats> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        width: 150,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.rows,
            itemBuilder: (context, i) => Row(
                  children: [
                    Seat(num: SeatNum(widget.side, 2 * i + 1)),
                    Seat(num: SeatNum(widget.side, 2 * i + 2)),
                  ],
                )),
      ),
    );
  }
}
