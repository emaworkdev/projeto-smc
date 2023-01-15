// ignore_for_file: avoid_print

import 'dart:convert' as convert;
import 'package:smc/src/models/model.dart';
import 'package:smc/src/services/service_base.dart';
import 'package:smc/src/services/url_base.dart';
import 'package:smc/src/services/http_helper.dart' as http;

class UserService extends ServiceBase {
  @override
  var url = endpointApi;

  Future<UserModel?> inserir(UserModel obj) async {
    try {
      var url = this.url + '/users/';

      final response = await http.post(
        url,
        body: obj.objetoEncodeJson(obj),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        //var objJson = convert.json.decode(response.body);
        //return UserModel.fromMap(objJson);
        return null;
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserModel?> alterar(UserModel obj) async {
    try {
      var url = this.url + '/users/';
      final response = await http.post(
        url,
        body: obj.objetoEncodeJson(obj),
      );

      if (response.statusCode == 200) {
        //var objJson = convert.json.decode(response.body);
        //return UserModel.fromMap(objJson);
        return null;
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool?> excluir(int id) async {
    try {
      var url = this.url + '/users/';
      Map params = {"id": id};
      String rem = convert.json.encode(params);
      final response = await http.delete(
        url,
        body: rem,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  Future<String> updatePassword(String email, String password) async {
    try {
      var url = this.url + '/auth/update/password';

      Map params = {"email": email, "password": password};

      String s = convert.json.encode(params);

      var response = await http.post(url, body: s);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var objJson = convert.json.decode(response.body);
        return objJson;
      } else {
        return 'false';
      }
    } catch (error, exception) {
      print("Erro na atualização da senha $error > $exception");
      return "Erro: ao atualizar a senha";
    }
  }
}
