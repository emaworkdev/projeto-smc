import 'dart:convert';

import 'package:server_smc/models/settings_model.dart';
import 'package:server_smc/repositories/setting_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'setting_controller.g.dart';

class SettingController {
  final _settingRepository = SettingRepository();

  @Route.post('/')
  Future<Response> created(Request request) async {
    try {
      String id = '0';
      final obj = SettingsModel.fromJson(await request.readAsString());

      id = await _settingRepository.save(obj);

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

      await _settingRepository.delete(jsonRQ['id']);

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

  Router get router => _$SettingControllerRouter(this);
}
