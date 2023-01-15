// ignore_for_file: library_prefixes, avoid_print

import 'dart:convert';
import 'package:smc/src/utils/view_util.dart';
import 'package:http/http.dart' as http;
import 'package:smc/src/services/url_base.dart' as urlBase;

class RefreshTokenApi {
  var url = urlBase.endpointApi;

  Future<bool> refresh(String token) async {
    try {
      var url = this.url + 'refresh';

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      var response = await http.post(Uri.parse(url), headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        ViewUtil.tokenJWT = mapResponse["token"];
        return true;
      } else {
        return false;
      }
    } catch (error, exception) {
      print("Erro no login $error > $exception");

      return false;
    }
  }
}
