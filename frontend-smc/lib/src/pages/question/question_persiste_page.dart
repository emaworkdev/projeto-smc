// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smc/src/infra/biblioteca.dart';
import 'package:smc/src/infra/constantes.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/models/model.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/shared/show_dialog.dart';
import 'package:smc/src/utils/notification_fush.dart';
import 'package:smc/src/utils/view_util.dart';
import 'package:uiblock/uiblock.dart';
import '../../commons/commons.dart';
import '../../view_model/view_model.dart';

// ignore: must_be_immutable
class QuestionPersistePage extends StatefulWidget {
  final QuestionModel question;
  String title;
  String operacao;

  QuestionPersistePage(
      {super.key,
      required this.question,
      required this.title,
      required this.operacao});

  @override
  State<QuestionPersistePage> createState() => _QuestionPersistePageState();
}

class _QuestionPersistePageState extends State<QuestionPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color textColor = Colors.white.withOpacity(0.4);
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  bool _botaoSalvar = true;
  bool _campoId = true;
  //bool _libera = true;

  late double width;
  late double height;

  late QuestionViewModel _objProvider;

  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );
  }

  _inicializar() {
    if (widget.operacao == 'I') {
      widget.question.id = 0;
      widget.question.name = null;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    _objProvider = Provider.of<QuestionViewModel>(context, listen: false);
    _botaoSalvar = true;
    _campoId = widget.operacao == 'I' ? false : true;

    //if (_libera) {
    _inicializar();
    //}
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
                title: Text(
                  'Conversa ${widget.title}',
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
                    //ID
                    TextFormFieldIdBootstrap(
                      context: context,
                      sizes: 'col-12 col-sm-12 col-md-1',
                      initialValue:
                          _campoId ? widget.question.id.toString() : '',
                    ),
                  ],
                ),
                Divider(
                  color: cor,
                ),
                //LINHA 2
                BootstrapRow(
                  height: 30,
                  children: <BootstrapCol>[
                    //Nome
                    TextFormFieldBootstrap(
                      context: context,
                      sizes: 'col-12 col-sm-12 col-md-12',
                      autofocus: true,
                      maxLength: 250,
                      maxLines: 1,
                      enabled: _botaoSalvar,
                      initialValue: widget.question.name ?? '',
                      decorationTitle: 'Descrição:',
                      decorationHint: 'Informe a descrição',
                      caseUpperLower: false,
                      upperCase: false,
                      icon: FontAwesomeIcons.route,
                      validator: ValidaCampoFormulario.validarObrigatorio,
                      onSaved: (value) {
                        widget.question.name = value;
                      },
                      onChanged: (text) {
                        widget.question.name = text;
                      },
                    ),
                  ],
                ),
                Divider(
                  color: cor,
                ),
                //LINHA 3
                BootstrapRow(
                  height: 30,
                  children: const <BootstrapCol>[],
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
              await _objProvider.alterar(widget.question);
            } else {
              await _objProvider.inserir(widget.question);
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

  void _sair() {
    Navigator.of(context).pop();
  }
}
