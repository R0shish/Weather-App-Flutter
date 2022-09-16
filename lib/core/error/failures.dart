import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

// General failures

class ServerFailure extends Failure {
  late final String message;

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  late final String message;

  @override
  List<Object> get props => [message];
}
