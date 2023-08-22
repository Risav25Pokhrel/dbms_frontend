import 'dart:convert';
import 'dart:developer';
import 'package:frontend/models.dart/tickets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

typedef AvailableBus = List<Tickets>;
const String baseUrl = "localhost:8080";
Future<AvailableBus> getBusList(
    {required String start, required String end}) async {
  AvailableBus buses = [];
  try {
    /*********************Get Route ID******************************/
    Uri request =
        Uri.http(baseUrl, "/routes", {"start_at": start, "end_at": end});
    Response response = await http.get(request);

    /************************Get Available Bus*************************************/
    request = Uri.http(baseUrl, "/tickets",
        {"route_id": jsonDecode(response.body)[0][0].toString()});

    response = await http.get(request);
    List<dynamic> ticket = jsonDecode(response.body);
    /***************************Get total Info***************************************/
    for (int i = 0; i < ticket.length; i++) {
      request = Uri.http(baseUrl, "/buses", {"licenseplate": ticket[i][1]});
      response = await http.get(request);
      ticket[i].add(jsonDecode(response.body)[0]);
    }
    /********************Change to Ticket Module*******************************/
    for (var i in ticket) {
      buses.add(Tickets.fromJson(i));
    }
  } catch (e) {
    log(e.toString());
  }
  return buses;
}
