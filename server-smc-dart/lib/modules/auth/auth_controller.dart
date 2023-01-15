import 'dart:convert';

import 'package:server_smc/core/exceptions/email_already_registered.dart';
import 'package:server_smc/models/user_model.dart';
import 'package:server_smc/repositories/user_repository.dart';
import 'package:server_smc/uteis/encrypt_decrypt.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:dotenv/dotenv.dart';
import '../../core/exceptions/user_notfound_exception.dart';
import '../../core/helpers/jwt_helper.dart';

part 'auth_controller.g.dart';

class AuthController {
  final _userRepository = UserRepository();

  @Route.post('/')
  Future<Response> login(Request request) async {
    final jsonRQ = jsonDecode(await request.readAsString());

    try {
      UserModel user =
          await _userRepository.login(jsonRQ['email'], jsonRQ['password']);

      if (user.id != null) {
        final token = JwtHelper.generateJWT(user.id!, 1, user.name);
        user.password = token;

        return Response.ok(user.toJson(), headers: {
          'content-type': 'application/json',
          'access_token': token
        });
      }
      return Response(401, headers: {
        'content-type': 'application/json',
      });
    } on UserNotfoundException catch (e, s) {
      print(e);
      print(s);
      return Response(403, headers: {
        'content-type': 'application/json',
      });
    } catch (e, s) {
      print(e);
      print(s);
      return Response.internalServerError();
    }
  }

  @Route.post('/register')
  Future<Response> register(Request request) async {
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

  @Route.post('/update/password')
  Future<Response> updatePassword(Request request) async {
    final jsonRQ = jsonDecode(await request.readAsString());
    var retorno = "";

    bool ret = await _userRepository.updatePassword(
        jsonRQ['email'], jsonRQ['password']);

    if (ret == true) {
      retorno = 'true';
    } else {
      retorno = 'false';
    }

    return Response.ok(jsonEncode(retorno));
  }

  @Route.post('/url')
  Future<Response> url(Request request) async {
    final crypt = EncryptDecrypt();

    var urlHasura = crypt.encryptData(env['hasuraHost']!);
    var hasuraPass = crypt.encryptData(env['hasuraPassword']!);

    return Response(200,
        body: jsonEncode(
          {'urlHasura': urlHasura, 'hasuraPassword': hasuraPass},
        ),
        headers: {
          'content-type': 'application/json',
        });
  }

  Router get router => _$AuthControllerRouter(this);
}
