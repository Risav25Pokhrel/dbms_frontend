import 'dart:convert';
import 'package:http/http.dart';

const String baseUrl = "localhost:8080";

Future<List<dynamic>> getTripList(String start, String end, String date) async {
  try {
    Uri request = Uri.http(baseUrl, "/trips",
        {"start_at": start, "end_at": end, "DATE(departure)": date});
    final resp = await get(request);
    return json.decode(resp.body);
  } catch (e) {
    print(e.toString());
  }
  return [];
}

Future<dynamic> getBusView(String lplate, int id) async {
  try {
    Uri req = Uri.http(baseUrl, "/bus_view",
        {"licenseplate": lplate, "trip_id": id.toString()});
    final res = await get(req);
    return json.decode(res.body);
  } catch (e) {
    print(e.toString());
  }
  return [];
}
