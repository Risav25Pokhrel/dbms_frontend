import 'package:flutter/material.dart';
import 'package:frontend/widgets/progressindicator.dart';

class Mainpage<T> extends StatelessWidget {
  const Mainpage({super.key, required this.myclass, required this.path});

  final Object myclass;
  final String path;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: MyProgressIndicator());
          default:
            if (snapshot.hasData) {
              return const Center(child: Text("connection has been done"));
            } else {
              return const SizedBox();
            }
        }
      },
    );
  }
}
