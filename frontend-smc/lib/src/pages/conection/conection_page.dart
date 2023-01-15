import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/shared/qr_code_widget.dart';
import 'package:smc/src/shared/show_dialog.dart';
import 'package:smc/src/streams/stream.dart';
import 'package:smc/src/utils/view_util.dart';

import '../../models/model.dart';
import '../../view_model/view_model.dart';
import '../pages.dart';
import 'package:uiblock/uiblock.dart';

class ConectionPage extends StatefulWidget {
  const ConectionPage({super.key});

  @override
  State<ConectionPage> createState() => _ConectionPageState();
}

class _ConectionPageState extends State<ConectionPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int sortColumnIndex = 0;
  bool sortAscending = true;
  bool _refresh = false;
  bool isAlvo = false;

  late ConnectionDataSource _connectionDataSource;

  WhatsappModel whatsapp = WhatsappModel();

  List<WhatsappModel> lista = [];

  int qtde = 0;
  int idc = 0;

  bool libera = false;

  final bloc = ConectionModule.to.bloc<WhatsappBloc>();

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
    return StreamBuilder<List<WhatsappModel>>(
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

        if (lista.isNotEmpty) {
          if (idc != 0) {
            // ignore: avoid_function_literals_in_foreach_calls
            lista.forEach(
              (e) {
                if (e.id == idc) {
                  if (e.status == 'CONNECTED' || e.status == 'DESCONNECTED') {
                    idc = 0;
                    _refresh = false;
                  }
                }
              },
            );
          }
        }

        return Column(
          children: [
            Expanded(
              child: _body(context),
            ),
            _refresh ? _qrCode() : Container(),
          ],
        );
      },
    );
  }

  _body(BuildContext context) {
    qtde = lista.isNotEmpty ? lista.length : 0;
    isAlvo = qtde > 0 ? false : true;

    libera = qtde < ViewUtil.sessionQtde ? true : false;

    return AnimatedBuilder(
      animation: ThemeProvider.instance,
      builder: (context, child) {
        final corTexto =
            ThemeProvider.instance.isDarkTheme ? Colors.white : Colors.black;
        _connectionDataSource = ConnectionDataSource(lista, context,
            _retornoCallBack, _excluiCallBack, _start, _desconect, isAlvo);

        return Scrollbar(
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              const SizedBox(
                width: 8,
              ),
              PaginatedDataTable(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Conexões (${qtde.toString()})',
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Max: (${ViewUtil.sessionQtde.toString()})',
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Visibility(
                      visible: qtde < ViewUtil.sessionQtde ? true : false,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            elevation: 15,
                            shadowColor: primaryColor[800]),
                        onPressed: () {
                          _inserir();
                        },
                        child: const Text(
                          'ADICIONAR WHATSAPP',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                rowsPerPage: _rowsPerPage,
                onRowsPerPageChanged: (value) {
                  setState(() {
                    _rowsPerPage = value!;
                  });
                },
                sortColumnIndex: sortColumnIndex,
                sortAscending: sortAscending,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      "Ações",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Id Instância",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Nome",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Numero",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Status",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Sessão",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Última Atualização",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Alvo",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                source: _connectionDataSource,
              ),
            ],
          ),
        );
      },
    );
  }

  _inserir() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ConectionPersistePage(
            whatsapp: WhatsappModel(),
            title: ' - Novo',
            operacao: 'I',
            alvo: isAlvo),
      ),
    );
  }

  _excluiCallBack(WhatsappModel info) {
    Provider.of<ConectionViewModel>(context, listen: false).excluir(info.id);
  }

  _retornoCallBack(WhatsappModel info) {
    setState(() {
      _refresh = true;
      whatsapp = info;
      idc = info.id;
    });
  }

  _qrCode() {
    return QrCodeWidget(
      qrcode: whatsapp.qrcode,
    );
  }

  _start(WhatsappModel obj) {
    try {
      UIBlock.block(context, loadingTextWidget: const Text("Aguarde..."));
      Provider.of<ConectionViewModel>(context, listen: false)
          .start(obj.session, obj.isDefault);
      Timer(const Duration(seconds: 10), () {
        UIBlock.unblock(context);
      });
    } catch (e) {
      UIBlock.unblock(context);
    }
  }

  _desconect(WhatsappModel obj) {
    try {
      UIBlock.block(context, loadingTextWidget: const Text("Aguarde..."));
      Provider.of<ConectionViewModel>(context, listen: false)
          .logout(obj.session, obj.isDefault);
      Timer(const Duration(seconds: 10), () {
        UIBlock.unblock(context);
      });
    } catch (e) {
      UIBlock.unblock(context);
    }
  }
}

class ConnectionDataSource extends DataTableSource {
  final List<WhatsappModel> lista;
  final BuildContext context;
  Function retornoCallBack;
  Function excluirCallBack;
  Function startCallBack;
  Function desconectCallBack;
  bool alvo;

  ConnectionDataSource(
      this.lista,
      this.context,
      this.retornoCallBack,
      this.excluirCallBack,
      this.startCallBack,
      this.desconectCallBack,
      this.alvo);

