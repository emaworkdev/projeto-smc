// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smc/src/infra/responsive_media_query.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/shared/show_dialog.dart';
import 'package:smc/src/utils/view_util.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  var controller = ThemeProvider.instance;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            _trocarSenha(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: defaultPadding),
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: controller.isDarkTheme ? bgColor : primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: primaryColor,
                  child: Image.asset(
                    "assets/images/profile.png",
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                ),
                if (!ResponsiveMediaQuery.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: Text(ViewUtil.nomeUsuario),
                  ),
                //Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        );
      },
    );
  }

  _trocarSenha(context) {
    showDialogTrocarSenha(
      context: context,
      mensagem: "Deseja trocar a sua senha?",
    );
  }
}
