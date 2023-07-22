import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../utils/fonts.dart';

class NumberPlate extends StatelessWidget {
  const NumberPlate({super.key, required this.licensePlate});
  final String licensePlate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        child: Stack(
          children: [
            Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2, color: Colors.indigo),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 30.0,
                        offset: Offset(10, 10),
                        color: Colors.grey)
                  ]),
              child: AutoSizeText(licensePlate,
                  textAlign: TextAlign.center, style: MyFont.numberplate),
            ),
            Positioned(
                left: 8,
                top: 25,
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset("assets/flag.gif", fit: BoxFit.fill)))
          ],
        ),
      ),
    );
  }
}
