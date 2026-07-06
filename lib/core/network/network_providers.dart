import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syarah_app_task/core/config/app_constants.dart';
import 'package:syarah_app_task/core/network/interceptors/logging_interceptor.dart';
import 'package:syarah_app_task/core/network/interceptors/retry_interceptor.dart';

/// The single [Dio] instance used across the entire app. Hand-written DI
/// provider — only one Dio ever exists.
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.networkTimeout,
      receiveTimeout: AppConstants.networkTimeout,
      sendTimeout: AppConstants.networkTimeout,
      headers: const {'Accept': 'application/json'},
      validateStatus: (status) =>
          status != null && status >= 200 && status < 300,
    ),
  );

  dio.interceptors.addAll([
    RetryInterceptor(dio),
    LoggingInterceptor(),
  ]);

  return dio;
});
