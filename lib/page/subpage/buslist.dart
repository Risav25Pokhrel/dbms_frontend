import 'package:flutter/material.dart';
import 'package:frontend/models.dart/trips.dart';
import 'package:frontend/page/bus.dart';
import 'package:frontend/requests/fetchdata.dart';
import 'package:frontend/routing/routing.dart';
import 'package:frontend/utils/fonts.dart';
import 'package:frontend/widgets/error.dart';
import 'package:frontend/widgets/progressindicator.dart';
import 'package:intl/intl.dart';

import '../../notifier.dart/notifiers.dart';
import '../../widgets/rich.dart';

class BusList extends StatelessWidget {
  const BusList({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: ValueListenableBuilder(
            valueListenable: date,
            builder: (context, dDate, child) => ValueListenableBuilder(
                valueListenable: to,
                builder: (context, toplace, child) => ValueListenableBuilder(
                    valueListenable: from,
                    builder: (context, fromplace, child) => FutureBuilder(
                          future: getBusList(
                              start: fromplace, end: toplace, date: dDate),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return const MyProgressIndicator();
                              default:
                                if (snapshot.hasError) {
                                  return ShowError(
                                      errorMessage: snapshot.error.toString());
                                } else {
                                  final format = DateFormat.yMMMMd('en_US');
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        Trips trips = snapshot.data![index];
                                        final date = format
                                            .format(
                                                DateTime.parse(trips.departure))
                                            .toString();

                                        return InkWell(
                                          onTap: () => Routing()
                                              .withoutReplacement(context,
                                                  page: BusView(tx: trips)),
                                          child: Card(
                                            child: ListTile(
                                              title: Text(trips.busName,
                                                  style: MyFont.headline),
                                              leading: Hero(
                                                tag: trips.busNumber,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.transparent,
                                                  backgroundImage: AssetImage(trips.imageUrl),
                                                )
                                              ),
                                              subtitle: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  myrich(
                                                      leading: "Price:- ",
                                                      trailing: trips.price
                                                          .toString(),
                                                      color: Colors.brown,
                                                      size: 17),
                                                  myrich(
                                                      leading:
                                                          "Departure Date:- ",
                                                      trailing: date,
                                                      size: 17),
                                                  myrich(
                                                      leading: "Arrival:- ",
                                                      size: 17,
                                                      trailing: format.format(
                                                          DateTime.parse(
                                                              trips.arrival))),
                                                  myrich(
                                                      leading:
                                                          "Available Seats:-",
                                                      trailing: trips
                                                          .availableSeats
                                                          .toString(),
                                                      size: 17)
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                            }
                          },
                        )))));
  }
}
