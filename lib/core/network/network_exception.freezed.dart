// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NetworkException {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException()';
}


}

/// @nodoc
class $NetworkExceptionCopyWith<$Res>  {
$NetworkExceptionCopyWith(NetworkException _, $Res Function(NetworkException) __);
}


/// Adds pattern-matching-related methods to [NetworkException].
extension NetworkExceptionPatterns on NetworkException {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RequestCancelled value)?  requestCancelled,TResult Function( UnauthorizedRequest value)?  unauthorizedRequest,TResult Function( BadRequest value)?  badRequest,TResult Function( NotFound value)?  notFound,TResult Function( RequestTimeout value)?  requestTimeout,TResult Function( SendTimeout value)?  sendTimeout,TResult Function( Forbidden value)?  forbidden,TResult Function( Conflict value)?  conflict,TResult Function( InternalServerError value)?  internalServerError,TResult Function( ServiceUnavailable value)?  serviceUnavailable,TResult Function( NoInternetConnection value)?  noInternetConnection,TResult Function( FormatFailure value)?  formatException,TResult Function( UnableToProcess value)?  unableToProcess,TResult Function( DefaultError value)?  defaultError,TResult Function( UnexpectedError value)?  unexpectedError,TResult Function( Unknown value)?  unknown,TResult Function( Locked value)?  locked,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RequestCancelled() when requestCancelled != null:
return requestCancelled(_that);case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest(_that);case BadRequest() when badRequest != null:
return badRequest(_that);case NotFound() when notFound != null:
return notFound(_that);case RequestTimeout() when requestTimeout != null:
return requestTimeout(_that);case SendTimeout() when sendTimeout != null:
return sendTimeout(_that);case Forbidden() when forbidden != null:
return forbidden(_that);case Conflict() when conflict != null:
return conflict(_that);case InternalServerError() when internalServerError != null:
return internalServerError(_that);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that);case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection(_that);case FormatFailure() when formatException != null:
return formatException(_that);case UnableToProcess() when unableToProcess != null:
return unableToProcess(_that);case DefaultError() when defaultError != null:
return defaultError(_that);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that);case Unknown() when unknown != null:
return unknown(_that);case Locked() when locked != null:
return locked(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RequestCancelled value)  requestCancelled,required TResult Function( UnauthorizedRequest value)  unauthorizedRequest,required TResult Function( BadRequest value)  badRequest,required TResult Function( NotFound value)  notFound,required TResult Function( RequestTimeout value)  requestTimeout,required TResult Function( SendTimeout value)  sendTimeout,required TResult Function( Forbidden value)  forbidden,required TResult Function( Conflict value)  conflict,required TResult Function( InternalServerError value)  internalServerError,required TResult Function( ServiceUnavailable value)  serviceUnavailable,required TResult Function( NoInternetConnection value)  noInternetConnection,required TResult Function( FormatFailure value)  formatException,required TResult Function( UnableToProcess value)  unableToProcess,required TResult Function( DefaultError value)  defaultError,required TResult Function( UnexpectedError value)  unexpectedError,required TResult Function( Unknown value)  unknown,required TResult Function( Locked value)  locked,}){
final _that = this;
switch (_that) {
case RequestCancelled():
return requestCancelled(_that);case UnauthorizedRequest():
return unauthorizedRequest(_that);case BadRequest():
return badRequest(_that);case NotFound():
return notFound(_that);case RequestTimeout():
return requestTimeout(_that);case SendTimeout():
return sendTimeout(_that);case Forbidden():
return forbidden(_that);case Conflict():
return conflict(_that);case InternalServerError():
return internalServerError(_that);case ServiceUnavailable():
return serviceUnavailable(_that);case NoInternetConnection():
return noInternetConnection(_that);case FormatFailure():
return formatException(_that);case UnableToProcess():
return unableToProcess(_that);case DefaultError():
return defaultError(_that);case UnexpectedError():
return unexpectedError(_that);case Unknown():
return unknown(_that);case Locked():
return locked(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RequestCancelled value)?  requestCancelled,TResult? Function( UnauthorizedRequest value)?  unauthorizedRequest,TResult? Function( BadRequest value)?  badRequest,TResult? Function( NotFound value)?  notFound,TResult? Function( RequestTimeout value)?  requestTimeout,TResult? Function( SendTimeout value)?  sendTimeout,TResult? Function( Forbidden value)?  forbidden,TResult? Function( Conflict value)?  conflict,TResult? Function( InternalServerError value)?  internalServerError,TResult? Function( ServiceUnavailable value)?  serviceUnavailable,TResult? Function( NoInternetConnection value)?  noInternetConnection,TResult? Function( FormatFailure value)?  formatException,TResult? Function( UnableToProcess value)?  unableToProcess,TResult? Function( DefaultError value)?  defaultError,TResult? Function( UnexpectedError value)?  unexpectedError,TResult? Function( Unknown value)?  unknown,TResult? Function( Locked value)?  locked,}){
final _that = this;
switch (_that) {
case RequestCancelled() when requestCancelled != null:
return requestCancelled(_that);case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest(_that);case BadRequest() when badRequest != null:
return badRequest(_that);case NotFound() when notFound != null:
return notFound(_that);case RequestTimeout() when requestTimeout != null:
return requestTimeout(_that);case SendTimeout() when sendTimeout != null:
return sendTimeout(_that);case Forbidden() when forbidden != null:
return forbidden(_that);case Conflict() when conflict != null:
return conflict(_that);case InternalServerError() when internalServerError != null:
return internalServerError(_that);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that);case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection(_that);case FormatFailure() when formatException != null:
return formatException(_that);case UnableToProcess() when unableToProcess != null:
return unableToProcess(_that);case DefaultError() when defaultError != null:
return defaultError(_that);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that);case Unknown() when unknown != null:
return unknown(_that);case Locked() when locked != null:
return locked(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  requestCancelled,TResult Function()?  unauthorizedRequest,TResult Function()?  badRequest,TResult Function()?  notFound,TResult Function()?  requestTimeout,TResult Function()?  sendTimeout,TResult Function()?  forbidden,TResult Function()?  conflict,TResult Function()?  internalServerError,TResult Function()?  serviceUnavailable,TResult Function()?  noInternetConnection,TResult Function()?  formatException,TResult Function()?  unableToProcess,TResult Function( String message)?  defaultError,TResult Function()?  unexpectedError,TResult Function()?  unknown,TResult Function()?  locked,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RequestCancelled() when requestCancelled != null:
return requestCancelled();case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest();case BadRequest() when badRequest != null:
return badRequest();case NotFound() when notFound != null:
return notFound();case RequestTimeout() when requestTimeout != null:
return requestTimeout();case SendTimeout() when sendTimeout != null:
return sendTimeout();case Forbidden() when forbidden != null:
return forbidden();case Conflict() when conflict != null:
return conflict();case InternalServerError() when internalServerError != null:
return internalServerError();case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable();case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection();case FormatFailure() when formatException != null:
return formatException();case UnableToProcess() when unableToProcess != null:
return unableToProcess();case DefaultError() when defaultError != null:
return defaultError(_that.message);case UnexpectedError() when unexpectedError != null:
return unexpectedError();case Unknown() when unknown != null:
return unknown();case Locked() when locked != null:
return locked();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  requestCancelled,required TResult Function()  unauthorizedRequest,required TResult Function()  badRequest,required TResult Function()  notFound,required TResult Function()  requestTimeout,required TResult Function()  sendTimeout,required TResult Function()  forbidden,required TResult Function()  conflict,required TResult Function()  internalServerError,required TResult Function()  serviceUnavailable,required TResult Function()  noInternetConnection,required TResult Function()  formatException,required TResult Function()  unableToProcess,required TResult Function( String message)  defaultError,required TResult Function()  unexpectedError,required TResult Function()  unknown,required TResult Function()  locked,}) {final _that = this;
switch (_that) {
case RequestCancelled():
return requestCancelled();case UnauthorizedRequest():
return unauthorizedRequest();case BadRequest():
return badRequest();case NotFound():
return notFound();case RequestTimeout():
return requestTimeout();case SendTimeout():
return sendTimeout();case Forbidden():
return forbidden();case Conflict():
return conflict();case InternalServerError():
return internalServerError();case ServiceUnavailable():
return serviceUnavailable();case NoInternetConnection():
return noInternetConnection();case FormatFailure():
return formatException();case UnableToProcess():
return unableToProcess();case DefaultError():
return defaultError(_that.message);case UnexpectedError():
return unexpectedError();case Unknown():
return unknown();case Locked():
return locked();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  requestCancelled,TResult? Function()?  unauthorizedRequest,TResult? Function()?  badRequest,TResult? Function()?  notFound,TResult? Function()?  requestTimeout,TResult? Function()?  sendTimeout,TResult? Function()?  forbidden,TResult? Function()?  conflict,TResult? Function()?  internalServerError,TResult? Function()?  serviceUnavailable,TResult? Function()?  noInternetConnection,TResult? Function()?  formatException,TResult? Function()?  unableToProcess,TResult? Function( String message)?  defaultError,TResult? Function()?  unexpectedError,TResult? Function()?  unknown,TResult? Function()?  locked,}) {final _that = this;
switch (_that) {
case RequestCancelled() when requestCancelled != null:
return requestCancelled();case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest();case BadRequest() when badRequest != null:
return badRequest();case NotFound() when notFound != null:
return notFound();case RequestTimeout() when requestTimeout != null:
return requestTimeout();case SendTimeout() when sendTimeout != null:
return sendTimeout();case Forbidden() when forbidden != null:
return forbidden();case Conflict() when conflict != null:
return conflict();case InternalServerError() when internalServerError != null:
return internalServerError();case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable();case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection();case FormatFailure() when formatException != null:
return formatException();case UnableToProcess() when unableToProcess != null:
return unableToProcess();case DefaultError() when defaultError != null:
return defaultError(_that.message);case UnexpectedError() when unexpectedError != null:
return unexpectedError();case Unknown() when unknown != null:
return unknown();case Locked() when locked != null:
return locked();case _:
  return null;

}
}

}

