import 'dart:convert';

import 'package:server_smc/core/exceptions/email_already_registered.dart';
import 'package:server_smc/models/user_model.dart';
import 'package:server_smc/repositories/user_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'user_controller.g.dart';

class UserController {
  final _userRepository = UserRepository();

  @Route.post('/')
  Future<Response> created(Request request) async {
    try {
      String id = '0';
      final userRq = UserModel.fromJson(await request.readAsString());

      id = await _userRepository.save(userRq);

      return Response(200,
          body: jsonEncode(
            {'id': id, 'result': 'success'},
          ),
          headers: {
            'content-type': 'application/json',
          });
    } on EmailAlreadyRegistered catch (e, s) {
      print(e);
      print(s);
      return Response(400,
          body: jsonEncode(
            {'result': 'E-mail já utilizado por outro usuário'},
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

      await _userRepository.delete(jsonRQ['id']);

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

  Router get router => _$UserControllerRouter(this);
}
