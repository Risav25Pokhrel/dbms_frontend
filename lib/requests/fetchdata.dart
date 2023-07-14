import 'package:frontend/requests/basefetching.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Requestdata extends Fetchdata {
  @override
  Future<dynamic> fetchtable(String host, String path) async {
    final response = await http.get(Uri.http(host, path));

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return response.body;
    } else {
      throw Exception('Failed to fetch table');
    }
  }

  @override
  Future<dynamic> getData(myclass, host, path) async {
    List<dynamic> out = [];
    final response = await fetchtable(host, path);
    for (var i in response) {
      out.add(myclass.fromJson(i[path]));
    }
    return out;
  }

  @override
  Future<dynamic> postData(myclass, body,host,path) {
    /// TODO: implement postData
    throw UnimplementedError();
  }
}
