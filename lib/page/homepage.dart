// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/notifier.dart/notifiers.dart';
// import 'package:frontend/page/bus.dart';
// import 'package:frontend/routing/routing.dart';
// import 'package:frontend/utils/fonts.dart';
// import 'package:frontend/widgets/error.dart';
// import 'package:frontend/widgets/numberplate.dart';
// import 'package:frontend/widgets/progressindicator.dart';

// import '../widgets/showdestination.dart';

// class Mainpage extends StatelessWidget {
//   const Mainpage({super.key, required this.path});
//   final String path;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Requestdata().getBusData(path),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return const Center(child: MyProgressIndicator());
//           default:
//             if (snapshot.hasError) {
//               return ShowError(errorMessage: snapshot.error.toString());
//             } else {
//               var data = snapshot.data;
//               return Scaffold(
//                 appBar: AppBar(
//                   title: const ShowDestination(),
//                 ),
//                 body: Center(
//                   child: SizedBox(
//                     width: 1170,
//                     child: GridView.builder(
//                         scrollDirection: Axis.vertical,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 3),
//                         shrinkWrap: true,
//                         itemCount: data!.length,
//                         itemBuilder: (context, index) => Card(
//                             color: Colors.white.withOpacity(0.6),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Center(
//                                     child: AutoSizeText(data[index].busname,
//                                         style: MyFont.headline
//                                             .copyWith(fontSize: 24)),
//                                   ),
//                                   const SizedBox(height: 3),
//                                   InkWell(
//                                     onTap: () {
//                                       selectedSeat.value = [];
//                                       availableSeat.value =
//                                           data[index].availableSeat;
//                                       Routing().withoutReplacement(context,
//                                           page: BusView(
//                                             bus: data[index],
//                                           ));
//                                     },
//                                     child: AspectRatio(
//                                         aspectRatio: 16 / 9,
//                                         child: Hero(
//                                           tag: data[index].url,
//                                           child: Image.asset(
//                                               "assets/${data[index].url}"),
//                                         )),
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       NumberPlate(
//                                           licensePlate:
//                                               data[index].licensePlate),
//                                       SizedBox(
//                                         height: 60,
//                                         child: Column(
//                                           children: [
//                                             Text(data[index].type.toUpperCase(),
//                                                 style: MyFont.content.copyWith(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18)),
//                                             Text(
//                                                 "Capacity:-${data[index].capacity}",
//                                                 style: MyFont.content)
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 60,
//                                         child: Column(
//                                           children: [
//                                             Text("Available Seats",
//                                                 style: MyFont.content.copyWith(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18)),
//                                             Text(
//                                                 data[index]
//                                                     .availableSeat
//                                                     .length
//                                                     .toString(),
//                                                 style: MyFont.content)
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Text.rich(
//                                       style: MyFont.headline
//                                           .copyWith(fontSize: 18),
//                                       TextSpan(text: "From:-", children: [
//                                         TextSpan(
//                                             text: routeID[data[index].route[0]]
//                                                 .toString(),
//                                             style: MyFont.content
//                                                 .copyWith(color: Colors.teal)),
//                                       ])),
//                                   Text.rich(
//                                       style: MyFont.headline
//                                           .copyWith(fontSize: 18),
//                                       TextSpan(text: "To:-", children: [
//                                         for (int i = 1;
//                                             i < data[index].route.length;
//                                             i++)
//                                           TextSpan(
//                                               text:
//                                                   "${routeID[data[index].route[i]]} ",
//                                               style: MyFont.content.copyWith(
//                                                   color: Colors.teal,
//                                                   overflow:
//                                                       TextOverflow.ellipsis))
//                                       ]))
//                                 ],
//                               ),
//                             ))),
//                   ),
//                 ),
//               );
//             }
//         }
//       },
//     );
//   }
// }
