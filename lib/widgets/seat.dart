import 'package:flutter/material.dart';

Map<String, ValueNotifier<SeatState>> seatStates = {};

enum SeatState { taken, free, selected }

class Seat extends StatefulWidget {
  const Seat({
    super.key,
    required this.num,
  });

  final String num;

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: seatStates[widget.num]!,
        builder: (context, value, _) {
          Color seatColor = switch (value) {
            SeatState.taken => Colors.red,
            SeatState.free => Colors.blue,
            SeatState.selected => Colors.green,
          };
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: InkWell(
              onTap: () {
                switch (value) {
                  case SeatState.taken:
                    return;
                  case SeatState.free:
                    setState(() {
                      seatStates[widget.num]?.value = SeatState.selected;
                    });
                    return;
                  case SeatState.selected:
                    setState(() {
                      seatStates[widget.num]?.value = SeatState.free;
                    });
                    return;
                }
              },
              child: Container(
                height: 53,
                width: 40,
                decoration: BoxDecoration(
                    color: seatColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: Colors.black)),
                child: Column(
                  children: [
                    const Icon(Icons.chair_outlined, size: 29),
                    Text(widget.num,
                        style: const TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
