import 'package:backend/server.dart';
import 'package:backend/posthandler.dart';
import 'package:backend/gethandler.dart';
import 'package:postgres/postgres.dart' show PostgreSQLConnection;
import 'bus_view.dart';
import 'booking.dart';

void main() async {
  final psql = PostgreSQLConnection(
    String.fromEnvironment('DBHOST'),
    int.fromEnvironment('DBPORT'),
    String.fromEnvironment('DBNAME'),
    username: String.fromEnvironment('DBUSER'),
    password: String.fromEnvironment('DBPASS'),
  );

  try {
    await psql.open();
  } catch (e) {
    print(e.toString());
    return;
  }

  final server = Server();

  final pass_handler = PostHandler(
    psql: psql,
    table: 'passengers',
    path: '/passengers',
  );

  final tick_handler = PostHandler(
    psql: psql,
    table: 'tickets',
    path: '/tickets',
  );

  final trip_handler = GetHandler(
    psql: psql,
    table: 'trips_view',
    path: '/trips',
    map: true,
    queryFields: ['start_at', 'end_at', 'DATE(departure)'],
  );

  final seat_handler = GetHandler (
    psql: psql,
    table: 'tickets',
    path: '/taken_seats',
    queryFields: ['trip_id'],
    columns: ['seat_col', 'seat_num'],
  );

  final stop_handler = GetHandler(
    psql: psql,
    table: 'stops',
    path: '/stops',
  );

  final bk = BookingHandler(psql: psql);
  server.addHandlersForPath('/book', bk.toMap());

  server.addHandlersForPath(seat_handler.path, seat_handler.toMap());
  server.addHandlersForPath(pass_handler.path, pass_handler.toMap());
  server.addHandlersForPath(tick_handler.path, tick_handler.toMap());
  server.addHandlersForPath(trip_handler.path, trip_handler.toMap());
  server.addHandlersForPath(stop_handler.path, stop_handler.toMap());


  server.run();
}
