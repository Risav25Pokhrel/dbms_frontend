import 'package:flutter/material.dart';
import 'package:frontend/page/routepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Core());
}

class Core extends StatelessWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const RouteSelection(),
    );
  }
}
