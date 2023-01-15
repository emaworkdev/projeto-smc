import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smc/src/infra/constantes.dart';
import 'package:smc/src/infra/locator.dart';
import 'package:smc/src/infra/rotas.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/utils/view_util.dart';
import 'package:smc/src/view_model/view_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/pages/login/login_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/dir/.env");
  setUrlStrategy(PathUrlStrategy());
  ViewUtil.kisweb = kIsWeb;

  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => locator<LoginViewModel>()),
          ChangeNotifierProvider(create: (_) => locator<UserViewModel>()),
          ChangeNotifierProvider(create: (_) => locator<SettingViewModel>()),
          ChangeNotifierProvider(create: (_) => locator<ConectionViewModel>()),
          ChangeNotifierProvider(create: (_) => locator<QuestionViewModel>()),
          ChangeNotifierProvider(create: (_) => locator<ShotsViewModel>()),
        ],
        builder: (context, value) {
          return FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              return _materialApp(context: context);
            },
          );
        });
  }
}

Widget _materialApp({BuildContext? context}) {
  _variaveis();
  return AnimatedBuilder(
    animation: ThemeProvider.instance,
    builder: (context, child) {
      return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        title: Constantes.appNameString,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Rotas.definirRotas,
        theme: ThemeData(
          primarySwatch: primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          //scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(
                  bodyColor: ThemeProvider.instance.isDarkTheme
                      ? Colors.white
                      : Colors.black),
          //canvasColor: secondaryColor,
          brightness: ThemeProvider.instance.isDarkTheme
              ? Brightness.dark
              : Brightness.light,
        ),
        home: const LoginPage(),
      );
    },
  );
}

_variaveis() {
  /*
  if (kReleaseMode) {
    ViewUtil.apiHost = const String.fromEnvironment('API_SERVER',
        defaultValue: 'api_host_erro');
  } else {
    ViewUtil.apiHost = dotenv.env['endpointApi']!;
  }
  */
  ViewUtil.apiHost = dotenv.env['endpointApi']!;
}
