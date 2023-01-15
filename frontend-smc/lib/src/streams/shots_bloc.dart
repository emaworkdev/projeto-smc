import 'package:hasura_connect/hasura_connect.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smc/src/services/url_base.dart';

import '../library/bloc_pattern/bloc_pattern.dart';
import '../models/model.dart';

class ShotsBloc extends BlocBase {
  HasuraConnect hasuraConnect = HasuraConnect(endpointHasura,
      headers: {'x-hasura-admin-secret': passwordHasura});
  var shotController = BehaviorSubject<List<ShotsModel>>();

  Stream<List<ShotsModel>> get outl => shotController.stream;

  String query = "";

  ShotsBloc() {
    getShotStream();
  }

  getShotStream() async {
    query = """
        subscription Shot {
          smc_shots(order_by: {id: asc}) {
            id
            name
            datestart
            datefinalize
            start
            finished
            control
            alvo
            client
          }
        }
      """;

    // ignore: close_sinks
    Snapshot snapshot = await hasuraConnect.subscription(query);
    snapshot.listen((data) {
      shotController.add(ShotsModel.fromJsonList(data["data"]["smc_shots"]));
      //print(data["data"]["smc_shots"]);
    }).onError((err) {
      // ignore: avoid_print
      print(err);
    });
  }

  @override
  void dispose() async {
    await shotController.drain();
    shotController.close();
    super.dispose();
  }
}
