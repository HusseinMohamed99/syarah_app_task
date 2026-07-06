import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syarah_app_task/core/network/api_result.dart';
import 'package:syarah_app_task/core/network/base_api_client.dart';
import 'package:syarah_app_task/core/network/network_error_handler.dart';
import 'package:syarah_app_task/core/network/network_exception.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';
import 'package:syarah_app_task/features/todos/data/repo_impl/todos_repo_impl.dart';

// NOTE: this file intentionally contains no `testWidgets`. The Flutter test
// binding installs an HTTP override that returns 400 for every real request,
// which would mask the genuine SocketException we want to exercise here.

void main() {
  group('NetworkErrorHandler offline mapping', () {
    test('connectionError maps to noInternetConnection', () {
      final error = DioException(
        requestOptions: RequestOptions(path: '/todos'),
        type: DioExceptionType.connectionError,
        error: const SocketException('Connection refused'),
      );

      expect(
        NetworkErrorHandler.handleError(error),
        const NetworkException.noInternetConnection(),
      );
    });

    test('unknown type carrying a SocketException maps to '
        'noInternetConnection', () {
      final error = DioException(
        requestOptions: RequestOptions(path: '/todos'),
        type: DioExceptionType.unknown,
        error: const SocketException('No route to host'),
      );

      expect(
        NetworkErrorHandler.handleError(error),
        const NetworkException.noInternetConnection(),
      );
    });
  });

  test('a real request to an unreachable host surfaces '
      'noInternetConnection', () async {
    // Point a real Dio at a host that cannot be resolved/reached so the
    // actual client throws a genuine SocketException, exercising the whole
    // BaseApiClient -> NetworkErrorHandler path end to end.
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://nonexistent.invalid',
        connectTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );
    final repo = TodosRepoImpl(BaseApiClient(dio));

    final result = await repo.getTodos(page: 1, limit: 20);

    expect(
      result,
      const ApiResult<List<TodoModel>>.failure(
        NetworkException.noInternetConnection(),
      ),
    );
  });
}
