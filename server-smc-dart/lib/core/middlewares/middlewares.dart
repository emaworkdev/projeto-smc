import 'package:shelf/shelf.dart';

abstract class Middewares {
  late Handler innerHandler;

  Handler handler(Handler innerHanler) {
    innerHandler = innerHanler;
    return execute;
  }

  Future<Response> execute(Request request);
}