  final corTexto =
      ThemeProvider.instance.isDarkTheme ? Colors.white : Colors.black;

  // ignore: use_function_type_syntax_for_parameters, unused_element
  void _sort<T>(Comparable<T> getField(WhatsappModel obj), bool ascending) {
    lista.sort((WhatsappModel a, WhatsappModel b) {
      if (!ascending) {
        final WhatsappModel c = a;
        a = b;
        b = c;
      }
      Comparable<T> aValue = getField(a);
      Comparable<T> bValue = getField(b);

      // ignore: prefer_conditional_assignment, unnecessary_null_comparison
      if (aValue == null) aValue = '' as Comparable<T>;
      // ignore: prefer_conditional_assignment, unnecessary_null_comparison
      if (bValue == null) bValue = '' as Comparable<T>;

      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  // ignore: prefer_final_fields
  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= lista.length) return null;
    final WhatsappModel info = lista[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
          Row(
            children: [
              /*Tooltip(
                message: 'Editar',
                child: IconButton(
                  iconSize: 22,
                  color: Colors.green[900],
                  icon: const FaIcon(FontAwesomeIcons.pen,
                      size: 16, color: Colors.green),
                  onPressed: () async {
                    alterar(context, info);
                  },
                ),
              ),*/
              Tooltip(
                message: 'Excluir',
                child: IconButton(
                  iconSize: 22,
                  color: Colors.red[900],
                  icon: const FaIcon(FontAwesomeIcons.trash,
                      size: 16, color: Colors.red),
                  onPressed: () async {
                    excluir(context, info);
                  },
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            '${info.id ?? ''}',
            style: TextStyle(color: corTexto),
          ),
        ),
        DataCell(
          Text(
            '${info.name ?? ''}',
            style: TextStyle(color: corTexto),
          ),
        ),
        DataCell(
          Text(
            '${info.number ?? ''}',
            style: TextStyle(color: corTexto),
          ),
        ),
        DataCell(
          Tooltip(
            message: info.status == 'CONNECTED' ? 'conectado' : 'desconetado',
            child: info.status == 'CONNECTED'
                ? const FaIcon(FontAwesomeIcons.signal,
                    size: 22, color: Colors.green)
                : const FaIcon(FontAwesomeIcons.signal,
                    size: 22, color: Colors.red),
          ),
        ),
        DataCell(
          Tooltip(
            message: '',
            child: _botoes(context, info),
          ),
        ),
        DataCell(
          Text(
              info.updatedAt != null
                  ? DateFormat('dd/MM/yyyy HH:mm').format(info.updatedAt!)
                  : '',
              style: TextStyle(color: corTexto)),
        ),
        DataCell(
          Row(
            children: [
              Visibility(
                visible: info.isDefault == true ? true : false,
                child: const FaIcon(FontAwesomeIcons.circleCheck,
                    size: 22, color: Colors.green),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => lista.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void alterar(BuildContext context, WhatsappModel info) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ConectionPersistePage(
            whatsapp: info, title: ' - Editar', operacao: 'A', alvo: alvo),
      ),
    );
  }

  void excluir(BuildContext context, WhatsappModel info) {
    gerarDialogBoxExclusao(context, () {
      excluirCallBack(info);
    },
        mensagemPersonalizada: 'Deseja realmente excluir está conexão ?',
        corTexto: corTexto);
  }

  _botoes(BuildContext context, WhatsappModel info) {
    if (info.status == "DESCONNECTED") {
      return OutlinedButton.icon(
        onPressed: () {
          startCallBack(info);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 12, //Set font size
          ),
          side: const BorderSide(
            color: primaryColor,
            width: 2,
          ),
          padding:
              const EdgeInsets.all(20.0), //Set the padding on all sides to 20px
        ),
        icon: const Icon(FontAwesomeIcons.plug,
            color: primaryColor), //Button icon
        label: const Text(
          "CONECTAR",
          style: TextStyle(color: primaryColor),
        ),
      );
    } else if (info.status == 'CONNECTED') {
      return OutlinedButton.icon(
        onPressed: () {
          desconectCallBack(info);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 12, //Set font size
          ),
          side: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
          padding:
              const EdgeInsets.all(20.0), //Set the padding on all sides to 20px
        ),
        icon: const Icon(FontAwesomeIcons.powerOff,
            color: Colors.red), //Button icon
        label: const Text(
          "DESCONECTAR",
          style: TextStyle(color: Colors.red),
        ),
      );
    } else {
      if (info.qrcode == null) {
        return const SizedBox(
          height: 18,
          width: 18,
          child: Center(
            child: CircularProgressIndicator(color: primaryColor),
          ),
        );
      } else {
        return OutlinedButton.icon(
          onPressed: () {
            retornoCallBack(info);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 12, //Set font size
            ),
            side: const BorderSide(
              color: primaryColor,
              width: 2,
            ),
            padding: const EdgeInsets.all(
                20.0), //Set the padding on all sides to 20px
          ),
          icon: const Icon(FontAwesomeIcons.qrcode,
              color: primaryColor), //Button icon
          label: const Text(
            "QRCODE",
            style: TextStyle(color: primaryColor),
          ),
        );
      }
    }
  }
}
