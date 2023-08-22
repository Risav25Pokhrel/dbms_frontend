import 'dart:convert';
import 'package:http/http.dart' as http;

Future main() async {
  try {
    final request = Uri.http("localhost:8080", "/routes",
        {"start_at": "Kathmandu", "end_at": "Bara"});
    final response = await http.get(request);
    final data = jsonDecode(response.body);
    final routeid = data[0][0].toString();
    final request2 =
        Uri.http("localhost:8080", "/tickets", {"route_id": routeid});
    final response2 = await http.get(request2);
    List<dynamic> check = jsonDecode(response2.body);
    final request3 =
        Uri.http("localhost:8080", "/buses", {"licenseplate": check[0][1]});
    final response3 = await http.get(request3);
    final check2 = jsonDecode(response3.body);
    for (int i = 0; i < check.length; i++) {
      check[i].add(check2[i]);
    }
  } catch (e) {
    throw UnimplementedError();
  }
}
