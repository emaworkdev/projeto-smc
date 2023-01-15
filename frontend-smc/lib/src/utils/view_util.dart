import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/providers/theme_provider.dart';

class ViewUtil {
  /// singleton
  factory ViewUtil() {
    _this ??= ViewUtil._();
    return _this!;
  }

  static ViewUtil? _this;

  ViewUtil._() : super();

// #region objetos globais
  static String tokenJWT = '';
  static String senha = '';
  static String email = '';
  static String idUsuario = '';
  static String nomeUsuario = '';

  static String apiHasura = '';
  static String hasuraSecret = '';
  static String apiHost = '';

  static String tenanty = '0';

  static int sessionQtde = 2;

  static bool kisweb = false;

  /// Mostra uma snackbar com uma mensagem
  static showInSnackBar(String value, Color color, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: color,
    ));
  }

  // Mostra uma snackbar com uma mensagem
  static showInSnackBarCustom(BuildContext context,
      {String? value,
      required GlobalKey<ScaffoldState> scaffoldKey,
      Color? cor,
      Color? corText}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: cor,
          content: Text(
            value!,
            style: TextStyle(
              color: corText,
            ),
          )),
    );
  }

  // #region Ícones
  static Icon getIconBotaoExcluir() {
    return const Icon(Icons.delete, color: Colors.white);
  }

  static Icon getIconBotaoAlterar() {
    return const Icon(Icons.edit, color: Colors.white);
  }

  static Icon getIconBotaoInserir() {
    return const Icon(Icons.add);
  }

  static Icon getIconBotaoFiltro() {
    return const Icon(Icons.filter);
  }

  static Icon getIconBotaoPdf() {
    return const Icon(Icons.picture_as_pdf);
  }

  static Icon getIconBotaoSalvar() {
    return const Icon(Icons.save, color: Colors.white);
  }

  static Icon getIconBotaoProcessar() {
    return const Icon(FontAwesomeIcons.gears, color: Colors.white);
  }

  static Icon getIconBotaoRelPdf() {
    return const Icon(FontAwesomeIcons.filePdf, color: Colors.white);
  }

  static Icon getIconBotaoLookup() {
    return const Icon(Icons.search);
  }
// #endregion Ícones

// #region Cores
  static Color getBackgroundColorBotaoInserir() {
    return Colors.blueGrey;
  }

  static Color getBotaoFocusColor() {
    return Colors.indigo;
  }

  static Color getBackgroundColorBarraTelaDetalhe() {
    return Colors.blueGrey;
  }

  static Color getBottomAppBarColor() {
    return AppColors.darkBlue; // bgColor;
  }

  static Color getBottomAppBarFiltroLocalColor() {
    return Colors.blueGrey.shade200;
  }

  static Color getBackgroundColorCardValor(num valor) {
    if (valor == 0) {
      return Colors.blue.shade100;
    } else if (valor > 0) {
      return Colors.green.shade100;
    } else {
      return Colors.red.shade100;
    }
  }

  static List<Color> kitGradients = [
    Colors.blueGrey.shade800,
    Colors.black87,
  ];

  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];
// #endregion Cores

// #region Padding
  static EdgeInsets paddingBootstrapContainerTelaPequena =
      const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0);
  static EdgeInsets paddingBootstrapContainerTelaGrande =
      const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0);
  static EdgeInsets paddingAbaPersistePage =
      const EdgeInsets.symmetric(horizontal: 16.0);
// #region Padding

  /// InputDecoration utilizada nas páginas de Persistência
  ///
  /// Os argumentos passados são os mesmos utilizados pela InputDecoration.
  /// Temos no entanto uma novidade:
  /// [aplicaPadding] deve ser true para controles que o necessitem, tais como DropDownButton e DatePickerItem.
  /// Os demais controles devem aplicar o padding padrão.
  static InputDecoration getInputDecorationPersistePage(
      String hintText, String labelText, bool aplicaPadding) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(),
      ),
      fillColor: ThemeProvider.instance.isDarkTheme
          ? colorBackgroundDark
          : Colors.white,
      hintText: hintText,
      labelText: labelText,
      isDense: true,
      filled: true,
      contentPadding: aplicaPadding
          ? const EdgeInsets.symmetric(vertical: 5, horizontal: 20)
          : null,
    );
  }

  static InputDecoration getInputDecorationIconPersistePage(
      String hintText, String labelText, bool aplicaPadding, IconData icon) {
    return InputDecoration(
      //border: UnderlineInputBorder(),
      //border: OutlineInputBorder(),
      prefixIcon: Icon(
        icon,
        size: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(),
      ),
      fillColor: ThemeProvider.instance.isDarkTheme
          ? colorBackgroundDark
          : Colors.white,
      hintText: hintText,
      labelText: labelText,
      //labelStyle: TextStyle(color: Colors.red),
      filled: true,
      isDense: true,
      contentPadding: aplicaPadding
          ? const EdgeInsets.symmetric(vertical: 5, horizontal: 20)
          : null,
    );
  }

  static InputDecoration getInputDecoration(
      String hintText, String labelText, bool aplicaPadding,
      {double? paddingVertical, double? paddingHorizontal, Color? cor}) {
    return InputDecoration(
      fillColor: ThemeProvider.instance.isDarkTheme
          ? colorBackgroundDark
          : Colors.white,
      //border: UnderlineInputBorder(),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(),
      ),
      hintText: hintText,
      labelText: labelText,
      filled: true,
      contentPadding: aplicaPadding
          ? EdgeInsets.symmetric(
              vertical: paddingVertical ?? 5,
              horizontal: paddingHorizontal ?? 10,
            )
          : null,
    );
  }

  static Icon getIconBotaoInserirCircle() {
    return const Icon(FontAwesomeIcons.circlePlus);
  }

  /// Retorna um DropdownButton
  static DropdownButton<String> getDropDownButton(
      String value, Function(String?) onChanged, List<String> items) {
    return DropdownButton<String>(
      isExpanded: true,
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
