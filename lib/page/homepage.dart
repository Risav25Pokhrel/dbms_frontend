import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/requests/fetchdata.dart';
import 'package:frontend/utils/fonts.dart';
import 'package:frontend/widgets/error.dart';
import 'package:frontend/widgets/numberplate.dart';
import 'package:frontend/widgets/progressindicator.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Requestdata().getBusData(path),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: MyProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const ShowError();
            } else {
              var data = snapshot.data;
              return SizedBox(
                width: 1000,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    shrinkWrap: true,
                    itemCount: data!.length,
                    itemBuilder: (context, index) => Card(
                        color: Colors.white.withOpacity(0.6),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            children: [
                              Center(
                                child: AutoSizeText(data[index].busname,
                                    style:
                                        MyFont.headline.copyWith(fontSize: 28)),
                              ),
                              const SizedBox(height: 10),
                              AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.asset(data[index].url)),
                              Row(
                                children: [
                                  NumberPlate(
                                      licensePlate: data[index].licensePlate),
                                  SizedBox(
                                    height: 60,
                                    child: Column(
                                      children: [
                                        Text(data[index].type.toUpperCase(),
                                            style: MyFont.content.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        Text(
                                            "Capacity:-${data[index].capacity}",
                                            style: MyFont.content)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const Text("TODO//:route"),
                              const Text("Todo date")
                            ],
                          ),
                        ))),
              );
            }
        }
      },
    );
  }
}
