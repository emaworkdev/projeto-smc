import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constantes.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class Biblioteca {
  /// singleton
  factory Biblioteca() {
    _this ??= Biblioteca._();
    return _this!;
  }
  static Biblioteca? _this;
  Biblioteca._() : super();

  /// remove a máscara de uma string
  /// útil para campos do tipo: CPF, CNPJ, CEP, etc
  static String? removerMascara(dynamic value) {
    if (value != null) {
      return value.replaceAll(RegExp(r'[^\w\s]+'), '');
    } else {
      return null;
    }
  }

  /// calcula valor de juros
  static double? calcularJuros(
      double valor, double taxaJuros, DateTime dataVencimento) {
    double? valorJuros = (valor * (taxaJuros / 30) / 100) *
        (DateTime.now().difference(dataVencimento).inDays);
    valorJuros = num.parse(valorJuros.toStringAsFixed(Constantes.decimaisValor))
        as double?;
    return valorJuros;
  }

  /// calcula valor de multa
  static double? calcularMulta(double valor, double taxaMulta) {
    double? valorMulta = (valor * (taxaMulta / 100));
    valorMulta = num.parse(valorMulta.toStringAsFixed(Constantes.decimaisValor))
        as double?;
    return valorMulta;
  }

  /// soma valor
  static double? somar(double valor, double taxa) {
    double? valorTotal = (valor + taxa);
    valorTotal = num.parse(valorTotal.toStringAsFixed(Constantes.decimaisValor))
        as double?;
    return valorTotal;
  }

  /// desconto valor
  static double? subtrair(double valor, double taxa) {
    double? valorTotal = (valor - taxa);
    valorTotal = num.parse(valorTotal.toStringAsFixed(Constantes.decimaisValor))
        as double?;
    return valorTotal;
  }

  /// calcula valor de desconto
  static double? calcularDesconto(double valor, double taxaDesconto) {
    double? valorDesconto = (valor * (taxaDesconto / 100));
    valorDesconto =
        num.parse(valorDesconto.toStringAsFixed(Constantes.decimaisValor))
            as double?;
    return valorDesconto;
  }

  /// calcula valor da comissão
  static double? calcularComissao(double valor, double taxaComissao) {
    double? valorComissao = (valor * (taxaComissao / 100));
    valorComissao =
        num.parse(valorComissao.toStringAsFixed(Constantes.decimaisValor))
            as double?;
    return valorComissao;
  }

  /// calcula a multiplicacao entre dois números e retorna o valor com as devidas casas decimais
  static double? multiplicarMonetario(double valor1, double valor2) {
    double? resultado =
        num.parse((valor1 * valor2).toStringAsFixed(Constantes.decimaisValor))
            as double?;
    return resultado;
  }

  /// calcula a divisão entre dois números e retorna o valor com as devidas casas decimais
  static double? dividirMonetario(double valor1, double valor2) {
    double? resultado =
        num.parse((valor1 / valor2).toStringAsFixed(Constantes.decimaisValor))
            as double?;
    return resultado;
  }

  /// pega um período anterior com a máscara MM/AAAA
  static String periodoAnterior(String mesAno) {
    int? mes = int.tryParse(mesAno.substring(0, 2));
    int? ano = int.tryParse(mesAno.substring(3, 7));

    if (mes == 1) {
      mes = 12;
      ano = (ano! - 1);
      return '$mes/$ano';
    } else {
      mes = (mes! - 1);
      return '${mes.toString().padLeft(2, '0')}/$ano';
    }
  }

  static String formatarCampoLookup(String conteudoCampo) {
    var retorno = conteudoCampo;
    if (retorno == 'null') {
      retorno = '';
    }
    // ignore: unnecessary_type_check
    if (retorno is String) {
      return conteudoCampo;
    }
    // se for inteiro, não faz nada, o valor é o mesmo que veio
    // se inteiro é nulo, temos que verificar se é data ou double
    int? inteiro = int.tryParse(conteudoCampo);
    if (inteiro == null) {
      // trata o double
      double? valor = double.tryParse(conteudoCampo);
      if (valor != null) {
        retorno = Constantes.formatoDecimalValor.format(conteudoCampo);
      } else {
        // tratando tipos data
        DateTime? data = DateTime.tryParse(conteudoCampo);
        if (data != null) {
          retorno = DateFormat('dd/MM/yyyy').format(data);
        }
      }
    }
    return retorno;
  }

  /// define o que é a tela pequena e se o dispositivo utilizado tem a tela pequena
  static bool isTelaPequena(BuildContext context) {
    return bootStrapValueBasedOnSize(
      sizes: {
        "xl": false,
        "lg": false,
        "md": false,
        "sm": false,
        "": true,
      },
      context: context,
    );
  }

  /// define se a plataforma é desktop
  static bool isDesktop() {
    if (kIsWeb) {
      return false;
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return true;
    } else {
      return false;
    }
  }

  /// define se a plataforma é mobile
  static bool isMobile() {
    if (kIsWeb) {
      return false;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }

  static bool isWeb() {
    if (kIsWeb) {
      return true;
    } else {
      return false;
    }
  }

  static bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }

    // ignore: deprecated_member_use,, unnecessary_null_comparison
    return double.parse(s, (e) => 0) != null;
  }

  /// define a distância entre as colunas caso haja uma quebra de linha
  static EdgeInsets distanciaEntreColunasQuebraLinha(BuildContext context) {
    return bootStrapValueBasedOnSize(
      sizes: {
        "xl": EdgeInsets.zero,
        "lg": EdgeInsets.zero,
        "md": EdgeInsets.zero,
        "sm": EdgeInsets.zero,
        "": const EdgeInsets.only(top: 5.0, bottom: 10.0),
      },
      context: context,
    );
  }

  Future<File> getFileFromNetworkImage(String link) async {
    var response = await http.get(Uri.parse(link));
    final documentDirectory = await getApplicationDocumentsDirectory();
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    File file = File(path.join(documentDirectory.path, '$fileName.png'));
    file.writeAsBytes(response.bodyBytes);
    return file;
  }

  getColorRandomic() {
    Color randomColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return randomColor;
  }
}
