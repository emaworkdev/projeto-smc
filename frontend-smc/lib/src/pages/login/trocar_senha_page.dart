// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/shared/app_text_field.dart';
import 'package:smc/src/shared/responsive_widget.dart';
import 'package:smc/src/utils/notification_fush.dart';
import 'package:smc/src/utils/view_util.dart';
import 'package:smc/src/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class TrocarSenhaPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TrocarSenhaPage();

  @override
  // ignore: library_private_types_in_public_api
  _TrocarSenhaPageState createState() => _TrocarSenhaPageState();
}

class _TrocarSenhaPageState extends State<TrocarSenhaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color textColor = Colors.white.withOpacity(0.4);
  var corTexto;

  final AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  final _tSenha = TextEditingController();
  final _focusButton = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tSenha.text = "";
    return AnimatedBuilder(
      animation: ThemeProvider.instance,
      builder: (context, child) {
        corTexto =
            ThemeProvider.instance.isDarkTheme ? Colors.white : Colors.black;
        return ResponsiveWidget.isLargeScreen(context)
            ? _dadosW(context)
            : _dadosM(context);
      },
    );
  }

  _dadosW(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextField(
              label: "Senha",
              hint: "digite a senha",
              color: corTexto,
              width: 200,
              controller: _tSenha,
              password: true,
              validator: (s) => null,
              keyboardType: TextInputType.text,
              autoFocus: true,
              focusNode: _focusButton,
              onChanged: (s) => _tSenha,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              width: 16,
            ),
            TextButton(
              child: Row(children: [
                const Icon(FontAwesomeIcons.floppyDisk,
                    size: 22, color: Colors.green),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Salvar",
                  style: TextStyle(color: corTexto),
                )
              ]),
              onPressed: () {
                _editar(context);
              },
            ),
            const SizedBox(
              width: 16,
            ),
            TextButton(
              child: Row(children: [
                const Icon(FontAwesomeIcons.xmark, size: 22, color: Colors.red),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Cancelar",
                  style: TextStyle(color: corTexto),
                )
              ]),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  _dadosM(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextField(
              label: "Senha",
              hint: "digite a senha",
              color: corTexto,
              width: 200,
              controller: _tSenha,
              password: true,
              validator: (s) => null,
              keyboardType: TextInputType.text,
              autoFocus: true,
              focusNode: _focusButton,
              onChanged: (s) => _tSenha,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              width: 16,
            ),
            TextButton(
              child: Row(children: const [
                Icon(FontAwesomeIcons.floppyDisk,
                    size: 22, color: Colors.green),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Salvar",
                  style: TextStyle(color: Colors.black),
                )
              ]),
              onPressed: () {
                _editar(context);
              },
            ),
            const SizedBox(
              width: 16,
            ),
            TextButton(
              child: Row(children: const [
                Icon(FontAwesomeIcons.xmark, size: 22, color: Colors.red),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.black),
                )
              ]),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  _editar(BuildContext context) async {
    if (_tSenha.text.isNotEmpty) {
      bool ret = await Provider.of<UserViewModel>(context, listen: false)
          .updatePassword(ViewUtil.email, _tSenha.text);
      if (ret) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        NotificationFush(
                context: context, message: "Senha alterado com sucesso!")
            .bar();
      } else {
        NotificationFush(
                context: context,
                message: 'Não foi possivel alterar a senha.',
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
              message: 'você tem que informa a nova senha.',
              backgroundColor: Colors.amber,
              colorShadow: Colors.amber[800]!,
              gradient: const LinearGradient(
                  colors: [Colors.amber, Colors.amberAccent]),
              indicatorColor: Colors.amber)
          .bar();
    }
  }
}
