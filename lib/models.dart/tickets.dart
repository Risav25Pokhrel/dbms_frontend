import 'package:frontend/models.dart/bus.dart';

class Tickets {
  late Buses bus;
  late String depttime;
  late String price;

  Tickets({required this.bus, required this.depttime, required this.price});

  factory Tickets.fromJson(List<dynamic> json) {
    Tickets tickets = Tickets(
        depttime: json[2],
        price: json[3].toString(),
        bus: Buses.fromJson(json[5]));
    return tickets;
  }
}
