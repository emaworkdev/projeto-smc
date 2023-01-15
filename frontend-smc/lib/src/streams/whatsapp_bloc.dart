import 'package:hasura_connect/hasura_connect.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smc/src/services/url_base.dart';
import '../library/bloc_pattern/bloc_pattern.dart';
import '../models/model.dart';
import 'package:smc/src/utils/seta_qtde_conection.dart';

class WhatsappBloc extends BlocBase {
  HasuraConnect hasuraConnect = HasuraConnect(endpointHasura,
      headers: {'x-hasura-admin-secret': passwordHasura});
  var whatsappController = BehaviorSubject<List<WhatsappModel>>();
  SetaQtdeConection setaQ = SetaQtdeConection();

  Stream<List<WhatsappModel>> get outl => whatsappController.stream;

  String query = "";

  WhatsappBloc() {
    getWhatsappStream();
  }

  getWhatsappStream() async {
    query = """
        subscription Whatsapp {
          smc_whatsapps(order_by: {id: asc}) {
            id
            session
            qrcode
            status
            battery
            plugged
            updatedAt
            name
            isDefault
            retries
            number
          }
        }
      """;

    // ignore: close_sinks
    Snapshot snapshot = await hasuraConnect.subscription(
      query,
    );
    snapshot.listen((data) {
      whatsappController
          .add(WhatsappModel.fromJsonList(data["data"]["smc_whatsapps"]));
      // print(data["data"]["smc_whatsapps"]);

      final ret = data["data"]["smc_whatsapps"];
      int qq = 0;

      ret.forEach((e) {
        if (e['status'] == 'CONNECTED') {
          qq++;
        }
      });

      setaQ.setar(qq);
    }).onError((err) {
      // ignore: avoid_print
      print(err);
    });
  }

  Future<List<WhatsappModel>> getWhatsapp() async {
    query = """
        query Whatsapp {
          smc_whatsapps(order_by: {id: asc}) {
            id
            session
            name
            isDefault
            number
          }
        }
      """;

    var data = await hasuraConnect.query(query).catchError((e) {
      //print(query);
      //print(e);
    });
    //print(data["data"]["smc_whatsapps"]);
    List<WhatsappModel> lista = [];

    final ret = data["data"]["smc_whatsapps"];

    ret.forEach((e) {
      WhatsappModel obj = WhatsappModel();
      obj.id = e['id'];
      obj.session = e['session'];
      obj.name = e['name'];
      obj.isDefault = e['isDefault'];
      obj.number = e['number'];
      lista.add(obj);
    });

    return lista;
  }

  @override
  void dispose() async {
    await whatsappController.drain();
    whatsappController.close();
    super.dispose();
  }
}
