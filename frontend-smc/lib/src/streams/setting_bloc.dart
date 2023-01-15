import 'package:hasura_connect/hasura_connect.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smc/src/services/url_base.dart';

import '../library/bloc_pattern/bloc_pattern.dart';
import '../models/model.dart';

class SettingBloc extends BlocBase {
  HasuraConnect hasuraConnect = HasuraConnect(endpointHasura,
      headers: {'x-hasura-admin-secret': passwordHasura});
  var settingController = BehaviorSubject<List<SettingModel>>();

  Stream<List<SettingModel>> get outl => settingController.stream;

  String query = "";

  SettingBloc() {
    getSettingStream();
  }

  getSettingStream() async {
    query = """
        subscription Setting {
          smc_settings(order_by: {id: asc}, where: {key: {_neq: "userApiToken"}}) {
            id
            description
            key
            value
            content
          }
        }
      """;

    // ignore: close_sinks
    Snapshot snapshot = await hasuraConnect.subscription(query);
    snapshot.listen((data) {
      settingController
          .add(SettingModel.fromJsonList(data["data"]["smc_settings"]));
      //print('>>>>> Queues ${data["data"]["smc_settings"]}');
    }).onError((err) {
      // ignore: avoid_print
      print(err);
    });
  }

  @override
  void dispose() async {
    await settingController.drain();
    settingController.close();
    super.dispose();
  }
}
