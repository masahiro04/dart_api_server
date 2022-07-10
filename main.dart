import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

void main() async {
  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler((_echoRequest));
  final server = await shelf_io.serve(handler, 'localhost', 8080);
  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');
}

Response _echoRequest(Request request) =>
    Response.ok('Request for "${request.url}"');
