import 'dart:convert';

import 'package:smc/src/commons/components/widgets/botoes.dart';
import 'package:http/http.dart' show Client;

import 'package:flutter/material.dart';
import 'package:smc/src/models/retorno_json_erro.dart';

import 'package:smc/src/utils/view_util.dart';

class ErroPage extends StatefulWidget {
  final RetornoJsonErro? objetoJsonErro;
  final Function()? limpaErroCallBack;

  const ErroPage({Key? key, this.objetoJsonErro, this.limpaErroCallBack})
      : super(key: key);

  @override
  ErroPageState createState() => ErroPageState();
}

class ErroPageState extends State<ErroPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.limpaErroCallBack != null) {
      widget.limpaErroCallBack!();
    }
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 180.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/error.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ocorreu um Erro',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: getErro(context),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  getBotaoGenerico(
                    descricao: 'Área de Trabalho',
                    elevation: 2,
                    cor: Colors.amber,
                    corTexto: Colors.white,
                    onPressed: () {
                      if (ViewUtil.tokenJWT == "") {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushNamed(context, '/home');
                      }
                    },
                  ),
                  getBotaoGenerico(
                    descricao: 'Reportar Erro',
                    elevation: 2,
                    cor: Colors.indigo,
                    corTexto: Colors.white,
                    onPressed: () async {
                      //await reportarErro();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getErro(BuildContext context) {
    if (widget.objetoJsonErro?.tipo == 'json') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Status: ${widget.objetoJsonErro?.status}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.blueAccent),
              textAlign: TextAlign.left),
          Text('Erro: ${widget.objetoJsonErro?.error}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.purple),
              textAlign: TextAlign.left),
          Text('Mensagem: ${widget.objetoJsonErro?.message}'),
        ],
      );
    } else if (widget.objetoJsonErro?.tipo == 'text') {
      // ignore: prefer_conditional_assignment
      if (widget.objetoJsonErro?.error == null) {
        widget.objetoJsonErro?.error = 'Nulo';
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Erro: ${widget.objetoJsonErro?.error}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.purple),
              textAlign: TextAlign.left),
          Text('Mensagem: ${widget.objetoJsonErro?.message}'),
        ],
      );
    } else if (widget.objetoJsonErro?.tipo == 'html') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          /*Html(
            data: widget.objetoJsonErro.message.replaceAll('font', 'br'),
          ),*/
        ],
      );
    }
    return const Text('Erro desconhecido.');
  }

  Future reportarErro() async {
    // pega o id da lista
    String idLista = '5eab0466df710a3jd7ufvb55';

    // key e token
    String key =
        'gere sua key: https://developer.atlassian.com/cloud/trello/guides/rest-api/api-introduction/';
    String token =
        'gere sey token: https://developer.atlassian.com/cloud/trello/guides/rest-api/api-introduction/';

    // pega os dados do usuário
    // uTODO: pegar os dados reais do usuário
    // uTODO: impedir que o usuário reporte o mesmo problema várias vezes
    String usuario = 'Eduardo - 555666';

    // dados do erro
    String codigo = widget.objetoJsonErro?.status ?? '';
    String error = widget.objetoJsonErro?.error ?? '';
    String mensagem = widget.objetoJsonErro?.message ?? '';
    mensagem = mensagem.replaceAll('#', '');
    String trace = widget.objetoJsonErro?.trace ?? '';
    trace = trace.replaceAll('#', '');

    if (widget.objetoJsonErro?.tipo == 'html') {
      mensagem = 'Arquivo HTML em Anexo';
    }

    // formata a mensagem
    String nomeCartao = '[30/04/2019] BUG Reportado por $usuario';
    String descricaoCartao = '';
    descricaoCartao =
        '${descricaoCartao}Erro reportado pelo usuário $usuario\n';
    descricaoCartao = '$descricaoCartao===\n';
    descricaoCartao = '$descricaoCartao**Formato do Erro**\n';
    descricaoCartao = '$descricaoCartao${widget.objetoJsonErro?.tipo}\n';
    descricaoCartao = '$descricaoCartao**Código**\n';
    descricaoCartao = '$descricaoCartao$codigo\n';
    descricaoCartao = '$descricaoCartao**Erro**\n';
    descricaoCartao = '$descricaoCartao$error\n';
    descricaoCartao = '$descricaoCartao**Mensagem**\n';
    descricaoCartao = '$descricaoCartao$mensagem\n';
    descricaoCartao = '$descricaoCartao**Trace**\n';
    descricaoCartao = '$descricaoCartao$trace\n';

    // monta a URL
    String urlBase =
        'https://api.trello.com/1/cards?idList=$idLista&pos=top&key=$key&token=$token&name=$nomeCartao&desc=$descricaoCartao';

    // executa o POST
    var clienteHTTP = Client();

    // primeiro cria o cartão
    var response = await clienteHTTP.post(
      Uri.parse(urlBase),
      headers: {"content-type": "application/json"},
    );

    // se o cartão foi inserido com sucesso, pega o id dele e continua com a lógica
    if (response.statusCode == 200) {
      var cartaoInserido = json.decode(response.body);

      // se tiver HTML, anexa o conteúdo ao cartão
      if (widget.objetoJsonErro?.tipo == 'html') {
        // ignore: prefer_interpolation_to_compose_strings
        urlBase =
            // ignore: prefer_interpolation_to_compose_strings
            '${"https://api.trello.com/1/cards/" + cartaoInserido["id"]}/attachments?key=$key&token=$token&mimeType=text/html&name=erro.html&file=${widget.objetoJsonErro!.message?.replaceAll('#', '')}';

        response = await clienteHTTP.post(
          Uri.parse(urlBase),
          headers: {"Accept": "application/json"},
        );
      }
    } else {}
  }
}
