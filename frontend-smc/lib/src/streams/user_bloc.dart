import 'package:hasura_connect/hasura_connect.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smc/src/services/url_base.dart';

import '../library/bloc_pattern/bloc_pattern.dart';
import '../models/model.dart';

class UserBloc extends BlocBase {
  HasuraConnect hasuraConnect = HasuraConnect(endpointHasura,
      headers: {'x-hasura-admin-secret': passwordHasura});
  var userController = BehaviorSubject<List<UserModel>>();

  Stream<List<UserModel>> get outl => userController.stream;

  String query = "";

  UserBloc() {
    getUserStream();
  }

  getUserStream() async {
    query = """
        subscription User {
          smc_users(order_by: {id: asc}) {
            id
            whatsappId
            name
            email
            profile
            device_token
            startwork
            endwork
            status
            tokenVersion
            web_token
          }
        }
      """;

    // ignore: close_sinks
    Snapshot snapshot = await hasuraConnect.subscription(query);
    snapshot.listen((data) {
      userController.add(UserModel.fromJsonList(data["data"]["smc_users"]));
      //print(data["data"]["smc_users"]);
    }).onError((err) {
      // ignore: avoid_print
      print(err);
    });
  }

  @override
  void dispose() async {
    await userController.drain();
    userController.close();
    super.dispose();
  }
}