/// @nodoc


class RequestCancelled implements NetworkException {
  const RequestCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.requestCancelled()';
}


}




/// @nodoc


class UnauthorizedRequest implements NetworkException {
  const UnauthorizedRequest();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedRequest);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.unauthorizedRequest()';
}


}




/// @nodoc


class BadRequest implements NetworkException {
  const BadRequest();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BadRequest);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.badRequest()';
}


}




/// @nodoc


class NotFound implements NetworkException {
  const NotFound();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.notFound()';
}


}




/// @nodoc


class RequestTimeout implements NetworkException {
  const RequestTimeout();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestTimeout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.requestTimeout()';
}


}




/// @nodoc


class SendTimeout implements NetworkException {
  const SendTimeout();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendTimeout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.sendTimeout()';
}


}




/// @nodoc


class Forbidden implements NetworkException {
  const Forbidden();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Forbidden);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.forbidden()';
}


}




/// @nodoc


class Conflict implements NetworkException {
  const Conflict();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conflict);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.conflict()';
}


}




/// @nodoc


class InternalServerError implements NetworkException {
  const InternalServerError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InternalServerError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.internalServerError()';
}


}




/// @nodoc


class ServiceUnavailable implements NetworkException {
  const ServiceUnavailable();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceUnavailable);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.serviceUnavailable()';
}


}




