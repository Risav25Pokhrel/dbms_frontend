import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/page/homepage.dart';
import 'package:http/http.dart' as http;

typedef DatabaseTable = List<dynamic>;
Future<DatabaseTable> fetchTable(String host, String path) async {
  final response = await http.get(Uri.http(host, path));

  if (response.statusCode == 200) {
    final out = jsonDecode(response.body);
    debugPrint(out.toString());
    return out;
  } else {
    throw Exception('Failed to fetch table');
  }
}

class DisplayDatabaseTable extends StatefulWidget {
  final String host, path;
  const DisplayDatabaseTable(this.host, this.path, {super.key});

  @override
  State<DisplayDatabaseTable> createState() => _DisplayDatabaseTableState();
}

class _DisplayDatabaseTableState extends State<DisplayDatabaseTable> {
  late Future<DatabaseTable> futureTable;

  @override
  void initState() {
    super.initState();
    futureTable = fetchTable(widget.host, widget.path);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DatabaseTable>(
        future: futureTable,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final rows = snapshot.data as List<dynamic>;
            return Text(rows.toString());
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const CircularProgressIndicator();
        });
  }
}

class CorePage extends StatelessWidget {
  const CorePage({super.key});

  final tabs = const [
    Tab(text: 'Buses'),
    Tab(text: 'Stops'),
    Tab(text: 'Routes'),
  ];

  final views = const [
    Center(child: Mainpage(path: "buses")),
    Center(child: DisplayDatabaseTable('localhost:8080', 'stops')),
    Center(child: DisplayDatabaseTable('localhost:8080', 'routes')),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Bus Ticketing System'),
            centerTitle: true,
            bottom: TabBar(tabs: tabs),
          ),
          body: TabBarView(children: views)),
    );
  }
}
