import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:dotenv/dotenv.dart';

class JwtHelper {
  static final String _jwtPrivateKey = env['jwt_secret']!;

  JwtHelper._();

  static String generateJWT(int usuarioId, dynamic supplierId, String? name) {
    var sign = supplierId ?? '0';

    final claimSet = JwtClaim(
      issuer: "smc",
      subject: usuarioId.toString(),
      expiry: DateTime.now().add(const Duration(days: 1)),
      notBefore: DateTime.now(),
      issuedAt: DateTime.now(),
      otherClaims: <String, dynamic>{'supplierId': sign, 'name': name},
      maxAge: const Duration(days: 1),
    );

    final token = issueJwtHS256(claimSet, _jwtPrivateKey);

    return token;
  }

  static String refreshToken(String accessToken) {
    final claimSet = JwtClaim(
      issuer: accessToken,
      subject: 'RefreshToken',
      expiry: DateTime.now().add(const Duration(days: 365)),
      notBefore: DateTime.now().subtract(const Duration(days: 1)),
      issuedAt: DateTime.now(),
      otherClaims: <String, dynamic>{},
    );

    final token = issueJwtHS256(claimSet, _jwtPrivateKey);

    return token;
  }

  static String generateSHA256Hash(String pass) {
    final bytes = utf8.encode(pass);
    final password = sha256.convert(bytes).toString();
    return password;
  }

  static JwtClaim getClaims(String token) {
    return verifyJwtHS256Signature(token, _jwtPrivateKey);
  }
}
