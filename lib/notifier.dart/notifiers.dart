import 'package:flutter/material.dart';

final availableSeat = ValueNotifier<List<String>>(['K1','B1','A3','A9','B10','B4','A7','A8','A9','A12','A1','A2','A3']);

final selectedSeat = ValueNotifier<List<String>>([]);

final date = ValueNotifier<DateTime>(DateTime.now());

final from = ValueNotifier<String>('');

final to = ValueNotifier<String>('');
