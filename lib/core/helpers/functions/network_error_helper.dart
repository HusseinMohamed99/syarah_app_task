import 'package:syarah_app_task/core/network/network_exception.dart';

String getNetworkErrorMessage(
  Object error, {
  String fallbackKey = 'Something went wrong. Please try again.',
}) {
  if (error is! NetworkException) return fallbackKey;

  return switch (error) {
    RequestCancelled() => 'The request was cancelled.',
    UnauthorizedRequest() => 'You are not authorized to access this.',
    BadRequest() => 'Invalid request.',
    NotFound() => 'The requested data could not be found.',
    RequestTimeout() => 'Connection timed out. Please try again.',
    SendTimeout() => 'Sending data timed out.',
    Forbidden() => 'You do not have permission to access this.',
    Conflict() => 'There is a conflict in the data.',
    InternalServerError() => 'A server error occurred. Please try later.',
    ServiceUnavailable() => 'The service is currently unavailable.',
    NoInternetConnection() => 'No internet connection.',
    FormatFailure() => 'The data format is invalid.',
    UnableToProcess() => 'Unable to process the data.',
    DefaultError(:final message) => message,
    UnexpectedError() => fallbackKey,
    Unknown() => fallbackKey,
    Locked() => 'The account is temporarily locked.',
  };
}
