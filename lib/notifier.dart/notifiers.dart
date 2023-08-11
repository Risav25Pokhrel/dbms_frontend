import 'package:flutter/material.dart';

final Map<int, String> routeID = {
  0: "Kathmandu",
  1: "Pokhara",
  2: "Birjung",
  3: "Gaur",
  4: "Rajbiraj",
  5: "Janakpur",
  6: "Bardibas",
  7: "Dharan",
  8: "Biratnagar",
  9: "Damak",
  10: "Illam",
  11: "Kakadvitta"
};

final availableSeat = ValueNotifier<List<String>>([]);

final selectedSeat = ValueNotifier<List<String>>([]);
