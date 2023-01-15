// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
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
class ConectionPersistePage extends StatefulWidget {
  final WhatsappModel whatsapp;
  String title;
  String operacao;
  bool alvo;
  ConectionPersistePage(
      {super.key,
      required this.whatsapp,
      required this.title,
      required this.operacao,
      required this.alvo});

  @override
  State<ConectionPersistePage> createState() => _ConectionPersistePageState();
}

class _ConectionPersistePageState extends State<ConectionPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color textColor = Colors.white.withOpacity(0.4);
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  bool _botaoSalvar = true;
  bool _campoId = true;
  bool _libera = true;

  late double width;
  late double height;

  late ConectionViewModel _objProvider;

  // ignore: prefer_typing_uninitialized_variables
  var _whatsappController;

  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );
  }

  _inicializar() {
    _whatsappController = MaskedTextController(
      mask: Constantes.mascaraDDDCELULAR,
      text: widget.whatsapp.number ?? '',
    );

    var comp = widget.alvo == true ? '1' : '2';

    if (widget.operacao == 'I') {
      widget.whatsapp.id = 0;
      widget.whatsapp.name = 'sessao$comp';
      widget.whatsapp.battery = null;
      widget.whatsapp.isDefault = widget.alvo;
      widget.whatsapp.plugged = false;
      widget.whatsapp.qrcode = null;
      widget.whatsapp.status = 'DESCONNECTED';
      widget.whatsapp.retries = 0;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    _objProvider = Provider.of<ConectionViewModel>(context, listen: false);
    _botaoSalvar = true;
    _campoId = widget.operacao == 'I' ? false : true;

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
                title: Text(
                  'Conexão ${widget.title}',
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
                          _campoId ? widget.whatsapp.id.toString() : '',
                    ),
                    widget.alvo
                        ? TextFormFieldSwitchBootstrap(
                            context: context,
                            sizes:
                                'col-12 col-sm-12 col-md-12 col-lg-12 col-xl-2',
                            texto: 'Padrão:',
                            tooltip: 'conexão padrão',
                            isSwitched: widget.whatsapp.isDefault,
                            textColor: ThemeProvider.instance.isDarkTheme
                                ? Colors.white
                                : Colors.black,
                            onPressed: (value) {
                              setState(() {
                                widget.whatsapp.isDefault = value;
                                _libera = false;
                              });
                            },
                          )
                        : VazioBootstrap(context: context),
                    TextFormFieldControllerBootstrap(
                      context: context,
                      sizes: 'col-12 col-sm-12 col-md-3',
                      autofocus: true,
                      maxLength: 14,
                      enabled: _botaoSalvar,
                      controller: _whatsappController,
                      decorationTitle: 'whatsapp',
                      decorationHint: 'Informe o whatsapp',
                      keyboardType: TextInputType.phone,
                      upperCase: false,
                      icon: FontAwesomeIcons.whatsapp,
                      onSaved: (value) {
                        widget.whatsapp.number = value;
                      },
                      onChanged: (text) {
                        widget.whatsapp.number = text;
                      },
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
                      enabled: false,
                      initialValue: widget.whatsapp.name ?? '',
                      decorationTitle: 'Nome:',
                      decorationHint: 'Informe o nome',
                      caseUpperLower: false,
                      upperCase: false,
                      icon: FontAwesomeIcons.route,
                      validator: ValidaCampoFormulario.validarObrigatorio,
                      onSaved: (value) {
                        widget.whatsapp.name = value;
                        if (!_campoId) {
                          widget.whatsapp.session = value;
                        }
                      },
                      onChanged: (text) {
                        widget.whatsapp.name = text;
                        if (!_campoId) {
                          widget.whatsapp.session = text;
                        }
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

            widget.whatsapp.number = widget.whatsapp.number
                .toString()
                .replaceAll("(", "")
                .replaceAll(")", "");

            if (widget.operacao == 'A') {
              widget.whatsapp.updatedAt = null;
              await _objProvider.alterar(widget.whatsapp);
            } else {
              widget.whatsapp.session =
                  widget.whatsapp.session.replaceAll(" ", "") + '_1';
              await _objProvider.inserir(widget.whatsapp);
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
