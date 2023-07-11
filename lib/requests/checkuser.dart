import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
