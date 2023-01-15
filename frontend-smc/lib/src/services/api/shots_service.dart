// ignore_for_file: avoid_print

import 'dart:convert' as convert;
import 'package:smc/src/models/model.dart';
import 'package:smc/src/services/service_base.dart';
import 'package:smc/src/services/url_base.dart';
import 'package:smc/src/services/http_helper.dart' as http;

class ShotsService extends ServiceBase {
  @override
  var url = endpointApi;

  Future<ShotsModel?> inserir(ShotsModel obj) async {
    try {
      var url = this.url + '/shots/';

      final response = await http.post(
        url,
        body: obj.objetoEncodeJson(obj),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return null;
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<ShotsModel?> alterar(ShotsModel obj) async {
    try {
      var url = this.url + '/shots/';
      final response = await http.post(
        url,
        body: obj.objetoEncodeJson(obj),
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool?> start(int id) async {
    try {
      var url = this.url + '/shots/start';
      Map params = {"id": id};
      String rem = convert.json.encode(params);
      final response = await http.post(
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

  Future<bool?> pause(int id) async {
    try {
      var url = this.url + '/shots/pause';
      Map params = {"id": id};
      String rem = convert.json.encode(params);
      final response = await http.post(
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

  Future<bool?> excluir(int id) async {
    try {
      var url = this.url + '/shots/';
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
}
