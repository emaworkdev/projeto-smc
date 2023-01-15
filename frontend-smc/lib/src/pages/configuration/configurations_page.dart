import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smc/src/infra/biblioteca.dart';
import 'package:smc/src/infra/responsive_media_query.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/pages/configuration/configurations_module.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/streams/setting_bloc.dart';
import 'package:smc/src/utils/notification_fush.dart';

import '../../commons/commons.dart';
import '../../models/model.dart';
import '../../view_model/setting_view_model.dart';

class ConfigurationsPage extends StatefulWidget {
  const ConfigurationsPage({super.key});

  @override
  State<ConfigurationsPage> createState() => _ConfigurationsPageState();
}

class _ConfigurationsPageState extends State<ConfigurationsPage> {
  List<SettingModel> lista = [];
  int qtde = 0;
  late Color corTexto;
  late String selected;
  bool refresh = true;

  final bloc = ConfigurationsModule.to.bloc<SettingBloc>();

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
    if (refresh) {
      selected = '1-Minuto';
    }

    return StreamBuilder<List<SettingModel>>(
      stream: bloc.outl,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Não foi possível buscar os dados",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        lista = snapshot.data;

        return _body(context);
      },
    );
  }

  _body(BuildContext context) {
    qtde = lista.isNotEmpty ? lista.length : 0;

    return AnimatedBuilder(
      animation: ThemeProvider.instance,
      builder: (context, child) {
        corTexto =
            ThemeProvider.instance.isDarkTheme ? Colors.white : Colors.black;

        return Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: qtde,
                  itemBuilder: (context, index) {
                    return _card(context, lista[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _card(BuildContext context, SettingModel obj) {
    String m = obj.key == 'timeOn' ? 'Inicial' : 'Final';
    String msg = ResponsiveMediaQuery.isMobile(context)
        ? '$m - ${obj.content} s'
        : '${obj.description} - ${obj.content} segundos';
    String tool = 'Tempo em Segundos: ${obj.content}';
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 100,
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                  width: 2.0, color: Biblioteca().getColorRandomic()),
            ),
            color: ThemeProvider.instance.isDarkTheme ? bgColor : Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                getSwitch(
                                  texto: msg,
                                  tooltip: tool,
                                  textColor: corTexto,
                                  isSwitched: obj.value,
                                  onPressed: (value) {
                                    setState(() {
                                      refresh = false;
                                      obj.value = value;
                                    });
                                    _salvar(obj);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _salvar(SettingModel obj) {
    Provider.of<SettingViewModel>(context, listen: false).alterar(obj);
    NotificationFush(
            context: context,
            message: 'Registro salvo com sucesso.',
            backgroundColor: Colors.green,
            colorShadow: Colors.green[800]!,
            gradient: const LinearGradient(
                colors: [Colors.green, Colors.greenAccent]),
            indicatorColor: Colors.green)
        .bar();
  }
}
