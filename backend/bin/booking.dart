import 'dart:async' show FutureOr;
import 'dart:convert' show json;
import 'package:postgres/postgres.dart' show PostgreSQLConnection;
import 'package:shelf/shelf.dart' show Request, Response, Handler;

class BookingHandler {
  final PostgreSQLConnection psql;

  const BookingHandler({
    required this.psql,
  });

  Map<String, Handler> toMap() {
    return {
      'POST': post,
    };
  }

  FutureOr<Response> post(Request request) async {
    try {
      final sub = json.decode(await request.readAsString());
      final sql1 = "INSERT INTO passengers(name,phone) VALUES (@name, @phone) RETURNING id";
      final out1 = await psql.query(sql1, substitutionValues: sub);

      sub['passenger_id'] = out1[0][0];
      final a = sub['seat_nums'];
      final b = sub['seat_cols'];

      for (int i = 0; i < a.length; i ++) {
        sub['seat_num'] = a[i];
        sub['seat_col'] = b[i];
        final sql2 = "INSERT INTO tickets(passenger_id,trip_id,seat_num,seat_col,booking_time) VALUES (@passenger_id,@trip_id,@seat_num,@seat_col,@booking_time)";
        await psql.query(sql2, substitutionValues: sub);
      }

      return Response(200,
          body: json.encode(out1),
          headers: {'Content-Type': 'application/json; charset=utf-8'});
    } catch (e) {
      print(e.toString());
      return Response.badRequest(body: e.toString());
    }
  }
}
