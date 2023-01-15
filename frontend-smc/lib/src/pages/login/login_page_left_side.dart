// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smc/src/infra/versao.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/shared/app_text_field.dart';
import 'package:smc/src/utils/notification_fush.dart';
import 'package:smc/src/utils/view_util.dart';

import '../../view_model/view_model.dart';

// ignore: must_be_immutable
class LoginPageLeftSide extends StatefulWidget {
  const LoginPageLeftSide({Key? key}) : super(key: key);

  @override
  State<LoginPageLeftSide> createState() => _LoginPageLeftSideState();
}

class _LoginPageLeftSideState extends State<LoginPageLeftSide> {
  late double size;
  late double pad;

  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final _focusSenha = FocusNode();
  final _focusButton = FocusNode();

  @override
  Widget build(BuildContext context) {
    _obterUrl();

    _tLogin.text = '';
    _tSenha.text = '';

    size = MediaQuery.of(context).size.width;
    pad = size > 900 ? 120.0 : 20.0;
    return AnimatedBuilder(
      animation: ThemeProvider.instance,
      builder: (context, child) {
        return _tela(context);
      },
    );
  }

  _tela(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(pad),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.fill,
                    height: 120,
                    width: 120,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "Bem vindo!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Faça login",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: "email",
                hint: "digite o email",
                color: Colors.white,
                controller: _tLogin,
                validator: (s) => _validateLogin(s!),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autoFocus: true,
                isIcon: true,
                icone: FontAwesomeIcons.user,
                nextFocus: _focusSenha,
                onChanged: (s) => _tLogin,
                focusNode: _focusSenha,
              ),
              const SizedBox(
                height: 16,
              ),
              AppTextField(
                label: "senha",
                hint: "digite a senha",
                color: Colors.white,
                controller: _tSenha,
                password: true,
                validator: (s) => _validateSenha(s!),
                keyboardType: TextInputType.text,
                autoFocus: false,
                focusNode: _focusButton,
                onChanged: (s) => _tSenha,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              const SizedBox(height: 12),
              MaterialButton(
                onPressed: () {
                  _login();
                },
                minWidth: double.infinity,
                height: 52,
                elevation: 24,
                color: Colors.white,
                textColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                child: const Text("Login"),
              ),
              const SizedBox(height: 12),
              const SizedBox(height: 60),
              Align(
                alignment: Alignment.bottomLeft,
                child: MaterialButton(
                    child: const Text(
                      "Versão: $versao",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _verificateEmailPassword();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _verificateEmailPassword() async {
    /*
    if (_tLogin.text.isNotEmpty) {
      ViewUtil.email = _tLogin.text;
      await Provider.of<EmailViewModel>(context, listen: false)
          .remeberPassword(_tLogin.text);
      NotificationFush(context: context, message: "verifique o seu email.")
          .bar();
      controller.verifieldEmailFleg(false);
      controller.emailVerificarPage(true);
    } else {
      NotificationFush(
              context: context,
              message: 'tem que digitar o seu email',
              backgroundColor: Colors.red,
              colorShadow: Colors.red[800]!,
              gradient:
                  const LinearGradient(colors: [Colors.red, Colors.redAccent]),
              indicatorColor: Colors.red)
          .bar();
    }
    */
  }

  _obterUrl() async {
    await Provider.of<LoginViewModel>(context, listen: false).urlHost();
  }

  _login() async {
    if (_tLogin.text.isNotEmpty) {
      if (_tSenha.text.isNotEmpty) {
        dynamic ret = await Provider.of<LoginViewModel>(context, listen: false)
            .autenticar(_tLogin.text.toLowerCase(), _tSenha.text.toLowerCase());

        if (ret != null) {
          /*
          if (ret['verified_email'] == 0) {
            var rt = await Provider.of<EmailViewModel>(context, listen: false)
                .remeber();
            if (rt == "sucesso") {
              NotificationFush(
                      context: context,
                      message:
                          """Seu email ainda não foi verificado! 
          por favor realize a verificação do email.
          clique em >>> verificar email <<<<
          """,
                      backgroundColor: Colors.blue,
                      colorShadow: Colors.blue[800]!,
                      gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.teal]),
                      indicatorColor: Colors.blue)
                  .bar();

              controller.emailVerificarPage(true);
            } else {
              NotificationFush(
                      context: context,
                      message:
                          '''Não foi possivel criar o código de verificação do email!!!
      ''',
                      backgroundColor: Colors.red,
                      colorShadow: Colors.red[800]!,
                      gradient: const LinearGradient(
                          colors: [Colors.red, Colors.redAccent]),
                      indicatorColor: Colors.red)
                  .bar();
            }
          } else {
          */
          Navigator.of(context).pop();
          Navigator.pushNamed(context, '/home');
          //}
        } else {
          NotificationFush(
                  context: context,
                  message:
                      '''Não foi possivel realizar o login.
      verifique: o seu usuário e ou a senha!!!
      ''',
                  backgroundColor: Colors.red,
                  colorShadow: Colors.red[800]!,
                  gradient: const LinearGradient(
                      colors: [Colors.red, Colors.redAccent]),
                  indicatorColor: Colors.red)
              .bar();
        }
      } else {
        NotificationFush(
                context: context,
                message: 'tem que digitar a sua senha',
                backgroundColor: Colors.red,
                colorShadow: Colors.red[800]!,
                gradient: const LinearGradient(
                    colors: [Colors.red, Colors.redAccent]),
                indicatorColor: Colors.red)
            .bar();
      }
    } else {
      NotificationFush(
              context: context,
              message: 'tem que digitar o seu email',
              backgroundColor: Colors.red,
              colorShadow: Colors.red[800]!,
              gradient:
                  const LinearGradient(colors: [Colors.red, Colors.redAccent]),
              indicatorColor: Colors.red)
          .bar();
    }
  }

  String? _validateLogin(String text) {
    if (text.isEmpty) {
      ViewUtil.showInSnackBar(
          'Por favor, informe o seu login.', Colors.red, context);
    }
    return null;
  }

  String? _validateSenha(String text) {
    if (text.isEmpty) {
      ViewUtil.showInSnackBar(
          'Por favor, informe a sua senha.', Colors.red, context);
    }
    return null;
  }
}
