import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

@freezed
sealed class NetworkException with _$NetworkException {
  const factory NetworkException.requestCancelled() = RequestCancelled;
  const factory NetworkException.unauthorizedRequest() = UnauthorizedRequest;
  const factory NetworkException.badRequest() = BadRequest;
  const factory NetworkException.notFound() = NotFound;
  const factory NetworkException.requestTimeout() = RequestTimeout;
  const factory NetworkException.sendTimeout() = SendTimeout;
  const factory NetworkException.forbidden() = Forbidden;
  const factory NetworkException.conflict() = Conflict;
  const factory NetworkException.internalServerError() = InternalServerError;
  const factory NetworkException.serviceUnavailable() = ServiceUnavailable;
  const factory NetworkException.noInternetConnection() = NoInternetConnection;
  const factory NetworkException.formatException() = FormatFailure;
  const factory NetworkException.unableToProcess() = UnableToProcess;
  const factory NetworkException.defaultError(String message) = DefaultError;
  const factory NetworkException.unexpectedError() = UnexpectedError;
  const factory NetworkException.unknown() = Unknown;
  const factory NetworkException.locked() = Locked;
}
