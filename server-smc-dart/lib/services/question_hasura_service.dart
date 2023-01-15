// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:hasura_connect/hasura_connect.dart';
import 'package:dotenv/dotenv.dart';
import 'package:server_smc/models/question_model.dart';

class QuestionHasuraService {
  HasuraConnect hasuraConnect = HasuraConnect(env['hasuraHost']!,
      headers: {'x-hasura-admin-secret': env['hasuraPassword']!});

  String query = "";

  Future<bool> existe(int id) async {
    query = """
      query Question(\$id:Int!) {
        smc_questions(where: {id: {_eq: \$id}}) {
            id
          }
      }
    """;
    var r =
        await hasuraConnect.query(query, variables: {"id": id}).catchError((e) {
      //print(query);
      print(e);
    });
    //print(r["data"]["smc_questions"]);
    if (r["data"]["smc_questions"].isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> create(QuestionModel obj) async {
    query = """
     mutation MyMutation {
       insert_smc_questions(objects: {
            name: "${obj.name}",
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
    //ret['data']['insert_smc_questions']['returning'][0]
    return ret['data']['insert_smc_questions']['returning'][0]['id'].toString();
  }

  Future<String> update(QuestionModel obj) async {
    query = """
     mutation MyMutation(\$id:Int!) {
        update_smc_questions(where: {id: {_eq: \$id}}, _set: {
            id: ${obj.id},
            name: "${obj.name}",
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
    //ret['data']['update_smc_questions']['returning'][0]
    return ret['data']['update_smc_questions']['returning'][0]['id'].toString();
  }

  delete(int id) async {
    query = """
      mutation MyMutation(\$id:Int!) {
        delete_smc_questions(where: {id: {_eq: \$id}}) {
          affected_rows
        }
      }
    """;
    await hasuraConnect.mutation(query, variables: {"id": id}).catchError((e) {
      print(e);
    });
  }
}
