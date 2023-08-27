import 'dart:async' show FutureOr;
import 'dart:convert' show json;
import 'package:postgres/postgres.dart'
    show PostgreSQLConnection, PostgreSQLFormat;
import 'package:shelf/shelf.dart' show Request, Response, Handler;

class PostHandler {
  final String path;
  final String table;
  final PostgreSQLConnection psql;

  const PostHandler({
    required this.psql,
    required this.path,
    required this.table,
  });

  Map<String, Handler> toMap() {
    return {
      'POST': create,
      'GET': read,
      'PUT': update,
      'DELETE': delete,
    };
  }

  FutureOr<Response> create(Request request) async {
    try {
      final sub = json.decode(await request.readAsString());
      final col = sub.keys.join(',');
      final val = '@' + sub.keys.join(',@');
      final sql = "INSERT INTO $table ($col) VALUES ($val)";
      await psql.query(sql, substitutionValues: sub);
      return Response(201);
    } catch (e) {
      return Response.badRequest(body: e.toString());
    }
  }

  FutureOr<Response> read(Request request) async {
    final where = _parseQuery(request.url.query);
    final sql = "SELECT * FROM $table $where";

    try {
      final out = await psql.query(sql);
      final data = json.encode(out,
          toEncodable: (obj) =>
              (obj is DateTime) ? obj.toIso8601String() : obj);
      return Response(200,
          body: data,
          headers: {'Content-Type': 'application/json; charset=utf-8'});
    } catch (e) {
      return Response.badRequest(body: e.toString());
    }
  }

  FutureOr<Response> update(Request request) async {
    try {
      final sub = json.decode(await request.readAsString());
      final cnd = _parseQuery(request.url.query);
      final cev = _keyEqAtKey(sub.keys).join(",");
      final sql = "UPDATE $table SET $cev $cnd";
      await psql.query(sql, substitutionValues: sub);
      return Response(204);
    } catch (e) {
      return Response.badRequest(body: e.toString());
    }
  }

  FutureOr<Response> delete(Request request) async {
    final where = _parseQuery(request.url.query);
    final sql = "DELETE FROM $table $where";

    try {
      await psql.query(sql);
      return Response(204);
    } catch (e) {
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
    var cnd = "";
    if (!query.isEmpty) {
      final q = Uri.splitQueryString(query);
      cnd = "WHERE " + _keyEqAtKey(q.keys).join(" AND ");
      cnd = PostgreSQLFormat.substitute(cnd, q);
    }
    return cnd;
  }
}
