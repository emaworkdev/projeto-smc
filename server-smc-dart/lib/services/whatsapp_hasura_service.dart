import 'package:hasura_connect/hasura_connect.dart';
import 'package:dotenv/dotenv.dart';
import 'package:server_smc/models/connect_hasura.dart';
import 'package:server_smc/models/whatsapp_model.dart';

class WhatsappHasuraService {
  HasuraConnect hasuraConnect = HasuraConnect(env['hasuraHost']!,
      headers: {'x-hasura-admin-secret': env['hasuraPassword']!});

  String query = "";

  Future<bool> existeSessao(String sessao) async {
    query = """
      query Whatsapp(\$sessao:String!) {
        smc_whatsapps(where: {sessao: {_eq: \$sessao}}) {
            id
          }
      }
    """;
    var r = await hasuraConnect
        .query(query, variables: {"sessao": sessao}).catchError((e) {
      //print(query);
      print(e);
    });
    //print(r["data"]["smc_whatsapps"]);
    if (r["data"]["smc_whatsapps"].isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> existe(int id) async {
    query = """
      query Whatsapp(\$id:Int!) {
        smc_whatsapps(where: {id: {_eq: \$id}}) {
            id
          }
      }
    """;
    var r =
        await hasuraConnect.query(query, variables: {"id": id}).catchError((e) {
      //print(query);
      print(e);
    });
    //print(r["data"]["smc_whatsapps"]);
    if (r["data"]["smc_whatsapps"].isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> create(WhatsappModel obj) async {
    query = """
     mutation MyMutation {
       insert_smc_whatsapps(objects: {
            qrcode: "${obj.qrcode}", 
            session: "${obj.session}", 
            status: "${obj.status}", 
            battery: "${obj.battery}",
            plugged: ${obj.plugged},
            name: "${obj.name}",
            isDefault: ${obj.isDefault},
            retries: ${obj.retries},
            number: "${obj.number}",
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
    //ret['data']['insert_smc_whatsapps']['returning'][0]
    return ret['data']['insert_smc_whatsapps']['returning'][0]['id'].toString();
  }

  Future<String> update(WhatsappModel obj) async {
    query = """
     mutation MyMutation(\$id:Int!) {
        update_smc_whatsapps(where: {id: {_eq: \$id}}, _set: {
            id: ${obj.id},
            qrcode: "${obj.qrcode}", 
            session: "${obj.session}", 
            status: "${obj.status}", 
            battery: "${obj.battery}",
            plugged: ${obj.plugged},
            updatedAt: "${obj.updatedAt}",
            name: "${obj.name}",
            isDefault: ${obj.isDefault},
            retries: ${obj.retries},
            number: "${obj.number}",
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
    //ret['data']['update_smc_whatsapps']['returning'][0]
    return ret['data']['update_smc_whatsapps']['returning'][0]['id'].toString();
  }

  atualizaToken(String session, String token) async {
    query = """
     mutation MyMutation(\$session:String!) {
        update_smc_whatsapps(where: {session: {_eq: \$session}}, _set: {
            token: "$token"
           }) {
          affected_rows
          returning {
            id
          }
        }
       } 
    """;

    await hasuraConnect
        .mutation(query, variables: {"session": session}).catchError((e) {
      //print(query);
      print(e);
    });
    //ret['data']['update_smc_whatsapps']['returning'][0]
  }

  atualizaStatusFind(String session, String status, bool plugged) async {
    // ignore: avoid_init_to_null
    var qrcode = null;
    query = """
     mutation MyMutation(\$session:String!) {
        update_smc_whatsapps(where: {session: {_eq: \$session}}, _set: {
            status: "$status",
            qrcode: "$qrcode",
            plugged: $plugged
           }) {
          affected_rows
          returning {
            id
          }
        }
       } 
    """;

    await hasuraConnect
        .mutation(query, variables: {"session": session}).catchError((e) {
      //print(query);
      print(e);
    });
    //ret['data']['update_smc_whatsapps']['returning'][0]
  }

  atualizaQrCode(ConnectHasura ev) async {
    query = """
     mutation MyMutation(\$session:String!) {
        update_smc_whatsapps(where: {session: {_eq: \$session}}, _set: {
            qrcode: "${ev.qrcode}",
            status: "${ev.event}"
           }) {
          affected_rows
          returning {
            id
          }
        }
       } 
    """;

    await hasuraConnect
        .mutation(query, variables: {"session": ev.session}).catchError((e) {
      //print(query);
      print(e);
    });
    //ret['data']['update_smc_whatsapps']['returning'][0]
  }

  delete(int id) async {
    query = """
      mutation MyMutation(\$id:Int!) {
        delete_smc_whatsapps(where: {id: {_eq: \$id}}) {
          affected_rows
        }
      }
    """;
    await hasuraConnect.mutation(query, variables: {"id": id}).catchError((e) {
      print(e);
    });
  }
}
