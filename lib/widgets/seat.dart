import 'package:flutter/material.dart';

class SeatNum {
  final String col;
  final int num;
  const SeatNum (this.col, this.num);
  @override
    String toString() {
      return '$col$num';
    }
}

final notifier = ValueNotifier<int>(0);

enum SeatState { taken, free, selected }

Map<dynamic, dynamic> seatStates = {};

class Seat extends StatefulWidget {
  const Seat({
    super.key,
    required this.num,
  });

  final SeatNum num;

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, map, _) {
          final value = seatStates[widget.num.toString()] as SeatState;
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
                      seatStates[widget.num.toString()] = SeatState.selected;
                      notifier.value ++;
                    });
                    return;
                  case SeatState.selected:
                    setState(() {
                      seatStates[widget.num.toString()] = SeatState.free;
                      notifier.value ++;
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
                    Text(widget.num.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
