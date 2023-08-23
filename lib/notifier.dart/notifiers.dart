import 'package:flutter/material.dart';

final availableSeat = ValueNotifier<List<String>>([]);

final selectedSeat = ValueNotifier<List<String>>([]);

final date = ValueNotifier<DateTime>(DateTime.now());

final from = ValueNotifier<String>('');

final to = ValueNotifier<String>('');
