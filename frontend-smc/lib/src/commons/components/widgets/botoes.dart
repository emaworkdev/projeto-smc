import 'package:smc/src/infra/biblioteca.dart';
import 'package:smc/src/infra/constantes.dart';
import 'package:smc/src/utils/view_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget getBotaoTelaGrande(
    {required String texto,
    required Icon icone,
    required Function() onPressed}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.indigo;
          }
          return Colors.black26;
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Colors.black54;
        }),
      ),
      label: Text(texto),
      icon: icone,
      onPressed: onPressed,
    ),
  );
}

Widget getBotaoTelaPequena(
    {required String tooltip,
    required Icon icone,
    required Function() onPressed}) {
  return IconButton(
    focusColor: Colors.indigo,
    tooltip: tooltip,
    icon: icone,
    onPressed: onPressed,
  );
}

Widget getBotaoFiltro(
    {required BuildContext context, required Function() chamarFiltro}) {
  if (Biblioteca.isTelaPequena(context)) {
    return getBotaoTelaPequena(
        tooltip: Constantes.botaoFiltrarDica,
        icone: ViewUtil.getIconBotaoFiltro(),
        onPressed: chamarFiltro);
  } else {
    return getBotaoTelaGrande(
      texto: Constantes.botaoFiltrarDescricao,
      icone: ViewUtil.getIconBotaoFiltro(),
      onPressed: chamarFiltro,
    );
  }
}

List<Widget> getBotoesNavigationBarListaPage(
    {required BuildContext context,
    required Function() chamarFiltro,
    required Function() gerarRelatorio}) {
  if (Biblioteca.isTelaPequena(context)) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoFiltrarDica,
        icone: ViewUtil.getIconBotaoFiltro(),
        onPressed: chamarFiltro,
      ),
      getBotaoTelaPequena(
        tooltip: Constantes.botaoImprimirDica,
        icone: ViewUtil.getIconBotaoPdf(),
        onPressed: gerarRelatorio,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoFiltrarDescricao,
        icone: ViewUtil.getIconBotaoFiltro(),
        onPressed: chamarFiltro,
      ),
      getBotaoTelaGrande(
        texto: Constantes.botaoImprimirDescricao,
        icone: ViewUtil.getIconBotaoPdf(),
        onPressed: gerarRelatorio,
      ),
    ];
  }
}

List<Widget> getBotoesAppBarDetalhePage(
    {required BuildContext context,
    required Function() excluir,
    required Function() alterar}) {
  if (Biblioteca.isTelaPequena(context)) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoExcluirDica,
        icone: ViewUtil.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaPequena(
        tooltip: Constantes.botaoAlterarDica,
        icone: ViewUtil.getIconBotaoAlterar(),
        onPressed: alterar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoExcluirDescricao,
        icone: ViewUtil.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaGrande(
        texto: Constantes.botaoAlterarDescricao,
        icone: ViewUtil.getIconBotaoAlterar(),
        onPressed: alterar,
      ),
    ];
  }
}

List<Widget> getBotoesAppBarPersistePage(
    {required BuildContext context, required Function() salvar}) {
  if (Biblioteca.isTelaPequena(context)) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoSalvarDica,
        icone: ViewUtil.getIconBotaoSalvar(),
        onPressed: salvar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoSalvarDescricao,
        icone: ViewUtil.getIconBotaoSalvar(),
        onPressed: salvar,
      ),
    ];
  }
}

List<Widget> getBotoesAppBarPersistePageComExclusao(
    {required BuildContext context,
    required Function() salvar,
    required Function() excluir}) {
  if (Biblioteca.isTelaPequena(context)) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoExcluirDica,
        icone: ViewUtil.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaPequena(
        tooltip: Constantes.botaoSalvarDica,
        icone: ViewUtil.getIconBotaoSalvar(),
        onPressed: salvar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoExcluirDescricao,
        icone: ViewUtil.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaGrande(
        texto: Constantes.botaoSalvarDescricao,
        icone: ViewUtil.getIconBotaoSalvar(),
        onPressed: salvar,
      ),
    ];
  }
}

MaterialButton getBotaoInternoCaixa(
    {required String texto,
    required IconData icone,
    required double tamanhoIcone,
    required Color corBotao,
    required double paddingAll,
    double? height,
    double? minWidth,
    required Function() onPressed}) {
  return MaterialButton(
    height: height ?? 70.0,
    padding: EdgeInsets.all(paddingAll),
    textColor: Colors.white,
    minWidth: minWidth ?? 80,
    color: corBotao,
    elevation: 0,
    onPressed: onPressed,
    child: Column(
      children: <Widget>[
        FaIcon(icone, size: tamanhoIcone),
        Text(
          texto,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    ),
  );
}

InkWell getBotaoIncrementaCaixa({required Function() incrementar}) {
  return InkWell(
    onTap: incrementar,
    splashColor: Colors.lightBlue,
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      alignment: Alignment.center,
      child: const Padding(
        padding: EdgeInsets.all(6.0),
        child: Icon(
          Icons.add,
          color: Colors.green,
          size: 20,
        ),
      ),
    ),
  );
}

InkWell getBotaoDecrementaCaixa({required Function() decrementar}) {
  return InkWell(
    onTap: decrementar,
    splashColor: Colors.redAccent.shade200,
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      alignment: Alignment.center,
      child: const Padding(
        padding: EdgeInsets.all(6.0),
        child: Icon(
          Icons.remove,
          color: Colors.redAccent,
          size: 20,
        ),
      ),
    ),
  );
}

ElevatedButton getBotaoGenerico(
    {required String descricao,
    required double elevation,
    required Color cor,
    required Color corTexto,
    required Function() onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      elevation: elevation,
      backgroundColor: cor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
    onPressed: onPressed,
    child: Text(
      descricao,
      style: TextStyle(color: corTexto),
    ),
  );
}
