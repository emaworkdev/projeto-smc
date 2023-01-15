import 'dart:convert';
import 'dart:async';

import 'package:server_smc/models/whatsapp_model.dart';
import 'package:server_smc/services/setting_hasura_service.dart';
import 'package:server_smc/services/whatsapp_hasura_service.dart';
import 'package:server_smc/uteis/constantes.dart';
import 'package:server_smc/uteis/funcao_data.dart';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;

class WhatsappRepository {
  var hasuraConnected = WhatsappHasuraService();
  var hasuraSettings = SettingHasuraService();
  var apiUrl = env['wppConnectHost'];
  var webhookAlvo = env['urlWebhookAlvo'];
  var webhookClient = env['urlWebhookClient'];

  connected(WhatsappModel obj) async {
    try {
      var reth = await hasuraConnected.existeSessao(obj.session!);
      if (reth) {
        await hasuraConnected.update(obj);
      } else {
        await hasuraConnected.create(obj);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<String> save(WhatsappModel obj) async {
    var ret = '0';
    try {
      if (obj.id != 0) {
        obj.updatedAt = FuncaoData().hoje;
        ret = await hasuraConnected.update(obj);
      } else {
        ret = await hasuraConnected.create(obj);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return ret;
  }

  delete(int id) async {
    try {
      await hasuraConnected.delete(id);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  start(String session, bool waitQrCode) async {
    try {
      bool istoken;

      istoken = await tokenApi(session);

      if (istoken) {
        var url = '$apiUrl/$session/start-session';

        Map<String, String> headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constantes.apiToken}"
        };

        Map params = {"webhook": webhookAlvo, "waitQrCode": waitQrCode};

        String body = json.encode(params);

        //print(url);
        //print(body);
        //print("TOKEN: ${Constantes.apiToken}");

        await http.post(Uri.tryParse(url)!, body: body, headers: headers);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  startClient(String session, bool waitQrCode) async {
    try {
      bool istoken;

      istoken = await tokenApiClient(session);

      if (istoken) {
        var url = '$apiUrl/$session/start-session';

        Map<String, String> headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constantes.apiTokenClient}"
        };

        Map params = {"webhook": webhookClient, "waitQrCode": waitQrCode};

        String body = json.encode(params);

        //print(url);
        //print(body);
        //print("TOKEN: ${Constantes.apiTokenClient}");

        await http.post(Uri.tryParse(url)!, body: body, headers: headers);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  close(String session) async {
    try {
      bool istoken;

      istoken = await tokenApi(session);

      if (istoken) {
        var url = '$apiUrl/$session/close-session';

        Map<String, String> headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constantes.apiToken}"
        };

        await http.post(Uri.tryParse(url)!, headers: headers);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  closeClient(String session) async {
    try {
      bool istoken;

      istoken = await tokenApiClient(session);

      if (istoken) {
        var url = '$apiUrl/$session/close-session';

        Map<String, String> headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constantes.apiTokenClient}"
        };

        await http.post(Uri.tryParse(url)!, headers: headers);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  logout(String session) async {
    try {
      bool istoken;

      istoken = await tokenApi(session);

      if (istoken) {
        var url = '$apiUrl/$session/logout-session';

        Map<String, String> headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constantes.apiToken}"
        };

        await http.post(Uri.tryParse(url)!, headers: headers);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  logoutClient(String session) async {
    try {
      bool istoken;

      istoken = await tokenApiClient(session);

      if (istoken) {
        var url = '$apiUrl/$session/logout-session';

        Map<String, String> headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constantes.apiTokenClient}"
        };

        await http.post(Uri.tryParse(url)!, headers: headers);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<bool> tokenApi(String session) async {
    bool resp = false;
    try {
      var secretkey = env['secretKey'];

      var url = '$apiUrl/$session/$secretkey/generate-token';

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      Map params = {"session": session, "secretkey": secretkey};

      String body = json.encode(params);

      var response =
          await http.post(Uri.tryParse(url)!, body: body, headers: headers);
      var obj = json.decode(response.body);

      if (obj['status'] != null) {
        if (obj['status'] == 'success') {
          var token = obj['token'];
          Constantes.apiToken = obj['token'];
          await hasuraConnected.atualizaToken(session, token);
          resp = true;
        }
      } else {
        resp = false;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return resp;
  }

  Future<bool> tokenApiClient(String session) async {
    bool resp = false;
    try {
      var secretkey = env['secretKey'];

      var url = '$apiUrl/$session/$secretkey/generate-token';

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      Map params = {"session": session, "secretkey": secretkey};

      String body = json.encode(params);

      var response =
          await http.post(Uri.tryParse(url)!, body: body, headers: headers);
      var obj = json.decode(response.body);

      if (obj['status'] != null) {
        if (obj['status'] == 'success') {
          var token = obj['token'];
          Constantes.apiTokenClient = obj['token'];
          await hasuraConnected.atualizaToken(session, token);
          resp = true;
        }
      } else {
        resp = false;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return resp;
  }
}
