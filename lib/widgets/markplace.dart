// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import '../utils/fonts.dart';

final selectedroute = ValueNotifier<List<int>>([0]);

class MarkPlaces extends StatefulWidget {
  const MarkPlaces(
      {super.key,
      this.right,
      this.top,
      this.left,
      this.down,
      required this.id,
      required this.place});

  final double? right;
  final double? top;
  final double? left;
  final double? down;
  final String place;
  final int id;

  @override
  State<MarkPlaces> createState() => _MarkPlacesState();
}

class _MarkPlacesState extends State<MarkPlaces> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: widget.right,
        top: widget.top,
        left: widget.left,
        bottom: widget.down,
        height: 200,
        child: ValueListenableBuilder(
          valueListenable: selectedroute,
          builder: (context, route, child) {
            final isSelected = route.contains(widget.id);
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  route.remove(widget.id);
                  selectedroute.value = route;
                  selectedroute.notifyListeners();
                  setState(() {});
                } else {
                  route.add(widget.id);
                  selectedroute.value = route;
                  selectedroute.notifyListeners();
                  setState(() {});
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(" ${widget.place}",
                      style: MyFont.headline.copyWith(
                          color: isSelected ? Colors.pink : Colors.white,
                          fontSize: 12,
                          backgroundColor: Colors.black)),
                  SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset("assets/notselected.png"))
                ],
              ),
            );
          },
        ));
  }
}
