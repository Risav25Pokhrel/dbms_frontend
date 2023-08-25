import 'package:flutter/material.dart';
import 'package:frontend/models.dart/trips.dart';
import 'package:frontend/widgets/numberplate.dart';
import '../../utils/fonts.dart';

class DisplayBus extends StatelessWidget {
  const DisplayBus({
    super.key,
    required this.tx,
  });

  final Trips tx;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NumberPlate(licensePlate: tx.busNumber),
                Text(tx.busName,
                    style: MyFont.headline
                        .copyWith(fontSize: 45, color: Colors.brown)),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
              height: 550,
              width: 550,
              child: Hero(tag: tx.busNumber, child: Image.asset(tx.imageUrl))),
          const Spacer(),
        ],
      ),
    );
  }
}
