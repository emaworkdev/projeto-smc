// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:smc/src/utils/view_util.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import 'refresh_token_api.dart';

Future<http.Response> get(String url) async {
  final headers = await _headers();
  var response = await http.get(Uri.tryParse(url)!, headers: headers);
  return response;
}

Future<http.Response> getSimples(String url) async {
  final headers = await _headers_simples();
  var response = await http.get(Uri.tryParse(url)!, headers: headers);
  return response;
}

Future<http.Response> post(String url, {body}) async {
  final headers = await _headers();
  var response =
      await http.post(Uri.tryParse(url)!, body: body, headers: headers);
  return response;
}

Future<http.Response> postSimples(String url, {body}) async {
  final headers = await _headers_simples();
  var response =
      await http.post(Uri.tryParse(url)!, body: body, headers: headers);
  return response;
}

Future<http.Response> put(String url, {body}) async {
  final headers = await _headers();
  var response =
      await http.put(Uri.tryParse(url)!, body: body, headers: headers);
  return response;
}

Future<http.Response> delete(String url, {body}) async {
  final headers = await _headers();
  var response =
      await http.delete(Uri.tryParse(url)!, body: body, headers: headers);
  return response;
}

Future<bool> upload(String uri, List<int> file) async {
  //TokenApi? token = await TokenApi.get();
  var token = ViewUtil.tokenJWT;
  var auth = "Bearer $token";
  var url = Uri.parse(uri);

  var request = http.MultipartRequest("POST", url);

  request.headers[HttpHeaders.authorizationHeader] = auth;

  // ignore: await_only_futures
  request.files.add(await http.MultipartFile.fromBytes('file', file,
      //contentType: MediaType('application', 'octet-stream'),
      filename: "file"));
  return request.send().then((response) async {
    await refreshToken(response.headers.toString());
    return response.statusCode == 200 ? true : false;
  });
}

Future<Map<String, String>> _headers() async {
  var token = ViewUtil.tokenJWT;
  bool hasExpired = JwtDecoder.isExpired(token);
  if (hasExpired) {
    bool ret = await _atualizaTokenExpirado(token);
    if (ret) {
      token = ViewUtil.tokenJWT;
    }
  }
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token"
  };

  return headers;
}

// ignore: non_constant_identifier_names
Future<Map<String, String>> _headers_simples() async {
  Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  return headers;
}

refreshToken(String resp) async {
  try {
    //TokenApi token = await TokenApi.get();

    List retorno = resp.split('Bearer');
    String tt = retorno[1];
    List retorno2 = tt.split(',');
    String tok = retorno2[0];

    //token.token = tok.replaceAll(" ", "");
    ViewUtil.tokenJWT = tok.replaceAll(" ", "");
    //token.save();
    //print('refresh:$token.token');
  } on Exception catch (e) {
    print(e);
  }
}

_atualizaTokenExpirado(String token) async {
  //print("token expired");
  RefreshTokenApi rta = RefreshTokenApi();
  //print("refresh token");
  bool resp = await rta.refresh(token);
  //print("retorno refresh " + resp.toString());

  return resp;
}
