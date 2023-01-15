// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constantes {
  /// singleton
  factory Constantes() {
    _this ??= Constantes._();
    return _this!;
  }
  static Constantes? _this;
  Constantes._() : super();

  // #region Strings
  static const String appNameString = "SMC";
  static const String splashtituloString = "";

  static const String animatedEmpresaString = "EmaWork®";
  static const String animatedTitulo1String = "desenvolvimento de sistemas";

  // #region Inteiros
  static const int decimaisValor = 2;
  static const int decimaisTaxa = 2;
  static const int decimaisQuantidade = 3;
  static const int paginatedDataTableLinhasPorPagina =
      PaginatedDataTable.defaultRowsPerPage;
// #endregion Inteiros

// #region Double
  static const double paddingListViewListaPage = 8.0;
  static const double flutterBootstrapGutterSize = 10.0;
// #region Double

// #region Decimais
  static final formatoDecimalValorEn = NumberFormat("#.##0,00", "en");
  static final formatoDecimalValor = NumberFormat("#,##0.00", "pt_BR");
  static final formatoDecimalTaxa = NumberFormat("#,##0.00", "pt_BR");
  static final formatoDecimalQuantidade = NumberFormat("#,##0.000", "pt_BR");
// #endregion Decimais

// Descrição botões
  static const String botaoIncluirDescricao = kIsWeb == true ? "Novo" : "Novo";
  static const String botaoAlterarDescricao =
      kIsWeb == true ? "Alterar" : "Alterar";
  static const String botaoExcluirDescricao =
      kIsWeb == true ? "Excluir" : "Excluir";
  static const String botaoVisualizarDescricao =
      kIsWeb == true ? "Visualizar" : "Visualizar";
  static const String botaoSalvarDescricao =
      kIsWeb == true ? "Salvar" : "Salvar";
  static const String botaoProcessarDescricao =
      kIsWeb == true ? "Gerar" : "Gerar";
  static const String botaoImprimirDescricao =
      kIsWeb == true ? "Relatório" : "Relatório";
  static const String botaoFiltrarDescricao =
      kIsWeb == true ? "Filtro" : "Filtro";
  static const String botaoEsc = kIsWeb == true ? "Voltar" : "Voltar";
  static const String botaoPesquisar = kIsWeb == true ? "Buscar" : "Buscar";

  // Dicas botões
  static const String botaoInserirDica = "Inserir Item [F2]";
  static const String botaoFiltrarDica = "Aplicar Filtro";
  static const String botaoImprimirDica = "Relatório PDF";
  static const String botaoExcluirDica = "Excluir Registro";
  static const String botaoAlterarDica = "Alterar Registro";
  static const String botaoSalvarDica = "Salvar";

  // Perguntas
  static const String perguntaGerarRelatorio = "Desejar gerar o relatório?";
  static const String perguntaSalvarAlteracoes =
      "Desejar salvar as alterações?";
  static const String perguntaSalvarInclusoes = "Desejar salvar este registro?";
  static const String perguntaExcluirRegistro =
      "Desejar realmente excluir este registro?";

  // Mensagens
  static const String mensagemCorrijaErrosFormSalvar =
      "Por favor, preencha todos os campos obrigatórios antes de continuar.";
  // #endregion Strings

  // #region Máscaras
  static const String mascaraCPF = "000.000.000-00";
  static const String mascaraCNPJ = "00.000.000/0000-00";
  static const String mascaraRENAVAM = "0000000000-0";
  static const String mascaraCEP = "00000-000";
  static const String mascaraTELEFONE = "0000-0000";
  static const String mascaraCELULAR = "00000-0000";
  static const String mascaraDDDTELEFONE = "(00)0000-0000";
  static const String mascaraDDDCELULAR = "(00)000000000";
  static const String mascaraMES_ANO = "00/0000";
  static const String mascaraHORA = "00:00:00";
  static const String mascaraHHMM = "00:00";
  static const String mascaraDIA = "00";
  static const String mascaraANO = "00";
  static const String mascaraPLACA = "***-****";
  static const String mascaraREFERENCIA = "00/0000";
  static const String mascaraANOMODELO = "0000/0000";
  static const String mascaraCODIGOFIPE = "000000-0";
// #endregion Máscaras

  // #region Fontes
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";
  // #endregion Fontes

  //images
  static const String imageDir = "assets/images";
  static const String fipeLogo = "$imageDir/fipe.png";
  static const String ewLogoSplash = "$imageDir/emawork.png";
  static const String profileImage = "$imageDir/profile.jpg";
  static const String pagamentoIcon = "$imageDir/pagamento-icon.png";
  static const String produtoIcon = "$imageDir/produto-icon.png";
  static const String dialogQuestionIcon = '$imageDir/dialog-question-icon.png';
  static const String dialogInfoIcon = '$imageDir/dialog-info-icon.png';
  static const String dialogUploadIcon = '$imageDir/upload.png';
  static const String dialogBoletoIcon = '$imageDir/boleto.png';
  static const String dialogEditarIcon = '$imageDir/editar.png';
  static const String dialogUserIcon = '$imageDir/secret.png';

  // #endregion Imagens
}
