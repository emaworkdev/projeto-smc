import 'package:smc/src/utils/view_util.dart';

class ServiceBase {
  static const String linguagemServidor = 'dart';

  /// define o cabeçalho enviado em todas as requisições que segue com o Token JWT
  static Map<String, String> cabecalhoRequisicao = linguagemServidor == 'dart'
      ? {
          "Content-type": "application/json",
          "Authentication": "Bearer ${ViewUtil.tokenJWT}"
        }
      : {
          "Content-type": "application/json",
          "Authorization": "Bearer ${ViewUtil.tokenJWT}"
        };

  // ignore: prefer_final_fields
  static var _url = '';
  get url => _url;
}
