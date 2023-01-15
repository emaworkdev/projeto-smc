// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:hasura_connect/hasura_connect.dart';
import 'package:dotenv/dotenv.dart';
import 'package:server_smc/core/helpers/cripty_helper.dart';
import 'package:server_smc/models/user_model.dart';

class UserHasuraService {
  HasuraConnect hasuraConnect = HasuraConnect(env['hasuraHost']!,
      headers: {'x-hasura-admin-secret': env['hasuraPassword']!});

  String query = "";

  Future<bool> existe(String email) async {
    query = """
      query User(\$email:String!) {
        smc_users(where: {email: {_eq: \$email}}) {
            id
          }
      }
    """;
    var r = await hasuraConnect
        .query(query, variables: {"email": email}).catchError((e) {
      //print(query);
      print(e);
    });
    //print(r["data"]["smc_users"]);
    if (r["data"]["smc_users"].isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<UserModel> login(String email, String pass) async {
    String password = CriptyHelper.generatedSha256Hash(pass);
    //print("Senha: $password");
    query = """
      query User(\$email:String!, \$password:String!) {
        smc_users(where: {email: {_eq: \$email}, password: {_eq: \$password}}) {
            id
            name
            email
          }
      }
    """;
    var r = await hasuraConnect.query(query,
        variables: {"email": email, "password": password}).catchError((e) {
      //print(query);
      print(e);
    });
    //print(r["data"]["smc_users"][0]);
    UserModel user = UserModel();
    List<dynamic> lista = r["data"]["smc_users"];
    lista.forEach((e) {
      user.id = e['id'];
      user.name = e['name'];
      user.email = e['email'];
      user.password = '';
    });
    //print(user.toJson());

    return user;
  }

  Future<String> create(UserModel obj) async {
    String password = CriptyHelper.generatedSha256Hash(obj.password!);

    query = """
     mutation MyMutation {
       insert_smc_users(objects: {
            name: "${obj.name}",
            email: "${obj.email}", 
            password: "$password",
            }) {
          affected_rows
          returning {
            id
            name
            email
          }
        }
       } 
    """;
    var ret = await hasuraConnect.mutation(query).catchError((e) {
      //print(query);
      print(e);
      return '0';
    });
    //ret['data']['insert_smc_users']['returning'][0]
    UserModel user = UserModel();
    var e = ret['data']['insert_smc_users']['returning'][0];
    user.id = e['id'];
    user.name = e['name'];
    user.email = e['email'];
    user.password = '';

    return user.id.toString();
  }

  Future<String> update(UserModel obj) async {
    query = """
     mutation MyMutation(\$id:Int!) {
        update_smc_users(where: {id: {_eq: \$id}}, _set: {
            name: "${obj.name}",
            email: "${obj.email}", 
            }) {
          affected_rows
          returning {
            id
            tenantId
            name
            email
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
    //ret['data']['update_smc_users']['returning'][0]
    UserModel user = UserModel();
    var e = ret['data']['update_smc_users']['returning'][0];
    user.id = e['id'];
    user.name = e['name'];
    user.email = e['email'];
    user.password = '';

    return user.id.toString();
  }

  Future<String> updatePassword(String email, String password) async {
    query = """
     mutation MyMutation(\$email:String!) {
        update_smc_users(where: {email: {_eq: \$email}}, _set: {
            password: "$password"
            }) {
          affected_rows
          returning {
            id
          }
        }
       } 
    """;
    var ret = await hasuraConnect
        .mutation(query, variables: {"email": email}).catchError((e) {
      print(query);
      print(e);
      return '0';
    });
    print(ret['data']['update_smc_users']['returning'][0]);
    var ee = ret['data']['update_smc_users']['returning'][0];

    return ee.toString();
  }

  delete(int id) async {
    query = """
      mutation MyMutation(\$id:Int!) {
        delete_smc_users(where: {id: {_eq: \$id}}) {
          affected_rows
        }
      }
    """;
    await hasuraConnect.mutation(query, variables: {"id": id}).catchError((e) {
      print(e);
    });
  }
}