/// @nodoc


class NoInternetConnection implements NetworkException {
  const NoInternetConnection();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoInternetConnection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.noInternetConnection()';
}


}




/// @nodoc


class FormatFailure implements NetworkException {
  const FormatFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.formatException()';
}


}




/// @nodoc


class UnableToProcess implements NetworkException {
  const UnableToProcess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnableToProcess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.unableToProcess()';
}


}




/// @nodoc


class DefaultError implements NetworkException {
  const DefaultError(this.message);
  

 final  String message;

/// Create a copy of NetworkException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DefaultErrorCopyWith<DefaultError> get copyWith => _$DefaultErrorCopyWithImpl<DefaultError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefaultError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NetworkException.defaultError(message: $message)';
}


}

/// @nodoc
abstract mixin class $DefaultErrorCopyWith<$Res> implements $NetworkExceptionCopyWith<$Res> {
  factory $DefaultErrorCopyWith(DefaultError value, $Res Function(DefaultError) _then) = _$DefaultErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DefaultErrorCopyWithImpl<$Res>
    implements $DefaultErrorCopyWith<$Res> {
  _$DefaultErrorCopyWithImpl(this._self, this._then);

  final DefaultError _self;
  final $Res Function(DefaultError) _then;

/// Create a copy of NetworkException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DefaultError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UnexpectedError implements NetworkException {
  const UnexpectedError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnexpectedError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.unexpectedError()';
}


}




/// @nodoc


class Unknown implements NetworkException {
  const Unknown();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Unknown);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.unknown()';
}


}




/// @nodoc


class Locked implements NetworkException {
  const Locked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Locked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkException.locked()';
}


}




// dart format on
