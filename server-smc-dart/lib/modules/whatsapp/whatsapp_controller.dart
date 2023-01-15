import 'dart:convert';

import 'package:server_smc/models/whatsapp_model.dart';
import 'package:server_smc/repositories/whatsapp_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'whatsapp_controller.g.dart';

class WhatsappController {
  final _whatsappRepository = WhatsappRepository();

  @Route.post('/')
  Future<Response> created(Request request) async {
    try {
      String id = '0';
      final obj = WhatsappModel.fromJson(await request.readAsString());

      id = await _whatsappRepository.save(obj);

      return Response(200,
          body: jsonEncode(
            {'id': id, 'result': 'success'},
          ),
          headers: {
            'content-type': 'application/json',
          });
    } catch (e, s) {
      print(e);
      print(s);
      return Response.internalServerError(
        body: {'result': 'erro interno no servidor'},
      );
    }
  }

  @Route.delete('/')
  Future<Response> delete(Request request) async {
    try {
      final jsonRQ = jsonDecode(await request.readAsString());

      await _whatsappRepository.delete(jsonRQ['id']);

      return Response(204, headers: {
        'content-type': 'application/json',
      });
    } catch (e, s) {
      print(e);
      print(s);
      return Response.internalServerError(
        body: {'result': 'erro interno no servidor'},
      );
    }
  }

  @Route.post('/start')
  Future<Response> start(Request request) async {
    try {
      final jsonRQ = jsonDecode(await request.readAsString());

      if (jsonRQ['padrao'] == true) {
        await _whatsappRepository.start(
            jsonRQ['session'], jsonRQ['waitQrCode']);
      } else {
        await _whatsappRepository.startClient(
            jsonRQ['session'], jsonRQ['waitQrCode']);
      }

      return Response(200,
          body: jsonEncode(
            {'result': 'success'},
          ),
          headers: {
            'content-type': 'application/json',
          });
    } catch (e, s) {
      print(e);
      print(s);
      return Response.internalServerError(
        body: {'result': 'erro interno no servidor'},
      );
    }
  }

  @Route.post('/close')
  Future<Response> close(Request request) async {
    try {
      final jsonRQ = jsonDecode(await request.readAsString());

      if (jsonRQ['padrao'] == true) {
        await _whatsappRepository.close(jsonRQ['session']);
      } else {
        await _whatsappRepository.closeClient(jsonRQ['session']);
      }

      return Response(200,
          body: jsonEncode(
            {'result': 'success'},
          ),
          headers: {
            'content-type': 'application/json',
          });
    } catch (e, s) {
      print(e);
      print(s);
      return Response.internalServerError(
        body: {'result': 'erro interno no servidor'},
      );
    }
  }

  @Route.post('/logout')
  Future<Response> logout(Request request) async {
    try {
      final jsonRQ = jsonDecode(await request.readAsString());

      if (jsonRQ['padrao'] == true) {
        await _whatsappRepository.logout(jsonRQ['session']);
      } else {
        await _whatsappRepository.logoutClient(jsonRQ['session']);
      }

      return Response(200,
          body: jsonEncode(
            {'result': 'success'},
          ),
          headers: {
            'content-type': 'application/json',
          });
    } catch (e, s) {
      print(e);
      print(s);
      return Response.internalServerError(
        body: {'result': 'erro interno no servidor'},
      );
    }
  }

  Router get router => _$WhatsappControllerRouter(this);
}
