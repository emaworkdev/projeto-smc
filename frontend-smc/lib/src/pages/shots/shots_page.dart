import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/shared/show_dialog.dart';
import 'package:smc/src/streams/stream.dart';
import 'package:smc/src/utils/funcao_date.dart';

import '../../models/model.dart';
import '../../view_model/view_model.dart';
import '../pages.dart';
import 'package:uiblock/uiblock.dart';

class ShotsPage extends StatefulWidget {
  const ShotsPage({super.key});

  @override
  State<ShotsPage> createState() => _ShotsPageState();
}

class _ShotsPageState extends State<ShotsPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int sortColumnIndex = 0;
  bool sortAscending = true;
  // ignore: unused_field, prefer_final_fields
  bool _refresh = false;
  bool isAlvo = false;

  late ShotDataSource _shotDataSource;

  ShotsModel shot = ShotsModel();

  List<ShotsModel> lista = [];

  int qtde = 0;
  int qtdel = 0;
  int idc = 0;

  final bloc = ShotsModule.to.bloc<ShotsBloc>();

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
    return StreamBuilder<List<ShotsModel>>(
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

        return Column(
          children: [
            Expanded(
              child: _body(context),
            ),
          ],
        );
      },
    );
  }

  _body(BuildContext context) {
    qtde = lista.isNotEmpty ? lista.length : 0;
    qtdel = 0;
    isAlvo = qtde > 0 ? false : true;
    if (qtde > 0) {
      // ignore: avoid_function_literals_in_foreach_calls
      lista.forEach((e) {
        if (e.finished == true) {
          isAlvo = true;
        }
      });
      // ignore: avoid_function_literals_in_foreach_calls
      lista.forEach((e) {
        if (e.finished == false) {
          isAlvo = false;
          qtdel++;
        }
      });
    }
    return AnimatedBuilder(
      animation: ThemeProvider.instance,
      builder: (context, child) {
        final corTexto =
            ThemeProvider.instance.isDarkTheme ? Colors.white : Colors.black;
        _shotDataSource =
            ShotDataSource(lista, context, _excluir, _start, _pausa);

        if (ThemeProvider.instance.whatsDesconect < 2) {
          isAlvo = false;
        }

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
                      'Disparos (${qtdel.toString()})',
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Visibility(
                      visible: isAlvo,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            elevation: 15,
                            shadowColor: primaryColor[800]),
                        onPressed: () {
                          _inserir();
                        },
                        child: const Text(
                          'ADICIONAR DISPAROS',
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
                      "Id ",
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
                    numeric: true,
                    label: Text(
                      "Enviados",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Text(
                      "Recebidos",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Iniciar",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Finalizar",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Finalizado",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                source: _shotDataSource,
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
        builder: (BuildContext context) => ShotsPersistePage(
            shot: ShotsModel(), title: ' - Novo', operacao: 'I', alvo: isAlvo),
      ),
    );
  }

  _excluir(ShotsModel info) {
    Provider.of<ShotsViewModel>(context, listen: false).excluir(info.id);
  }

  _start(ShotsModel obj) {
    try {
      UIBlock.block(context, loadingTextWidget: const Text("Aguarde..."));
      Provider.of<ShotsViewModel>(context, listen: false).start(obj.id);
      UIBlock.unblock(context);
    } catch (e) {
      UIBlock.unblock(context);
    }
  }

  _pausa(ShotsModel obj) {
    try {
      UIBlock.block(context, loadingTextWidget: const Text("Aguarde..."));
      Provider.of<ShotsViewModel>(context, listen: false).pause(obj.id);
      UIBlock.unblock(context);
    } catch (e) {
      UIBlock.unblock(context);
    }
  }
}

class ShotDataSource extends DataTableSource {
  final List<ShotsModel> lista;
  final BuildContext context;
  Function excluirCallBack;
  Function startCallBack;
  Function pausaCallBack;

  ShotDataSource(this.lista, this.context, this.excluirCallBack,
      this.startCallBack, this.pausaCallBack);

  final corTexto =
      ThemeProvider.instance.isDarkTheme ? Colors.white : Colors.black;

  // ignore: use_function_type_syntax_for_parameters, unused_element
  void _sort<T>(Comparable<T> getField(ShotsModel obj), bool ascending) {
    lista.sort((ShotsModel a, ShotsModel b) {
      if (!ascending) {
        final ShotsModel c = a;
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
    final ShotsModel info = lista[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
          Row(
            children: [
              Visibility(
                visible: !info.start && !info.finished,
                child: Tooltip(
                  message: 'Liberar',
                  child: IconButton(
                    iconSize: 22,
                    color: Colors.green[900],
                    icon: const FaIcon(FontAwesomeIcons.gears,
                        size: 16, color: primaryColor),
                    onPressed: () async {
                      start(context, info);
                    },
                  ),
                ),
              ),
              Visibility(
                visible: info.start && !info.finished,
                child: Tooltip(
                  message: 'Pausar',
                  child: IconButton(
                    iconSize: 22,
                    color: Colors.red[900],
                    icon: const FaIcon(FontAwesomeIcons.pause,
                        size: 16, color: Colors.red),
                    onPressed: () async {
                      pausa(context, info);
                    },
                  ),
                ),
              ),
              Visibility(
                visible: !info.finished,
                child: Tooltip(
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
          Tooltip(
            message: 'disparos enviados',
            child: Text(
              '${info.alvo ?? '0'}',
              style: TextStyle(color: corTexto),
            ),
          ),
        ),
        DataCell(
          Tooltip(
            message: 'disparos recebidos',
            child: Text(
              '${info.client ?? '0'}',
              style: TextStyle(color: corTexto),
            ),
          ),
        ),
        DataCell(
          Text(
              info.datestart != null
                  ? FuncaoData().formataDataDDMMAAAA(info.datestart)
                  : '',
              style: TextStyle(color: corTexto)),
        ),
        DataCell(
          Text(
              info.datestart != null
                  ? FuncaoData().formataDataDDMMAAAA(info.datefinalize)
                  : '',
              style: TextStyle(color: corTexto)),
        ),
        DataCell(
          Row(
            children: [
              Visibility(
                visible: info.finished == true ? true : false,
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

  void start(BuildContext context, ShotsModel info) {
    gerarDialogBoxConfirmacao(context, 'Liberar os disparos ?', '${info.name}',
        () {
      startCallBack(info);
    });
  }

  void pausa(BuildContext context, ShotsModel info) {
    gerarDialogBoxConfirmacao(context, 'Pausar os disparos ?', '${info.name}',
        () {
      pausaCallBack(info);
    });
  }

  void excluir(BuildContext context, ShotsModel info) {
    gerarDialogBoxExclusao(context, () {
      excluirCallBack(info);
    }, mensagemPersonalizada: 'Deseja realmente excluir ?', corTexto: corTexto);
  }
}
