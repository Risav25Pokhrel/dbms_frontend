import 'package:flutter/material.dart';
import 'package:frontend/models.dart/tickets.dart';
import 'package:frontend/page/bus.dart';
import 'package:frontend/page/routepage.dart';
import 'package:frontend/requests/fetchdata.dart';
import 'package:frontend/routing/routing.dart';
import 'package:frontend/utils/fonts.dart';
import 'package:frontend/widgets/error.dart';
import 'package:frontend/widgets/progressindicator.dart';
import 'package:intl/intl.dart';

class BusList extends StatelessWidget {
  const BusList({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ValueListenableBuilder(
        valueListenable: to,
        builder: (context, toplace, child) => ValueListenableBuilder(
            valueListenable: from,
            builder: (context, fromplace, child) => FutureBuilder(
                  future: getBusList(start: fromplace, end: toplace),
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
                                Tickets ticket = snapshot.data![index];
                                final date = format
                                    .format(DateTime.parse(ticket.depttime))
                                    .toString();

                                return InkWell(
                                  onTap: () => Routing().withoutReplacement(
                                      context,
                                      page: BusView(tx: ticket)),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(ticket.bus.busname,
                                          style: MyFont.headline),
                                      leading: Hero(
                                        tag: ticket.bus.imageUrl,
                                        child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: AssetImage(
                                                "assets/${ticket.bus.imageUrl}")),
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(ticket.price,
                                              style: MyFont.content),
                                          Text(date, style: MyFont.content),
                                          Text(ticket.bus.type,
                                              style: MyFont.content)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                    }
                  },
                )),
      ),
    );
  }
}
