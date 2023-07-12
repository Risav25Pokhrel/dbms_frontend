import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

typedef DatabaseTable = List<dynamic>;

Future<DatabaseTable> fetchTable(String host, String path) async {
  final response = await http.get(Uri.http(host, path));

  if (response.statusCode == 200) {
    final out = json.decode(response.body);
    return out;
  } else {
    throw Exception('Failed to fetch table');
  }
}

class DisplayDatabaseTable extends StatefulWidget {
  final String host, path;
  const DisplayDatabaseTable(
    this.host,
    this.path,
    {super.key}
  );

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
          return Text(rows[0].toString());
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return const CircularProgressIndicator();
      }
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  final tabs = const [
    Tab(text: 'Buses'),
    Tab(text: 'Stops'),
    Tab(text: 'Routes'),
  ];

  final views = const [
    Center(child: DisplayDatabaseTable('localhost:8080', 'buses')),
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
          bottom: TabBar(
            tabs: tabs
          ),
        ),
        body: TabBarView(
          children: views
        )
      ),
    );
  }
}
