// ignore_for_file: always_specify_types, prefer_single_quotes
import 'dart:developer';
import 'dart:io' show HttpException, SocketException;
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../error/exceptions.dart';
import '../../global/api_keys.dart';
import 'network_request_body.dart';

enum HttpMethod { get, post, patch, put, delete }

enum CodeStatus { defaultCode, activation }

List<Duration> generateExponentialDelays() {
  const int maxRetries = 50;
  const int initialDelaySeconds = 1;
  const int maxDelaySeconds = 300;
  final List<Duration> delays = [];
  for (int i = 0; i < maxRetries; i++) {
    final int delaySeconds = initialDelaySeconds * (1 << i); // 2^i
    delays.add(
      Duration(
        seconds:
            delaySeconds > maxDelaySeconds ? maxDelaySeconds : delaySeconds,
      ),
    );
  }
  return delays;
}

class ApiBaseHelper {
  static final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  final Dio _dio;

  ApiBaseHelper()
      : _dio = Dio(
          BaseOptions(
            baseUrl: APIKeys.baseUrl,
            headers: Map.from(_defaultHeaders)..['Connection'] = 'keep-alive',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            receiveDataWhenStatusError: true,
            validateStatus: (int? status) => true,
            extra: {'http2': true},
          ),
        ) {
    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: true,
        request: true,
      ),
      RetryInterceptor(
        dio: _dio,
        logPrint: (message) => log(message),
        retries: 50,
        retryDelays: generateExponentialDelays(),
        retryEvaluator: (DioException error, int attempt) {
          if (error.type == DioExceptionType.connectionError ||
              error.type == DioExceptionType.receiveTimeout ||
              error.error is HttpException) {
            return true;
          }
          return false;
        },
      ),
    ]);
  }

  Future<dynamic> request({
    required HttpMethod method,
    required String url,
    NetworkRequestBody? body,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (token != null) {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      } else {
        _dio.options.headers.remove('Authorization');
      }

      Response response;
      final dynamic requestBody = _convertBodyToMap(body);
      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(url, queryParameters: queryParameters);
          break;
        case HttpMethod.post:
          response = await _dio.post(
            url,
            data: FormData.fromMap(requestBody ?? {}),
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.patch:
          response = await _dio.patch(
            url,
            data: requestBody,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.put:
          response = await _dio.put(
            url,
            data: requestBody,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.delete:
          response = await _dio.delete(url, queryParameters: queryParameters);
          break;
      }

      return response.data;
    } on SocketException {
      throw ServerException(message: "no internet connection");
    } on DioException catch (e) {
      log("DioException: ${e.type}, Message: ${e.message}, Error: ${e.error}");
      if (e.type == DioExceptionType.unknown) {
        return Future.delayed(
          const Duration(seconds: 2),
          () => request(
            method: method,
            url: url,
            body: body,
            token: token,
            queryParameters: queryParameters,
          ),
        );
      }

      throw ServerException(message: _handleDioException(e));
    } catch (e, stackTrace) {
      log("Unexpected error: $e, StackTrace: $stackTrace");
      throw ServerException(message: "Unexpected error occurred");
    }
  }

  Map<String, dynamic>? _convertBodyToMap(NetworkRequestBody? body) {
    if (body is RawNetworkRequestBody) {
      return body.data;
    }
    return null;
  }

  static String _handleDioException(DioException e) {
    log("DioExceptionType: ${e.type}");
    log("Error Message: ${e.message}");
    log("Stack Trace: ${e.stackTrace}");

    if (e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionTimeout) {
      return "Connection Timeout";
    }

    if (e.type == DioExceptionType.unknown) {
      log("Unknown DioException Occurred: ${e.error}");
    }

    return _getCustomErrorMessage(e);
  }

  static String _getCustomErrorMessage(DioException e) {
    if (e.response != null) {
      final int statusCode = e.response!.statusCode ?? 0;
      if (statusCode == 500) {
        return "Server Error";
      }
      return e.response?.data['message'] ?? "Unknown Error";
    }
    return "Unknown Error";
  }
}
