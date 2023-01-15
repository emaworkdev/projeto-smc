import 'dart:async';
import 'dart:convert';
import 'package:server_smc/models/connect_hasura.dart';
import 'package:server_smc/services/shots_hasura_service.dart';
import 'package:server_smc/services/whatsapp_hasura_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'web_hook_controller.g.dart';

class WebHookController {
  var hasuraConnected = WhatsappHasuraService();
  var hasuraShot = ShotsHasuraService();
  @Route.post('/')
  Future<Response> webkook(Request request) async {
    try {
      final jsonRQ = jsonDecode(await request.readAsString());
      ConnectHasura ev = ConnectHasura();

      if (jsonRQ['status'] != null) {
        if (jsonRQ['status'] == 'browserClose') {
          if (jsonRQ['event'] == 'status-find') {
            var status = "DESCONNECTED";
            await hasuraConnected.atualizaStatusFind(
                jsonRQ['session'], status, false);
          }
        } else if (jsonRQ['status'] == 'qrReadSuccess') {
          if (jsonRQ['event'] == 'status-find') {
            var status = "qrcode";
            await hasuraConnected.atualizaStatusFind(
                jsonRQ['session'], status, true);
          }
        } else if (jsonRQ['status'] == 'notLogged') {
          if (jsonRQ['event'] == 'status-find') {
            var status = "DESCONNECTED";
            await hasuraConnected.atualizaStatusFind(
                jsonRQ['session'], status, false);
          }
        } else if (jsonRQ['status'] == 'inChat') {
          if (jsonRQ['event'] == 'status-find') {
            var status = "CONNECTED";
            await hasuraConnected.atualizaStatusFind(
                jsonRQ['session'], status, true);
          }
        }
      } else if (jsonRQ['event'] != null) {
        if (jsonRQ['event'] == 'qrcode') {
          ev.event = 'qrcode';
          ev.qrcode = jsonRQ['qrcode'];
          ev.session = jsonRQ['session'];
          await hasuraConnected.atualizaQrCode(ev);
        } else if (jsonRQ['event'] == 'onack') {
          print(jsonRQ['session']);
          hasuraShot.atualizaAlvo(jsonRQ['session']);
        }
      }

      return Response.ok("");
    } catch (e, s) {
      print('Erro no webhook: $e');
      print('Erro no webhook: $s');
      return Response.internalServerError();
    }
  }

  @Route.post('/secunds')
  Future<Response> webkookBayleys(Request request) async {
    try {
      final jsonRQ = jsonDecode(await request.readAsString());
      ConnectHasura ev = ConnectHasura();

      if (jsonRQ['status'] != null) {
        if (jsonRQ['status'] == 'browserClose') {
          if (jsonRQ['event'] == 'status-find') {
            var status = "DESCONNECTED";
            await hasuraConnected.atualizaStatusFind(
                jsonRQ['session'], status, false);
          }
        } else if (jsonRQ['status'] == 'qrReadSuccess') {
          if (jsonRQ['event'] == 'status-find') {
            var status = "qrcode";
            await hasuraConnected.atualizaStatusFind(
                jsonRQ['session'], status, true);
          }
        } else if (jsonRQ['status'] == 'notLogged') {
          if (jsonRQ['event'] == 'status-find') {
            var status = "DESCONNECTED";
            await hasuraConnected.atualizaStatusFind(
                jsonRQ['session'], status, false);
          }
        } else if (jsonRQ['status'] == 'inChat') {
          if (jsonRQ['event'] == 'status-find') {
            var status = "CONNECTED";
            await hasuraConnected.atualizaStatusFind(
                jsonRQ['session'], status, true);
          }
        }
      } else if (jsonRQ['event'] != null) {
        if (jsonRQ['event'] == 'qrcode') {
          ev.event = 'qrcode';
          ev.qrcode = jsonRQ['qrcode'];
          ev.session = jsonRQ['session'];
          await hasuraConnected.atualizaQrCode(ev);
        } else if (jsonRQ['event'] == 'onack') {
          hasuraShot.atualizaClient(jsonRQ['session']);
        }
      }

      return Response.ok("");
    } catch (e, s) {
      print('Erro no webhook: $e');
      print('Erro no webhook: $s');
      return Response.internalServerError();
    }
  }

  Router get router => _$WebHookControllerRouter(this);
}
