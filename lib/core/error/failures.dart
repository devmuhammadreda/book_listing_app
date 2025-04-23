// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'exceptions.dart';

enum CodeStatus { defaultCode, activation }

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
  @override
  List<Object> get props => <Object>[];
}

// General failures
class ServerFailure extends Failure {
  final CodeStatus code;
  final Map<String, dynamic>? errorMap;
  const ServerFailure({
    required super.message,
    this.errorMap,
    this.code = CodeStatus.defaultCode,
  });
  factory ServerFailure.formServerException(ServerException exception) {
    return ServerFailure(
      message: exception.message,
      errorMap: exception.errorMap,
      code: exception.code,
    );
  }
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
  factory CacheFailure.formCacheException(CacheException exception) {
    return CacheFailure(message: exception.message);
  }
}
