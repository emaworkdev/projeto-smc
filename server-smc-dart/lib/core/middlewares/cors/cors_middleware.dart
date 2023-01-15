import 'dart:io';

import 'package:server_smc/core/middlewares/middlewares.dart';
import 'package:shelf/shelf.dart';
import 'package:dotenv/dotenv.dart';

class CorsMiddleware extends Middewares {
  final Map<String, String> headers = {
    'Access-Control-Allow-Origin': '${getOrigins()}',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
    'Access-Control-Allow-Headers':
        '${HttpHeaders.contentTypeHeader}, ${HttpHeaders.authorizationHeader}'
  };

  @override
  Future<Response> execute(Request request) async {
    if (request.method == 'OPTIONS') {
      return Response(HttpStatus.ok, headers: headers);
    }
    final response = await innerHandler(request);

    return response.change(headers: headers);
  }
}

getOrigins() {
  return env['urlFrontEnd']!;
}
