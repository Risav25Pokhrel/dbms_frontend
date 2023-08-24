import 'package:flutter/material.dart';
import 'package:frontend/page/bus.dart';
import 'package:frontend/page/tripselection.dart';
import 'package:frontend/requests/fetchdata.dart';
import 'package:frontend/routing/routing.dart';
import 'package:frontend/utils/fonts.dart';
import 'package:frontend/widgets/error.dart';
import 'package:frontend/widgets/progressindicator.dart';
import 'package:intl/intl.dart';

class BusList extends StatelessWidget {
  final double width;

  final ValueNotifier<bool> notifier;
  const BusList({super.key, required this.width, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, fromplace, child) {
          if (notifier.value = false) {
            return const Placeholder();
          }

          return FutureBuilder(
            future: getTripList(from, to, date),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MyProgressIndicator();
              }

              if (snapshot.hasError) {
                return ShowError(errorMessage: snapshot.error.toString());
              } else {
                return SizedBox(
                  width: width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final fmt = DateFormat('MMM dd E hh:mm');
                        final trip = snapshot.data![index][''];
                        final beg = trip['start_at'];
                        final end = trip['end_at'];
                        final dept = DateTime.parse(trip['departure']);
                        final arrt = DateTime.parse(trip['arrival']);
                        final diff = arrt.difference(dept);
                        final dep = fmt.format(dept);
                        final arr = fmt.format(arrt);
                        final dif = diff.toString().split('.').first;

                        return InkWell(
                          onTap: () => Routing().withoutReplacement(context,
                              page: BusView(trip: trip)),
                          child: Card(
                            child: ListTile(
                              title: Text(trip['bus_name'],
                                  style: MyFont.headline),
                              leading: const Icon(Icons.directions_bus),
                              subtitle: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(beg, style: MyFont.content),
                                          Text(dep, style: MyFont.content),
                                        ],
                                      ),
                                      Text(dif, style: MyFont.content),
                                      Column(
                                        children: [
                                          Text(end, style: MyFont.content),
                                          Text(arr, style: MyFont.content),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('Price: ${trip['price']}',
                                              style: MyFont.content),
                                          Text(
                                              'Seats: ${trip['available_seats']}',
                                              style: MyFont.content),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
            },
          );
        });
  }
}
