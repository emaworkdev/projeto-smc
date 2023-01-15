import 'package:hasura_connect/hasura_connect.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smc/src/services/url_base.dart';

import '../library/bloc_pattern/bloc_pattern.dart';
import '../models/model.dart';

class QuestionBloc extends BlocBase {
  HasuraConnect hasuraConnect = HasuraConnect(endpointHasura,
      headers: {'x-hasura-admin-secret': passwordHasura});
  var questionController = BehaviorSubject<List<QuestionModel>>();

  Stream<List<QuestionModel>> get outl => questionController.stream;

  String query = "";

  QuestionBloc() {
    getQuestionStream();
  }

  getQuestionStream() async {
    query = """
        subscription Question {
          smc_questions(order_by: {id: asc}) {
            id
            name
          }
        }
      """;

    // ignore: close_sinks
    Snapshot snapshot = await hasuraConnect.subscription(query);
    snapshot.listen((data) {
      questionController
          .add(QuestionModel.fromJsonList(data["data"]["smc_questions"]));
      //print('>>>>> Questions ${data["data"]["smc_questions"]}');
    }).onError((err) {
      // ignore: avoid_print
      print(err);
    });
  }

  @override
  void dispose() async {
    await questionController.drain();
    questionController.close();
    super.dispose();
  }
}
