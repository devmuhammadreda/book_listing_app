import 'failures.dart';

class ServerException implements Exception {
  final String message;
  final CodeStatus code;
  final Map<String, dynamic>? errorMap;
  ServerException({
    this.errorMap,
    required this.message,
    this.code = CodeStatus.defaultCode,
  });
}

class CacheException implements Exception {
  final String message;
  CacheException({required this.message});
}

