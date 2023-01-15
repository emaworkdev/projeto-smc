// ignore_for_file: avoid_print

import 'dart:convert' as convert;
import 'dart:convert';
import 'package:smc/src/models/model.dart';
import 'package:smc/src/services/service_base.dart';
import 'package:smc/src/services/url_base.dart';
import 'package:smc/src/services/http_helper.dart' as http;

class ConectionService extends ServiceBase {
  @override
  var url = endpointApi;

  Future<WhatsappModel?> inserir(WhatsappModel obj) async {
    try {
      var url = this.url + '/whatsapps/';

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

  Future<WhatsappModel?> alterar(WhatsappModel obj) async {
    try {
      var url = this.url + '/whatsapps/';
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

  Future<bool?> excluir(int id) async {
    try {
      var url = this.url + '/whatsapps/';
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

  start(String session, bool padrao) async {
    try {
      var url = this.url + '/whatsapps/start';
      Map params = {"session": session, "waitQrCode": true, "padrao": padrao};

      String body = json.encode(params);
      await http.post(url, body: body);
    } catch (error, exception) {
      print("Erro Start Whatsapp $error > $exception");
    }
  }

  close(String session, bool padrao) async {
    try {
      var url = this.url + '/whatsapps/close';
      Map params = {"session": session, "padrao": padrao};

      String body = json.encode(params);
      await http.post(url, body: body);
    } catch (error, exception) {
      print("Erro Start Whatsapp $error > $exception");
    }
  }

  logout(String session, bool padrao) async {
    try {
      var url = this.url + '/whatsapps/logout';
      Map params = {"session": session, "padrao": padrao};

      String body = json.encode(params);
      await http.post(url, body: body);
    } catch (error, exception) {
      print("Erro Start Whatsapp $error > $exception");
    }
  }
}
