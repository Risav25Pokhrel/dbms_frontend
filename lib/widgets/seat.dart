import 'package:flutter/material.dart';
import 'package:frontend/notifier.dart/notifiers.dart';

class Seat extends StatefulWidget {
  const Seat({
    super.key,
    required this.seatno,
  });

  final String seatno;

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  @override
  Widget build(BuildContext context) {
    Color seatColor = Colors.grey.shade500;
    return ValueListenableBuilder(
      valueListenable: availableSeat,
      builder: (BuildContext context, available, Widget? child) {
        bool isAvailable = available.contains(widget.seatno);
        if (isAvailable) {
          seatColor = Colors.green;
        }
        return ValueListenableBuilder(
            valueListenable: selectedSeat,
            builder: (context, selected, child) {
              final bool isSelected = selected.contains(widget.seatno);
              if (isSelected) {
                seatColor = Colors.amber;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: InkWell(
                  onTap: () {
                    if (isAvailable) {
                      if (isSelected) {
                        selected.remove(widget.seatno);
                      } else {
                        selected.add(widget.seatno);
                      }
                      selectedSeat.value = selected;
                      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                      selectedSeat.notifyListeners();
                      setState(() {});
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
                        Text(widget.seatno,
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
