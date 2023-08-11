import 'package:flutter/material.dart';
import 'package:frontend/widgets/seat.dart';

class BuildSeats extends StatelessWidget {
  const BuildSeats({super.key, required this.side, required this.size});

  final String side;
  final int size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        width: 150,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: (size ~/ 4).toInt(),
            itemBuilder: (context, i) => Row(
                  children: [
                    Seat(seatno: side + (2 * i + 1).toString()),
                    Seat(seatno: side + (2 * i + 2).toString()),
                  ],
                )),
      ),
    );
  }
}
