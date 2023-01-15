// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:hasura_connect/hasura_connect.dart';
import 'package:dotenv/dotenv.dart';
import 'package:server_smc/models/shots_model.dart';

class ShotsHasuraService {
  HasuraConnect hasuraConnect = HasuraConnect(env['hasuraHost']!,
      headers: {'x-hasura-admin-secret': env['hasuraPassword']!});

  String query = "";

  Future<bool> existe(int id) async {
    query = """
      query Shots(\$id:Int!) {
        smc_shots(where: {id: {_eq: \$id}}) {
            id
          }
      }
    """;
    var r =
        await hasuraConnect.query(query, variables: {"id": id}).catchError((e) {
      //print(query);
      print(e);
    });
    //print(r["data"]["smc_shots"]);
    if (r["data"]["smc_shots"].isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> create(ShotsModel obj) async {
    print(obj.toJson());
    query = """
     mutation MyMutation {
       insert_smc_shots(objects: {
            name: "${obj.name}",
            namecli: "${obj.namecli}",
            datestart: "${obj.datestart}",
            datefinalize: "${obj.datefinalize}",
            start: ${obj.start},
            finished: ${obj.finished},
            control: ${obj.control},
            alvo: ${obj.alvo},
            client: ${obj.client}, 
            }) {
          affected_rows
          returning {
            id
          }
        }
       } 
    """;
    var ret = await hasuraConnect.mutation(query).catchError((e) {
      //print(query);
      print(e);
      return '0';
    });
    //ret['data']['insert_smc_shots']['returning'][0]
    return ret['data']['insert_smc_shots']['returning'][0]['id'].toString();
  }

  Future<String> update(ShotsModel obj) async {
    query = """
     mutation MyMutation(\$id:Int!) {
        update_smc_shots(where: {id: {_eq: \$id}}, _set: {
            id: ${obj.id},
            name: ${obj.name},
            namecli: "${obj.namecli}",
            datestart: ${obj.datestart},
            datefinalize: ${obj.datefinalize},
            start: ${obj.start},
            finished: ${obj.finished},
            control: ${obj.control},
            alvo: ${obj.alvo},
            client: ${obj.client},
            }) {
          affected_rows
          returning {
            id
          }
        }
       } 
    """;
    var ret = await hasuraConnect
        .mutation(query, variables: {"id": obj.id}).catchError((e) {
      //print(query);
      print(e);
      return '0';
    });
    //ret['data']['update_smc_shots']['returning'][0]
    return ret['data']['update_smc_shots']['returning'][0]['id'].toString();
  }

  start(int id) async {
    query = """
     mutation MyMutation(\$id:Int!) {
        update_smc_shots(where: {id: {_eq: \$id}}, _set: {
            start: ${true},
            }) {
          affected_rows
        }
       } 
    """;
    await hasuraConnect.mutation(query, variables: {"id": id}).catchError((e) {
      //print(query);
      print(e);
      return '0';
    });
    //ret['data']['update_smc_shots']['returning'][0]
  }

  pause(int id) async {
    query = """
     mutation MyMutation(\$id:Int!) {
        update_smc_shots(where: {id: {_eq: \$id}}, _set: {
            start: ${false},
            control: ${false},
            }) {
          affected_rows
        }
       } 
    """;
    await hasuraConnect.mutation(query, variables: {"id": id}).catchError((e) {
      //print(query);
      print(e);
      return '0';
    });
    //ret['data']['update_smc_shots']['returning'][0]
  }

  delete(int id) async {
    query = """
      mutation MyMutation(\$id:Int!) {
        delete_smc_shots(where: {id: {_eq: \$id}}) {
          affected_rows
        }
      }
    """;
    await hasuraConnect.mutation(query, variables: {"id": id}).catchError((e) {
      print(e);
    });
  }

  atualizaAlvo(String sessao) async {
    query = """
      query Shots(\$sessao:String!) {
        smc_shots(where: {name: {_eq: \$sessao}}) {
            id
            alvo
          }
      }
    """;
    var r = await hasuraConnect
        .query(query, variables: {"sessao": sessao}).catchError((e) {
      //print(query);
      print(e);
    });
    //print(r["data"]["smc_shots"][0]['alvo']);
    int id;
    int qtde = 0;
    id = r["data"]["smc_shots"][0]['id'];
    qtde = r["data"]["smc_shots"][0]['alvo'];
    qtde++;
    query = """
     mutation MyMutation(\$id:Int!) {
        update_smc_shots(where: {id: {_eq: \$id}}, _set: {
            alvo: $qtde,
            }) {
          affected_rows
        }
       } 
    """;
    await hasuraConnect.mutation(query, variables: {"id": id}).catchError((e) {
      //print(query);
      print(e);
    });
  }

  atualizaClient(String sessao) async {
    query = """
      query Shots(\$sessao:String!) {
        smc_shots(where: {namecli: {_eq: \$sessao}}) {
            id
            client
          }
      }
    """;
    var r = await hasuraConnect
        .query(query, variables: {"sessao": sessao}).catchError((e) {
      //print(query);
      print(e);
    });
    //print(r["data"]["smc_shots"][0]['client']);
    int id;
    int qtde = 0;
    id = r["data"]["smc_shots"][0]['id'];
    qtde = r["data"]["smc_shots"][0]['client'];
    qtde++;
    query = """
     mutation MyMutation(\$id:Int!) {
        update_smc_shots(where: {id: {_eq: \$id}}, _set: {
            client: $qtde,
            }) {
          affected_rows
        }
       } 
    """;
    await hasuraConnect.mutation(query, variables: {"id": id}).catchError((e) {
      //print(query);
      print(e);
    });
  }
}
