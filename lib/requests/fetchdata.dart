import 'dart:convert';
import 'package:frontend/models.dart/bus.dart';
import 'package:frontend/requests/basefetching.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Requestdata extends Fetchdata {
  @override
  Future<dynamic> fetchtable(String host, String path) async {
    final response = await http.get(Uri.http(host, path));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch table');
    }
  }

  Future<List<Buses>> getBusData(path, {host = "localhost:8080"}) async {
    List<Buses> out = [];
    try {
      final response = await fetchtable(host, path);
      debugPrint(response.toString());
      for (var i in response) {
        out.add(Buses.fromJson(i[path]));
      }
    } catch (e) {
      debugPrint(e.toString());
      throw UnimplementedError();
    }
    return out;
  }

  @override
  Future<dynamic> postData(myclass, path, {host = "localhost:8080"}) async {
    final body = myclass.toJson();
    try {
      final response = await post(Uri.http(host, path), body: jsonEncode(body));
      return response.body;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
