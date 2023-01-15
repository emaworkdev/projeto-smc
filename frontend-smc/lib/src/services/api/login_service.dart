// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:smc/src/services/service_base.dart';
import 'package:smc/src/utils/encrypt_decrypt.dart';
import 'package:smc/src/utils/view_util.dart';
import 'package:http/http.dart' as http;
import 'package:smc/src/services/url_base.dart';

class LoginService extends ServiceBase {
  @override
  var url = endpointApi;

  Future<dynamic> autenticar(String login, String senha) async {
    try {
      Map mapResponse;
      var url = this.url + '/auth/';

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      Map params = {"email": login, "password": senha};

      String s = json.encode(params);

      var response = await http.post(Uri.parse(url), body: s, headers: headers);

      mapResponse = json.decode(response.body);
      //print(">>>>>>>>>>>>>>>>> $mapResponse['password']");
      if (response.statusCode == 200) {
        ViewUtil.senha = senha;
        ViewUtil.email = login;
        ViewUtil.tokenJWT = mapResponse['password'];

        //print(">>>>>>>>>>>>>>>>> ${ViewUtil.tokenJWT}");

        var jwt = ViewUtil.tokenJWT.split(".");
        var payload =
            json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));

        ViewUtil.idUsuario = payload["sub"].toString();
        ViewUtil.nomeUsuario = payload["name"].toString();
        ViewUtil.tenanty = payload["supplierId"].toString();

        return mapResponse;
      } else {
        return null;
      }
    } catch (error, exception) {
      print("Erro no login $error > $exception");

      return null;
    }
  }

  Future<String> updatePassword(String email, String password) async {
    try {
      var url = this.url + '/auth/update/password';

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      Map params = {"email": email, "password": password};

      String s = json.encode(params);

      var response = await http.post(Uri.parse(url), body: s, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var objJson = json.decode(response.body);
        return objJson;
      } else {
        return 'false';
      }
    } catch (error, exception) {
      print("Erro na atualização da senha $error > $exception");

      return "Erro: ao atualizar a senha";
    }
  }

  Future<void> urlHost() async {
    try {
      var url = this.url + '/auth/url';

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      Map params = {};

      String s = json.encode(params);

      var response = await http.post(Uri.parse(url), body: s, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var objJson = json.decode(response.body);
        final decrypt = EncryptDecrypt();

        ViewUtil.apiHasura = decrypt.decryptData(objJson['urlHasura']);
        ViewUtil.hasuraSecret = decrypt.decryptData(objJson['hasuraPassword']);
      } else {}
    } catch (error, exception) {
      print("Erro para obter as urls $error > $exception");
    }
  }
}
