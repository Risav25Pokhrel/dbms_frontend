import 'package:flutter/material.dart';
import 'package:frontend/notifier.dart/notifiers.dart';
import 'package:frontend/page/homepage.dart';
import 'package:frontend/routing/routing.dart';
import 'package:frontend/widgets/mybutton.dart';
import '../widgets/markplace.dart';

class RouteSelectionPage extends StatefulWidget {
  const RouteSelectionPage({super.key});

  @override
  State<RouteSelectionPage> createState() => _RouteSelectionPageState();
}

class _RouteSelectionPageState extends State<RouteSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 4,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          title: const ShowDestination(),
        ),
        floatingActionButton: SizedBox(
            width: 300,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(title: "Update", onTap: () => setState(() {})),
                MyButton(title: "Query", onTap: ()=>Routing().withoutReplacement(context, page: const Mainpage(path: 'buses')))
              ],
            )),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal,
              Colors.grey,
            ],
          )),
          child: Align(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset("assets/NepalMap.png",
                      filterQuality: FilterQuality.high, fit: BoxFit.fitWidth),
                ),
                const MarkPlaces(
                    place: "Kathmandu", right: 360, top: 330, id: 0),
                const MarkPlaces(place: "Pokhara", left: 600, down: 230, id: 1),
                const MarkPlaces(
                    place: "Birjung", right: 460, down: 100, id: 2),
                const MarkPlaces(place: "Gaur", right: 400, down: 60, id: 3),
                const MarkPlaces(
                    place: "Rajbiraj", right: 230, down: 20, id: 4),
                const MarkPlaces(
                    place: "Janakpur", right: 290, down: 20, id: 5),
                const MarkPlaces(place: "Bardibas", right: 185, down: 8, id: 6),
                const MarkPlaces(place: "Dharan", right: 120, down: 30, id: 7),
                const MarkPlaces(
                    place: "Biratnagar", right: 100, top: 505, id: 8),
                const MarkPlaces(place: "Damak", right: 75, top: 480, id: 9),
                const MarkPlaces(place: "Illam", right: 30, down: 60, id: 10),
                const MarkPlaces(
                    place: "Kakadvitta", right: -10, down: 10, id: 11),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowDestination extends StatelessWidget {
  const ShowDestination({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selected,
      builder: (context, value, child) {
        String from;
        List<String> to = [];
        try {
          from = routeID[value[0]]!;
        } catch (e) {
          from = '';
        }
        try {
          for (int i = 0; i < value.length; i++) {
            if (i != 0) {
              to.add(routeID[value[i]]!);
            }
          }
        } catch (e) {
          to = [];
        }
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("FROM : $from"), Text("To: ${to.toString()}")]);
      },
    );
  }
}
