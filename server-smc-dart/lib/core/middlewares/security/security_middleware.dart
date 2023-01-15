import 'dart:convert';

import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:server_smc/core/helpers/jwt_helper.dart';
import 'package:server_smc/core/middlewares/middlewares.dart';
import 'package:server_smc/core/middlewares/security/security_skip_url.dart';
import 'package:shelf/shelf.dart';

class SecurityMiddleware extends Middewares {
  final skypUrl = <SecuritySkipUrl>[
    SecuritySkipUrl(url: '/webhooks/', method: 'POST'),
    SecuritySkipUrl(url: '/webhooks/secunds', method: 'POST'),
    SecuritySkipUrl(url: '/webhooks/bayleys', method: 'POST'),
    SecuritySkipUrl(url: '/auth/', method: 'POST'),
    SecuritySkipUrl(url: '/auth/register', method: 'POST'),
    SecuritySkipUrl(url: '/auth/verified', method: 'POST'),
    SecuritySkipUrl(url: '/auth/url', method: 'POST'),
  ];

  SecurityMiddleware();

  @override
  Future<Response> execute(Request request) async {
    try {
      if (skypUrl.contains(SecuritySkipUrl(
          url: '/${request.url.path}', method: request.method))) {
        return innerHandler(request);
      }

      final authHeader = request.headers['Authorization'];

      if (authHeader == null || authHeader.isEmpty) {
        throw JwtException.invalidToken;
      }

      final authHeaderContent = authHeader.split(' ');

      if (authHeaderContent[0] != 'Bearer') {
        throw JwtException.invalidToken;
      }

      final authorizationToken = authHeaderContent[1];
      final claims = JwtHelper.getClaims(authorizationToken);

      if (request.url.path != 'auth/refresh') {
        claims.validate();
      }

      final claimsMap = claims.toJson();

      final userId = claimsMap['sub'];
      final supplierId = claimsMap['supplier'];

      if (userId == null) {
        throw JwtException.invalidToken;
      }

      final securityHeaders = {
        'user': userId,
        'access_token': authorizationToken,
        'supplier': supplierId
      };

      return innerHandler(request.change(headers: securityHeaders));
    } on JwtException catch (e, s) {
      print(e);
      print(s);
      return Response.unauthorized(jsonEncode({}));
    } catch (e, s) {
      print(e);
      print(s);
      return Response.forbidden(jsonEncode({}));
    }
  }
}
