import 'dart:async' show FutureOr;

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

class Server {
  final String address;
  final int port;
  final Map<String, Map<String, Handler>> _handlers = {};

  Server({
    this.address = 'localhost',
    this.port = 8080,
  });

  void run({bool enableLogging = true}) async {
    final handler = enableLogging
        ? const Pipeline().addMiddleware(logRequests()).addHandler(_router)
        : const Pipeline().addHandler(_router);
    final server = await serve(handler, address, port);
    print('Serving at http://${server.address.host}:${server.port}');
  }

  void addHandler(String method, String path, Handler handler) {
    _handlers[path] == null
        ? _handlers[path] = {method: handler}
        : _handlers[path]?[method] = handler;
  }

  void addHandlersForPath(String path, Map<String, Handler> handlers) {
    _handlers[path] = handlers;
  }

  FutureOr<Response> _router(Request request) {
    final path = '/' + request.url.path;
    final handler = _handlers[path]?[request.method];
    return handler != null ? handler(request) : Response.notFound(null);
  }
}
