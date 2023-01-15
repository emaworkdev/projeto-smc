import 'package:smc/src/infra/themes.dart';
import 'package:flutter/material.dart';
import 'package:smc/src/pages/home/home_page.dart';
import 'package:smc/src/pages/login/login_page.dart';

class Rotas {
  static Route<dynamic> definirRotas(RouteSettings settings) {
    switch (settings.name) {

      // Login
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      // Home
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());

      // default
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
              appBar: AppBar(
                backgroundColor: colorAppBar,
                title: const Text('Erro na rota de Navegação'),
                actions: const <Widget>[],
              ),
              body: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Center(
                    child: Text(
                      'Nenhuma rota definida para {$settings.name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              )),
        );
    }
  }
}
