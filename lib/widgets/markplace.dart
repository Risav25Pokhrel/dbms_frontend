import 'package:flutter/material.dart';
import 'package:frontend/page/routepage.dart';
import '../utils/fonts.dart';

final selected = ValueNotifier<List<int>>([0, 9, 11]);

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
          valueListenable: selected,
          builder: (context, route, child) {
            debugPrint(route.toString());
            final isSelected = route.contains(widget.id);
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  route.remove(widget.id);
                  selected.value = route;
                  setState(() {
                    const ShowDestination();
                  });
                } else {
                  route.add(widget.id);
                  selected.value = route;
                  setState(() {});
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(" ${widget.place}",
                      style: MyFont.headline.copyWith(
                          color:
                              isSelected ? Colors.yellowAccent : Colors.white,
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
