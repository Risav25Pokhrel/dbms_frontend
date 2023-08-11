import 'package:flutter/material.dart';
import '../../models.dart/bus.dart';
import '../../utils/fonts.dart';

class DisplayBus extends StatelessWidget {
  const DisplayBus({
    super.key,
    required this.bus,
  });

  final Buses bus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(bus.busname,
                style: MyFont.headline
                    .copyWith(fontSize: 45, color: Colors.brown)),
          ),
          const Spacer(),
          Hero(tag: bus.url, child: Image.asset("assets/${bus.url}")),
          const Spacer(),
        ],
      ),
    );
  }
}
