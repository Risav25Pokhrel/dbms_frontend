import 'dart:convert';
import 'dart:developer';
import 'package:frontend/models.dart/trips.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

typedef AvailableBus = List<Trips>;
const String baseUrl = "localhost:8080";
Future<AvailableBus> getBusList(
    {required String start,
    required String end,
    required DateTime date}) async {
  AvailableBus buses = [];
  // List<dynamic> businfo = [];
  try {
    final format = DateFormat('yyyy-MM-dd');
    final formatteddate = format.format(date);
    final request = Uri.http(baseUrl, '/trips',
        {"start_at": start, "end_at": end, "DATE(departure)": formatteddate});
    final response = await get(request);

    final data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      Uri request2 = Uri.http(
          baseUrl, '/bus_info', {"licenseplate": data[i]['']['bus_number']});
      Response data2 = await get(request2);
      data[i]['']['image_url'] = "assets/${jsonDecode(data2.body)[0][0]}";
      data[i]['']['rows'] = jsonDecode(data2.body)[0][1];
    }
    for (var i in data) {
      buses.add(Trips.fromJson(i['']));
    }
  } catch (e) {
    log(e.toString());
  }
  return buses;
}
