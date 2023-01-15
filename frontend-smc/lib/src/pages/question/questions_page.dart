// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smc/src/infra/responsive_media_query.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/shared/show_dialog.dart';
import 'package:smc/src/streams/stream.dart';
import 'package:smc/src/utils/notification_fush.dart';
import 'package:smc/src/utils/view_util.dart';

import '../../models/model.dart';
import '../../view_model/view_model.dart';
import '../pages.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int sortColumnIndex = 0;
  bool sortAscending = true;
  // ignore: unused_field
  bool _refresh = false;
  bool isAlvo = false;

  late QuestionDataSource _objDataSource;
  late double width;
  late double height;

  QuestionModel question = QuestionModel();

  List<QuestionModel> lista = [];

  int qtde = 0;

  String arquivo = '';
  String separador = ';;';

  final bloc = QuestionsModule.to.bloc<QuestionBloc>();

  late QuestionViewModel _objProvider;

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
    return StreamBuilder<List<QuestionModel>>(
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
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    _objProvider = Provider.of<QuestionViewModel>(context, listen: false);

    return AnimatedBuilder(
      animation: ThemeProvider.instance,
      builder: (context, child) {
        final corTexto =
            ThemeProvider.instance.isDarkTheme ? Colors.white : Colors.black;
        _objDataSource = QuestionDataSource(
            lista, context, _retornoCallBack, _excluiCallBack);
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
                      'Conversas (${qtde.toString()})',
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    ResponsiveMediaQuery.isMobile(context)
                        ? IconButton(
                            onPressed: () {
                              _dialogo();
                            },
                            icon: const Icon(FontAwesomeIcons.upload),
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                                elevation: 15,
                                shadowColor: primaryColor[800]),
                            onPressed: () {
                              _dialogo();
                            },
                            child: const Text(
                              'IMPORTAR TXT',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                    ResponsiveMediaQuery.isMobile(context)
                        ? IconButton(
                            onPressed: () {
                              _inserir();
                            },
                            icon: const Icon(FontAwesomeIcons.plus),
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                                elevation: 15,
                                shadowColor: primaryColor[800]),
                            onPressed: () {
                              _inserir();
                            },
                            child: const Text(
                              'ADICIONAR CONVERSA',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
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
                      "Id",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Descrição",
                      style: TextStyle(
                          color: corTexto,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                source: _objDataSource,
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
        builder: (BuildContext context) => QuestionPersistePage(
            question: QuestionModel(), title: ' - Novo', operacao: 'I'),
      ),
    );
  }

  _dialogo() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 5,
          backgroundColor:
              ThemeProvider.instance.isDarkTheme ? bgColor : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: SizedBox(
            height: 600,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ConstrainedBox(
                    //  fit: FlexFit.loose,
                    constraints: BoxConstraints(
                      maxHeight:
                          height, //when it reach the max it will use scroll
                      maxWidth: width,
                    ),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (RawKeyEvent event) {},
                      child: TextFormField(
                        focusNode: FocusNode(),
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 10,
                        maxLength: 9000000,
                        enabled: true,
                        initialValue: arquivo,
                        decoration: ViewUtil.getInputDecorationPersistePage(
                            'Informe as conversas.', 'conversas', false),
                        onSaved: (value) {
                          arquivo = value.toString();
                        },
                        onChanged: (text) {
                          arquivo = text;
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    focusNode: FocusNode(),
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    maxLength: 2,
                    enabled: true,
                    initialValue: separador,
                    decoration: ViewUtil.getInputDecorationPersistePage(
                        'Separador.', 'separador', false),
                    onSaved: (value) {
                      separador = value.toString().trim();
                    },
                    onChanged: (text) {
                      separador = text.toString().trim();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        elevation: 15,
                        shadowColor: primaryColor[800]),
                    onPressed: () {
                      _importar();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _importar() async {
    try {
      if (arquivo.isNotEmpty) {
        Navigator.of(context).pop();
        final ar = arquivo.split(separador);
        ar.forEach((e) async {
          QuestionModel vo = QuestionModel();
          vo.id = 0;
          vo.name = e;
          await _importarSalvar(vo);
        });
      } else {
        NotificationFush(
                context: context,
                message: 'O campo conversas esta vázio',
                backgroundColor: Colors.red,
                colorShadow: Colors.red[800]!,
                gradient: const LinearGradient(
                    colors: [Colors.red, Colors.redAccent]),
                indicatorColor: Colors.red)
            .bar();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  _importarSalvar(QuestionModel obj) async {
    try {
      await _objProvider.inserir(obj);
    } catch (e) {
      print(e);
    }
  }

  _excluiCallBack(QuestionModel info) {
    Provider.of<QuestionViewModel>(context, listen: false).excluir(info.id);
  }

  _retornoCallBack(QuestionModel info) {
    setState(() {
      _refresh = true;
      question = info;
    });
  }
}

class QuestionDataSource extends DataTableSource {
  final List<QuestionModel> lista;
  final BuildContext context;
  Function retornoCallBack;
  Function excluirCallBack;

  QuestionDataSource(
      this.lista, this.context, this.retornoCallBack, this.excluirCallBack);

  final corTexto =
      ThemeProvider.instance.isDarkTheme ? Colors.white : Colors.black;

  // ignore: use_function_type_syntax_for_parameters, unused_element
  void _sort<T>(Comparable<T> getField(QuestionModel obj), bool ascending) {
    lista.sort((QuestionModel a, QuestionModel b) {
      if (!ascending) {
        final QuestionModel c = a;
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
    final QuestionModel info = lista[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
          Row(
            children: [
              Tooltip(
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
              ),
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
      ],
    );
  }

  @override
  int get rowCount => lista.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void alterar(BuildContext context, QuestionModel info) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => QuestionPersistePage(
            question: info, title: ' - Editar', operacao: 'A'),
      ),
    );
  }

  void excluir(BuildContext context, QuestionModel info) {
    gerarDialogBoxExclusao(context, () {
      excluirCallBack(info);
    }, mensagemPersonalizada: 'Deseja realmente excluir ?', corTexto: corTexto);
  }
}
