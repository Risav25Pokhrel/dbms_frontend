import 'dart:async' show FutureOr;
import 'dart:convert' show json;

import 'package:postgres/postgres.dart'
    show PostgreSQLConnection, PostgreSQLFormat;
import 'package:shelf/shelf.dart' show Request, Response, Handler;

class GetHandler {
  final String path;
  final String table;
  final List<String>? columns;
  final bool map;
  final List<String>? queryFields;
  final PostgreSQLConnection psql;

  const GetHandler({
    required this.psql,
    required this.path,
    required this.table,
    this.columns = null,
    this.map = false,
    this.queryFields = null,
  });

  Map<String, Handler> toMap() {
    return {'GET': get};
  }

  FutureOr<Response> get(Request request) async {
    try {
      final where = _parseQuery(request.url.query);
      final col = columns == null ? '*' : columns?.join(',');
      final sql = "SELECT $col FROM $table $where";
      final out =
          await (this.map ? psql.mappedResultsQuery(sql) : psql.query(sql));
      print(out);
      final data = json.encode(out,
          toEncodable: (obj) =>
              (obj is DateTime) ? obj.toIso8601String() : obj);
      return Response(200,
          body: data,
          headers: {'Content-Type': 'application/json; charset=utf-8'});
    } catch (e) {
      print(e.toString());
      return Response.badRequest(body: e.toString());
    }
  }

  List<String> _keyEqAtKey(Iterable<String> keys) {
    List<String> ret = [];
    for (final k in keys) {
      ret.add("$k = @$k");
    }
    return ret;
  }

  String _parseQuery(String query) {
    if (query.isEmpty) {
      if (queryFields == null) {
        return "";
      } else {
        throw "Missing Query Fields";
      }
    }

    final q = Uri.splitQueryString(query);
    var c = PostgreSQLFormat.substitute(
        "WHERE " + _keyEqAtKey(q.keys).join(" AND "), q);

    for (final f in queryFields!) {
      if (q[f] == null) {
        throw "Missing Query Fields";
      }

      if (c.contains('@' + f)) {
        c = c.replaceAll('@' + f, '@__tempreplace__');
        c = PostgreSQLFormat.substitute(c, {'__tempreplace__': q[f]});
      }
    }

    return c;
  }
}
