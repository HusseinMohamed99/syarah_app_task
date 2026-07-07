import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:syarah_app_task/core/network/network_exception.dart';

part 'api_result.freezed.dart';

@freezed
sealed class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.failure(NetworkException error) = Failure<T>;
}
