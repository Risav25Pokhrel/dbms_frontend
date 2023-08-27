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

Future<dynamic> getTakenSeats(int id) async {
  try {
    final req = Uri.http(baseUrl, "/taken_seats", {"trip_id": '$id'});
    final res = await get(req);
    final out = json.decode(res.body);
    return out;
  } catch (e) {
    print(e.toString());
  }
  return [];
}
