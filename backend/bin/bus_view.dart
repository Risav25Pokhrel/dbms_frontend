import 'dart:async' show FutureOr;
import 'dart:convert' show json;
import 'package:postgres/postgres.dart' show PostgreSQLConnection;
import 'package:shelf/shelf.dart' show Request, Response, Handler;

class BusViewHandler {
  final PostgreSQLConnection psql;
  static const List<String> queryFields = ['trip_id', 'licenseplate'];

  const BusViewHandler({
    required this.psql,
  });

  Map<String, Handler> toMap() {
    return {'GET': read};
  }

  FutureOr<Response> read(Request request) async {
    final q = Uri.splitQueryString(request.url.query);
    try {
      if (q['trip_id'] == null) {
        throw 'Missing Query Fields';
      }

      final sql1 = "SELECT seat_row,seat_num FROM tickets WHERE trip_id=@trip_id";
      final out1 = await psql.query(sql1, substitutionValues: q);
      final data = json.encode(out1);
      return Response(200,
          body: data,
          headers: {'Content-Type': 'application/json; charset=utf-8'});
    } catch (e) {
      print(e.toString());
      return Response.badRequest(body: e.toString());
    }
  }
}
