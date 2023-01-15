import 'dart:io';

import 'package:server_smc/application/config/application_config.dart';
import 'package:server_smc/core/middlewares/cors/cors_middleware.dart';
import 'package:server_smc/core/middlewares/default/default_content_type_middleware.dart';
import 'package:server_smc/core/middlewares/security/security_middleware.dart';
import 'package:server_smc/modules/auth/auth_controller.dart';
import 'package:server_smc/modules/question/question_controller.dart';
import 'package:server_smc/modules/setting/setting_controller.dart';
import 'package:server_smc/modules/shot/shots_controller.dart';
import 'package:server_smc/modules/user/user_controller.dart';
import 'package:server_smc/modules/webhook/web_hook_controller.dart';
import 'package:server_smc/modules/whatsapp/whatsapp_controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:dotenv/dotenv.dart';

final staticFiles = createStaticHandler('images/', listDirectories: true);

// Configure routes.
final _router = Router()
  ..mount('/images/', staticFiles)
  ..mount('/auth/', AuthController().router)
  ..mount('/users/', UserController().router)
  ..mount('/questions/', QuestionController().router)
  ..mount('/settings/', SettingController().router)
  ..mount('/shots/', ShotsController().router)
  ..mount('/whatsapps/', WhatsappController().router)
  ..mount('/webhooks/', WebHookController().router);

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  final appConfig = ApplicationConfig();
  await appConfig.loadConfigApplication();

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(CorsMiddleware().handler)
      .addMiddleware(
          DefaultContentTypeMiddleware('application/json; charset=utf-8')
              .handler)
      .addMiddleware(SecurityMiddleware().handler)
      .addMiddleware(logRequests())
      .addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? env['port']!);
  final server = await serve(handler, ip, port);

  print('Server listening on port ${server.port}');
}
