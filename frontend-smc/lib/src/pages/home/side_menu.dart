import 'package:flutter/material.dart';
import 'package:flutter_badged/badge_position.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smc/src/infra/responsive_media_query.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/infra/versao.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/utils/view_util.dart';

class SideMenu extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final scaffoldKey;
  const SideMenu({
    this.scaffoldKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var version = versao;
    return AnimatedBuilder(
        animation: ThemeProvider.instance,
        builder: (context, child) {
          return Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    ThemeProvider.instance.isMenu ? ViewUtil.nomeUsuario : '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  accountEmail: Text(
                    ThemeProvider.instance.isMenu
                        ? 'Versão: $version'
                        : version,
                    style: const TextStyle(color: Colors.white),
                  ),
                  currentAccountPicture: GestureDetector(
                    onTap: () {
                      if (!ResponsiveMediaQuery.isMobile(context)) {
                        ThemeProvider.instance.changeMenu();
                      }
                    },
                    child: ThemeProvider.instance.isMenu
                        ? Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.fill,
                            width: 93,
                            height: 93,
                          )
                        : Icon(FontAwesomeIcons.caretRight,
                            size: 48,
                            color: ThemeProvider.instance.isDarkTheme
                                ? Colors.white
                                : Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: ThemeProvider.instance.isDarkTheme
                        ? bgColor
                        : primaryColor,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Tooltip(
                    message: 'conexões',
                    child: FlutterBadge(
                      hideZeroCount: true,
                      badgeColor: Colors.red,
                      badgeTextColor: Colors.white,
                      position: BadgePosition.topRight(),
                      icon: Icon(FontAwesomeIcons.qrcode,
                          size: ThemeProvider.instance.isMenu ? 18 : 22,
                          color: ThemeProvider.instance.isDarkTheme
                              ? Colors.white
                              : primaryColor),
                      borderRadius: 20.0,
                      itemCount: ThemeProvider.instance.whatsDesconect,
                    ),
                  ),
                  title: Text(
                    ThemeProvider.instance.isMenu ? 'Conexões' : '',
                    style: TextStyle(
                        color: ThemeProvider.instance.isDarkTheme
                            ? Colors.white
                            : primaryColor),
                  ),
                  onTap: () => _verificarPermissao('0C', 'conections', context),
                ),
                const Divider(),
                ListTile(
                  leading: Tooltip(
                    message: 'iniciar disparos',
                    child: Icon(FontAwesomeIcons.commentDots,
                        size: ThemeProvider.instance.isMenu ? 18 : 22,
                        color: ThemeProvider.instance.isDarkTheme
                            ? Colors.white
                            : primaryColor),
                  ),
                  title: Text(
                    ThemeProvider.instance.isMenu ? 'Iniciar' : '',
                    style: TextStyle(
                        color: ThemeProvider.instance.isDarkTheme
                            ? Colors.white
                            : primaryColor),
                  ),
                  onTap: () => _verificarPermissao('0C', 'shots', context),
                ),
                const Divider(),
                ListTile(
                  leading: Tooltip(
                    message: 'Conversas',
                    child: Icon(FontAwesomeIcons.listUl,
                        size: ThemeProvider.instance.isMenu ? 18 : 22,
                        color: ThemeProvider.instance.isDarkTheme
                            ? Colors.white
                            : primaryColor),
                  ),
                  title: Text(
                    ThemeProvider.instance.isMenu ? 'Conversas' : '',
                    style: TextStyle(
                        color: ThemeProvider.instance.isDarkTheme
                            ? Colors.white
                            : primaryColor),
                  ),
                  onTap: () => _verificarPermissao('0C', 'questions', context),
                ),
                const Divider(),
                ListTile(
                  leading: Tooltip(
                    message: 'configurações',
                    child: Icon(FontAwesomeIcons.gear,
                        size: ThemeProvider.instance.isMenu ? 18 : 22,
                        color: ThemeProvider.instance.isDarkTheme
                            ? Colors.white
                            : primaryColor),
                  ),
                  title: Text(
                    ThemeProvider.instance.isMenu ? 'Configurações' : '',
                    style: TextStyle(
                        color: ThemeProvider.instance.isDarkTheme
                            ? Colors.white
                            : primaryColor),
                  ),
                  onTap: () =>
                      _verificarPermissao('0C', 'configurations', context),
                ),
                const Divider(),
                ListTile(
                  leading: Tooltip(
                    message: 'modo escuro',
                    child: Icon(FontAwesomeIcons.palette,
                        size: ThemeProvider.instance.isMenu ? 18 : 22,
                        color: ThemeProvider.instance.isDarkTheme
                            ? Colors.white
                            : primaryColor),
                  ),
                  title: Text(
                    ThemeProvider.instance.isMenu ? 'Modo Escuro' : '',
                    style: TextStyle(
                        color: ThemeProvider.instance.isDarkTheme
                            ? Colors.white
                            : primaryColor),
                  ),
                  onTap: () => ThemeProvider.instance.changeTheme(),
                ),
                const Divider(),
                ListTile(
                  leading: Tooltip(
                    message: 'Sair',
                    child: Icon(FontAwesomeIcons.arrowRightFromBracket,
                        size: ThemeProvider.instance.isMenu ? 18 : 22,
                        color: ThemeProvider.instance.isDarkTheme
                            ? Colors.white
                            : primaryColor),
                  ),
                  title: Text(
                    ThemeProvider.instance.isMenu ? 'Sair' : '',
                    style: TextStyle(
                        color: ThemeProvider.instance.isDarkTheme
                            ? Colors.white
                            : primaryColor),
                  ),
                  onTap: () => Navigator.pushNamed(context, "/"),
                ),
              ],
            ),
          );
        });
  }

  _verificarPermissao(String auth, String rota, context) {
    //if (Authorities.isAuthorities(auth)) {
    ThemeProvider.instance.setaRota(rota);
    //Navigator.pushNamed(context, rota);
    //} else {
    // Navigator.of(context).pop();
    //  message(context, 'Desculpe você está sem permissão para está ação.');
    //}
  }

  void message(context, String text) {
    scaffoldKey.currentState.hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
    );

    scaffoldKey.of(context).showSnackBar(snackBar);
  }

  // ignore: unused_element
  _trocarSenha(context) {
    /* showDialogTrocarSenha(
      context: context,
      mensagem: "Deseja trocar a sua senha?",
    );*/
  }
}
