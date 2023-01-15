import 'package:smc/src/infra/constantes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smc/src/pages/home/profile/user_profile.dart';
import 'package:smc/src/providers/theme_provider.dart';

class WebAppBar extends StatefulWidget {
  const WebAppBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WebAppBarState createState() => _WebAppBarState();
}

class _WebAppBarState extends State<WebAppBar> {
  int qtde = 0;

  late Color corTexto;

  @override
  void dispose() {
    super.dispose();
  }

  var controller = ThemeProvider.instance;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return _body(context);
      },
    );
  }

  _body(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 65,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      controller.changeMenu();
                    },
                    child: const Text(Constantes.appNameString))
              ],
            ),
          ),
          const SizedBox(
            width: 32,
          ),
          UserProfile(),
          const SizedBox(
            width: 16,
          ),
          OutlinedButton.icon(
            onPressed: () {
              controller.changeTheme();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 16, //Set font size
              ),
              side: BorderSide(
                color: controller.isDarkTheme ? Colors.green : Colors.white24,
                width: 2,
              ),
              padding: const EdgeInsets.all(
                  20.0), //Set the padding on all sides to 20px
            ),
            icon: const Icon(FontAwesomeIcons.palette), //Button icon
            label: const Text(""),
          ),
          const SizedBox(
            width: 16,
          ),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 16, //Set font size
              ),
              side: BorderSide(
                color: controller.isDarkTheme ? Colors.green : Colors.white24,
                width: 2,
              ),
              padding: const EdgeInsets.all(
                  20.0), //Set the padding on all sides to 20px
            ),
            icon: const Icon(
                FontAwesomeIcons.arrowRightFromBracket), //Button icon
            label: const Text("Sair"),
          ), //Button label
        ],
      ),
    );
  }
}
