import 'dart:convert';

import 'package:server_smc/models/shots_model.dart';
import 'package:server_smc/repositories/shots_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'shots_controller.g.dart';

class ShotsController {
  final _shotRepository = ShotsRepository();

  @Route.post('/')
  Future<Response> created(Request request) async {
    try {
      String id = '0';
      final obj = ShotsModel.fromJson(await request.readAsString());

      id = await _shotRepository.save(obj);

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

  @Route.post('/start')
  Future<Response> start(Request request) async {
    try {
      final jsonRQ = jsonDecode(await request.readAsString());

      _shotRepository.start(jsonRQ['id']);

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

  @Route.post('/pause')
  Future<Response> pause(Request request) async {
    try {
      final jsonRQ = jsonDecode(await request.readAsString());

      _shotRepository.pause(jsonRQ['id']);

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

  @Route.delete('/')
  Future<Response> delete(Request request) async {
    try {
      final jsonRQ = jsonDecode(await request.readAsString());

      await _shotRepository.delete(jsonRQ['id']);

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

  Router get router => _$ShotsControllerRouter(this);
}
