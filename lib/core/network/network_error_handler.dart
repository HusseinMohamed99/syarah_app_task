import 'dart:io';

import 'package:dio/dio.dart';
import 'package:syarah_app_task/core/network/network_exception.dart';

class NetworkErrorHandler {
  const NetworkErrorHandler._();

  static NetworkException handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return const NetworkException.requestCancelled();
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const NetworkException.requestTimeout();
      case DioExceptionType.sendTimeout:
        return const NetworkException.sendTimeout();
      case DioExceptionType.badCertificate:
        return const NetworkException.unauthorizedRequest();
      case DioExceptionType.connectionError:
        return const NetworkException.noInternetConnection();
      case DioExceptionType.badResponse:
        return _mapStatusCode(error.response?.statusCode);
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return const NetworkException.noInternetConnection();
        }
        return const NetworkException.unexpectedError();
    }
  }

  static NetworkException _mapStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return const NetworkException.badRequest();
      case 401:
        return const NetworkException.unauthorizedRequest();
      case 403:
        return const NetworkException.forbidden();
      case 404:
        return const NetworkException.notFound();
      case 409:
        return const NetworkException.conflict();
      case 423:
        return const NetworkException.locked();
      case 500:
        return const NetworkException.internalServerError();
      case 503:
        return const NetworkException.serviceUnavailable();
      default:
        return const NetworkException.unexpectedError();
    }
  }
}
