import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/pages/login/trocar_senha_page.dart';
import 'package:smc/src/providers/theme_provider.dart';

showDialogTrocarSenha({
  required BuildContext context,
  String titulo = "Trocar Senha",
  String mensagem = "Senha",
  DialogType tipo = DialogType.success,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _corpoDialogoTrocarSenha(
            context: context, mensagem: mensagem, titulo: titulo, tipo: tipo),
      );
    },
  );
}

_corpoDialogoTrocarSenha({
  required BuildContext context,
  required String titulo,
  required String mensagem,
  required DialogType tipo,
}) {
  return AnimatedBuilder(
    animation: ThemeProvider.instance,
    builder: (context, child) {
      final corTexto =
          ThemeProvider.instance.isDarkTheme ? Colors.white : Colors.black;
      return Stack(
        children: <Widget>[
          Container(
            width: 700,
            padding:
                const EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 20),
            margin: const EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: ThemeProvider.instance.isDarkTheme
                    ? colorBackgroundDark
                    : Colors.indigo[50],
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                Text(
                  titulo,
                  style: TextStyle(
                      color: corTexto,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  mensagem,
                  style: TextStyle(
                    color: corTexto,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 22,
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TrocarSenhaPage(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: Image.asset("assets/images/secret.png"),
              ),
            ),
          ),
        ],
      );
    },
  );
}

/// Retorna um diálogo de Confirmar
gerarDialogBoxConfirmar(BuildContext context, Function() onOkPressed,
    {String? mensagemPersonalizada}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.question,
    borderSide: const BorderSide(color: Colors.blue, width: 2),
    width: 400,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: 'Confirmação',
    desc: mensagemPersonalizada ?? 'Deseja alterar esse registro?',
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: onOkPressed,
    btnOkText: 'Sim',
    btnCancelText: 'Não',
  ).show();
}

/// Retorna um diálogo de informação
gerarDialogBoxInformacao(BuildContext context, String mensagem,
    {Function()? onOkPressed}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.info,
    borderSide: const BorderSide(color: Colors.green, width: 2),
    width: 400,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: 'Informação do Sistema',
    desc: mensagem,
    showCloseIcon: true,
    btnOkOnPress: onOkPressed ?? () {},
  ).show();
}

/// Retorna um diálogo de confirmação
gerarDialogBoxConfirmacao(BuildContext context, String titulo, String mensagem,
    Function() onOkPressed) {
  AwesomeDialog(
    context: context,
    //dialogBackgroundColor: Colors.white,
    dialogType: DialogType.question,
    borderSide: const BorderSide(color: Colors.green, width: 2),
    width: 400,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: titulo,
    desc: mensagem,
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: onOkPressed,
    btnOkText: 'Sim',
    btnCancelText: 'Não',
  ).show();
}

gerarDialogBoxExclusao(BuildContext context, Function() onOkPressed,
    {String? mensagemPersonalizada, String? title, Color? corTexto}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.question,
    borderSide: const BorderSide(color: Colors.green, width: 2),
    width: 400,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: title ?? 'Exclusão',
    desc: mensagemPersonalizada ?? 'Deseja realmente excluir sua conta?',
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: onOkPressed,
    btnOkText: 'Sim',
    btnCancelText: 'Não',
    titleTextStyle: TextStyle(color: corTexto ?? Colors.black),
    descTextStyle: TextStyle(color: corTexto ?? Colors.black),
  ).show();
}
