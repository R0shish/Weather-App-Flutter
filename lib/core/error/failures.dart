import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

// General failures

class ServerFailure extends Failure {
  final String message = 'Server Failure';

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  final String message = 'Cache Failure';

  @override
  List<Object> get props => [message];
}
