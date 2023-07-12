import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

Future<void> checkuser({required username, required password}) async {
  try {
    final response = await Dio().get("http://localhost:8080/users",
        options:
            Options(headers: {"username": username, "password": password}));
    debugPrint(response.data);
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> registerUser(
    {required username, required password, required phone}) async {
  final body = {
    "id":1,
    'name': 'sujan',
    'mobile': '1234567890',
    'password': 'password',
    'roleid': '1'
  };

  try {
    final response = await post(Uri.parse("http://localhost:8080/users"),
        body: jsonEncode(body));

    debugPrint(response.toString());
    debugPrint(response.statusCode.toString());
  } catch (e) {
    debugPrint(e.toString());
  }
}
