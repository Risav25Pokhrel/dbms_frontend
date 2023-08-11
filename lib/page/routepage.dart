import 'package:flutter/material.dart';
import 'package:frontend/page/homepage.dart';
import 'package:frontend/routing/routing.dart';
import 'package:frontend/widgets/mybutton.dart';
import '../widgets/markplace.dart';
import '../widgets/showdestination.dart';

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
        backgroundColor: Colors.transparent,
        extendBody: true,
        extendBodyBehindAppBar: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          elevation: 0,
          title: const ShowDestination(),
          backgroundColor: Colors.transparent,
        ),
        floatingActionButton: SizedBox(
            width: 300,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(
                    title: "Query",
                    color: Colors.redAccent,
                    onTap: () => Routing().withoutReplacement(context,
                        page: const Mainpage(path: "buses")))
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
                    place: "Kathmandu", right: 420, top: 400, id: 0),
                const MarkPlaces(
                    place: "Pokhara", right: 680, down: 300, id: 1),
                const MarkPlaces(
                    place: "Birjung", right: 530, down: 120, id: 2),
                const MarkPlaces(place: "Gaur", right: 470, down: 80, id: 3),
                const MarkPlaces(
                    place: "Rajbiraj", right: 300, down: 40, id: 4),
                const MarkPlaces(
                    place: "Janakpur", right: 370, down: 50, id: 5),
                const MarkPlaces(
                    place: "Bardibas", right: 195, down: 18, id: 6),
                const MarkPlaces(place: "Dharan", right: 140, down: 50, id: 7),
                const MarkPlaces(
                    place: "Biratnagar", right: 120, down: 0, id: 8),
                const MarkPlaces(place: "Damak", right: 87, down: 20, id: 9),
                const MarkPlaces(place: "Illam", right: 30, down: 60, id: 10),
                const MarkPlaces(
                    place: "Kakadvitta", right: 5, down: 10, id: 11),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void confirmation() async => await showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         height: 150,
  //         color: Colors.white,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             const ShowDestination(),
  //             const SizedBox(height: 30),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 MyButton(
  //                     onTap: () => Routing().withoutReplacement(context,
  //                         page: const Mainpage(path: "buses")),
  //                     title: "Confirm"),
  //                 MyButton(
  //                     onTap: () => Navigator.of(context).pop(), title: "Cancel")
  //               ],
  //             )
  //           ],
  //         ),
  //       );
  //     });
}
