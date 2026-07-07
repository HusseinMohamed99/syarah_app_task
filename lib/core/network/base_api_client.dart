import 'package:dio/dio.dart';
import 'package:syarah_app_task/core/network/api_result.dart';
import 'package:syarah_app_task/core/network/base_response.dart';
import 'package:syarah_app_task/core/network/network_error_handler.dart';
import 'package:syarah_app_task/core/network/network_exception.dart';

class BaseApiClient {
  const BaseApiClient(this._dio);

  final Dio _dio;

  Future<ApiResult<BaseResponse<T>>> get<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    Map<String, dynamic>? queryParameters,
  }) {
    return _guard(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      return BaseResponse<T>.fromJson(response.data ?? {}, fromJsonT);
    });
  }

  Future<ApiResult<BaseResponse<List<T>>>> getList<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    Map<String, dynamic>? queryParameters,
  }) {
    return _guard(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      return BaseResponse<List<T>>.fromJson(
        response.data ?? {},
        (data) => (data as List<dynamic>? ?? [])
            .map((e) => fromJsonT(e))
            .toList(),
      );
    });
  }

  Future<ApiResult<BaseResponse<T>>> post<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    Object? data,
  }) {
    return _guard(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        path,
        data: data,
      );
      return BaseResponse<T>.fromJson(response.data ?? {}, fromJsonT);
    });
  }

  Future<ApiResult<BaseResponse<T>>> put<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    Object? data,
  }) {
    return _guard(() async {
      final response = await _dio.put<Map<String, dynamic>>(
        path,
        data: data,
      );
      return BaseResponse<T>.fromJson(response.data ?? {}, fromJsonT);
    });
  }

  Future<ApiResult<BaseResponse<T>>> delete<T>(
    String path, {
    required T Function(Object? json) fromJsonT,
    Object? data,
  }) {
    return _guard(() async {
      final response = await _dio.delete<Map<String, dynamic>>(
        path,
        data: data,
      );
      return BaseResponse<T>.fromJson(response.data ?? {}, fromJsonT);
    });
  }

  Future<ApiResult<T>> getRaw<T>(
    String path, {
    required T Function(dynamic data) fromJson,
    Map<String, dynamic>? queryParameters,
  }) {
    return _guard(() async {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
      );
      return fromJson(response.data);
    });
  }

  Future<ApiResult<T>> postRaw<T>(
    String path, {
    required T Function(dynamic data) fromJson,
    Object? data,
  }) {
    return _guard(() async {
      final response = await _dio.post<dynamic>(path, data: data);
      return fromJson(response.data);
    });
  }

  Future<ApiResult<T>> putRaw<T>(
    String path, {
    required T Function(dynamic data) fromJson,
    Object? data,
  }) {
    return _guard(() async {
      final response = await _dio.put<dynamic>(path, data: data);
      return fromJson(response.data);
    });
  }

  Future<ApiResult<bool>> deleteRaw(
    String path, {
    Object? data,
  }) {
    return _guard(() async {
      await _dio.delete<dynamic>(path, data: data);
      return true;
    });
  }

  Future<ApiResult<T>> _guard<T>(Future<T> Function() request) async {
    try {
      final data = await request();
      return ApiResult.success(data);
    } on DioException catch (error) {
      return ApiResult.failure(NetworkErrorHandler.handleError(error));
    } on FormatException {
      return const ApiResult.failure(NetworkException.formatException());
    } catch (_) {
      return const ApiResult.failure(NetworkException.unexpectedError());
    }
  }
}
