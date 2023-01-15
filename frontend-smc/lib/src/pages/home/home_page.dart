import 'package:flutter/material.dart';
import 'package:smc/src/infra/colors.dart';
import 'package:smc/src/infra/responsive_media_query.dart';
import 'package:smc/src/providers/theme_provider.dart';

import '../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = ThemeProvider.instance;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
    return Scaffold(
      key: drawerKey,
      drawer: const SideMenu(),
      appBar: !ResponsiveMediaQuery.isDesktop(context)
          ? AppBar(
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    controller.isMenu = true;
                    drawerKey.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: AppCores.white)),
              actions: const [],
            )
          : const PreferredSize(
              preferredSize: Size(double.infinity, 65),
              child: WebAppBar(),
            ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (ResponsiveMediaQuery.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: controller.isMenu ? 5 : 15,
              child: _selection(),
            ),
          ],
        ),
      ),
    );
  }

  _selection() {
    if (controller.rota == 'conections') {
      return const ConectionModule();
    } else if (controller.rota == 'questions') {
      return const QuestionsModule();
    } else if (controller.rota == 'shots') {
      return const ShotsModule();
    } else if (controller.rota == 'configurations') {
      return const ConfigurationsModule();
    }
  }
}
