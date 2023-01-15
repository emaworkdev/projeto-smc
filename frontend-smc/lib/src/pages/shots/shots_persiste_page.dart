// ignore_for_file: use_build_context_synchronously

import 'package:date_format/date_format.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smc/src/infra/biblioteca.dart';
import 'package:smc/src/infra/constantes.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/models/model.dart';
import 'package:smc/src/pages/shots/shots_module.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/shared/show_dialog.dart';
import 'package:smc/src/utils/funcao_date.dart';
import 'package:smc/src/utils/notification_fush.dart';
import 'package:smc/src/utils/view_util.dart';
import 'package:uiblock/uiblock.dart';
import '../../commons/commons.dart';
import '../../streams/whatsapp_bloc.dart';
import '../../view_model/view_model.dart';

// ignore: must_be_immutable
class ShotsPersistePage extends StatefulWidget {
  final ShotsModel shot;
  String title;
  String operacao;
  bool alvo;
  ShotsPersistePage(
      {super.key,
      required this.shot,
      required this.title,
      required this.operacao,
      required this.alvo});

  @override
  State<ShotsPersistePage> createState() => _ShotsPersistePageState();
}

class _ShotsPersistePageState extends State<ShotsPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color textColor = Colors.white.withOpacity(0.4);
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  bool _botaoSalvar = true;
  bool _libera = true;

  late double width;
  late double height;

  late ShotsViewModel _objProvider;

  List<WhatsappModel> lista = [];

  TextEditingController dateFimController = TextEditingController();
  TextEditingController sessaoController = TextEditingController();

  final bloc = ShotsModule.to.bloc<WhatsappBloc>();

  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );
  }

  _inicializar() async {
    _libera = false;
    dateFimController.text = "";
    sessaoController.text = "";

    lista = await bloc.getWhatsapp();
    if (lista.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      lista.forEach((e) {
        if (e.isDefault == true) {
          widget.shot.name = e.session;
          sessaoController.text = e.session;
        } else {
          widget.shot.namecli = e.session;
        }
      });
    }

    if (widget.operacao == 'I') {
      widget.shot.id = 0;
      widget.shot.alvo = 0;
      widget.shot.client = 0;
      widget.shot.finished = false;
      widget.shot.start = false;
      widget.shot.control = false;
      widget.shot.datestart =
          formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
      widget.shot.datefinalize = formatDate(
          FuncaoData().getSomaDia(DateTime.now(), 7), [yyyy, '-', mm, '-', dd]);
      dateFimController.text = formatDate(
          FuncaoData().getSomaDia(DateTime.now(), 7), [dd, '/', mm, '/', yyyy]);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    _objProvider = Provider.of<ShotsViewModel>(context, listen: false);
    _botaoSalvar = true;

    if (_libera) {
      _inicializar();
    }
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Focus(
      autofocus: true,
      child: AnimatedBuilder(
          animation: ThemeProvider.instance,
          builder: (context, child) {
            return Scaffold(
              drawerDragStartBehavior: DragStartBehavior.down,
              key: _scaffoldKey,
              backgroundColor: ThemeProvider.instance.isDarkTheme
                  ? bgColor
                  : colorBackground,
              appBar: AppBar(
                backgroundColor: ThemeProvider.instance.isDarkTheme
                    ? AppColors.darkBlue
                    : primaryColor,
                title: const Text(
                  'Inicializar',
                ),
                actions: const <Widget>[],
              ),
              floatingActionButton: _botaoSalvar
                  ? FloatingActionButton(
                      onPressed: () {
                        _salvar();
                      },
                      tooltip: Constantes.botaoSalvarDescricao,
                      backgroundColor: primaryColor,
                      child: ViewUtil.getIconBotaoSalvar(),
                    )
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              bottomNavigationBar: BottomAppBar(
                color: ThemeProvider.instance.isDarkTheme
                    ? AppColors.darkBlue
                    : primaryColor,
                shape: const CircularNotchedRectangle(),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                      height: 40,
                    ),
                    getBotaoGenerico(
                      descricao: 'Sair',
                      elevation: 6,
                      cor: Colors.black45,
                      corTexto: Colors.white,
                      onPressed: () async {
                        _sair();
                      },
                    ),
                    const SizedBox(
                      width: 60,
                      height: 40,
                    ),
                  ],
                ),
              ),
              body: _dados(),
            );
          }),
    );
  }

  _dados() {
    final cor = ThemeProvider.instance.isDarkTheme ? bgColor : Colors.white;

    return SafeArea(
      top: false,
      bottom: false,
      child: Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Scrollbar(
          child: SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            child: BootstrapContainer(
              fluid: true,
              decoration: BoxDecoration(color: cor),
              padding: Biblioteca.isTelaPequena(context) == true
                  ? ViewUtil.paddingBootstrapContainerTelaPequena
                  : ViewUtil.paddingBootstrapContainerTelaGrande,
              children: <Widget>[
                Divider(
                  color: cor,
                ),
                //LINHA 1
                BootstrapRow(
                  height: 30,
                  children: <BootstrapCol>[
                    BootstrapCol(
                      sizes: 'col-12 col-sm-12 col-md-4',
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: sessaoController,
                              readOnly: true,
                              decoration:
                                  ViewUtil.getInputDecorationPersistePage(
                                      '', 'Sessâo *', false),
                              onSaved: (value) {},
                              onChanged: (text) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-12 col-sm-12 col-md-2',
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: dateFimController,
                              readOnly: true,
                              decoration:
                                  ViewUtil.getInputDecorationPersistePage(
                                      '', 'Finalizar em *', false),
                              onSaved: (value) {},
                              onChanged: (text) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-12 col-sm-12 col-md-1',
                      child: IconButton(
                        onPressed: () async {
                          DateTime? pickedDate = await dataTimeShow();
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            String formattedDate2 =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                            setState(() {
                              _libera = false;
                              widget.shot.datefinalize = formattedDate;
                              dateFimController.text =
                                  formattedDate2; //set output date to TextField value.
                            });
                          }
                        },
                        icon: const Icon(FontAwesomeIcons.calendar),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: cor,
                ),
                BootstrapRow(
                  height: 50,
                  children: <BootstrapCol>[
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Text(
                        '* indica que o campo é obrigatório',
                        style: TextStyle(
                            color: ThemeProvider.instance.isDarkTheme
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: cor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _salvar() async {
    if (_botaoSalvar) {
      final FormState? form = _formKey.currentState;
      if (!form!.validate()) {
        _autoValidate = AutovalidateMode.always;
        NotificationFush(
                context: context,
                message: Constantes.mensagemCorrijaErrosFormSalvar,
                backgroundColor: Colors.red,
                colorShadow: Colors.red[800]!,
                gradient: const LinearGradient(
                    colors: [Colors.red, Colors.redAccent]),
                indicatorColor: Colors.red)
            .bar();
      } else {
        try {
          var msg = widget.operacao == 'A'
              ? Constantes.perguntaSalvarAlteracoes
              : Constantes.perguntaSalvarInclusoes;
          gerarDialogBoxConfirmacao(context, "Sistema", msg, () async {
            form.save();
            UIBlock.block(context, loadingTextWidget: const Text("Aguarde..."));
            if (widget.operacao == 'A') {
              await _objProvider.alterar(widget.shot);
            } else {
              await _objProvider.inserir(widget.shot);
            }
            UIBlock.unblock(context);
            Navigator.of(context).pop();
            NotificationFush(
                    context: context,
                    message: 'Registro salvo com sucesso.',
                    backgroundColor: Colors.green,
                    colorShadow: Colors.green[800]!,
                    gradient: const LinearGradient(
                        colors: [Colors.green, Colors.greenAccent]),
                    indicatorColor: Colors.green)
                .bar();
          });
        } catch (e) {
          UIBlock.unblock(context);
          NotificationFush(
                  context: context,
                  message: 'Ocorreu um erro, não salvou o registro!',
                  backgroundColor: Colors.red,
                  colorShadow: Colors.red[800]!,
                  gradient: const LinearGradient(
                      colors: [Colors.red, Colors.redAccent]),
                  indicatorColor: Colors.red)
              .bar();
          // ignore: avoid_print
          print(e);
        }
      }
    }
  }

  dataTimeShow() {
    return showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  ThemeProvider.instance.isDarkTheme ? bgColor : primaryColor,
              onPrimary: Colors.white, // header text color
              onSurface: ThemeProvider.instance.isDarkTheme
                  ? Colors.white
                  : primaryColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ThemeProvider.instance.isDarkTheme
                    ? Colors.white
                    : primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.parse(widget.shot.datefinalize),
      firstDate: DateTime
          .now(), //DateTime.now() - not to allow to choose before today.
      lastDate: FuncaoData().getSomaDia(DateTime.now(), 15),
    );
  }

  void _sair() {
    Navigator.of(context).pop();
  }
}
