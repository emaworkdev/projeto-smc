
import '../bloc_pattern.dart';

class Bloc<T> {
  final T Function(Inject i) inject;
  final bool singleton;

  Bloc(this.inject, {this.singleton = true});
}

class EmptyBloc extends Bloc {
  EmptyBloc() : super((Inject i) {});
}
