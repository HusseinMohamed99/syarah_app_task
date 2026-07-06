// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoListState {

 TodoListStatus get status; List<TodoModel> get todos; String get searchQuery; NetworkException? get error;
/// Create a copy of TodoListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoListStateCopyWith<TodoListState> get copyWith => _$TodoListStateCopyWithImpl<TodoListState>(this as TodoListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoListState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.todos, todos)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(todos),searchQuery,error);

@override
String toString() {
  return 'TodoListState(status: $status, todos: $todos, searchQuery: $searchQuery, error: $error)';
}


}

/// @nodoc
abstract mixin class $TodoListStateCopyWith<$Res>  {
  factory $TodoListStateCopyWith(TodoListState value, $Res Function(TodoListState) _then) = _$TodoListStateCopyWithImpl;
@useResult
$Res call({
 TodoListStatus status, List<TodoModel> todos, String searchQuery, NetworkException? error
});


$NetworkExceptionCopyWith<$Res>? get error;

}
/// @nodoc
class _$TodoListStateCopyWithImpl<$Res>
    implements $TodoListStateCopyWith<$Res> {
  _$TodoListStateCopyWithImpl(this._self, this._then);

  final TodoListState _self;
  final $Res Function(TodoListState) _then;

/// Create a copy of TodoListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? todos = null,Object? searchQuery = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodoListStatus,todos: null == todos ? _self.todos : todos // ignore: cast_nullable_to_non_nullable
as List<TodoModel>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}
/// Create a copy of TodoListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkExceptionCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $NetworkExceptionCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// Adds pattern-matching-related methods to [TodoListState].
extension TodoListStatePatterns on TodoListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoListState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoListState value)  $default,){
final _that = this;
switch (_that) {
case _TodoListState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoListState value)?  $default,){
final _that = this;
switch (_that) {
case _TodoListState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TodoListStatus status,  List<TodoModel> todos,  String searchQuery,  NetworkException? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoListState() when $default != null:
return $default(_that.status,_that.todos,_that.searchQuery,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TodoListStatus status,  List<TodoModel> todos,  String searchQuery,  NetworkException? error)  $default,) {final _that = this;
switch (_that) {
case _TodoListState():
return $default(_that.status,_that.todos,_that.searchQuery,_that.error);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TodoListStatus status,  List<TodoModel> todos,  String searchQuery,  NetworkException? error)?  $default,) {final _that = this;
switch (_that) {
case _TodoListState() when $default != null:
return $default(_that.status,_that.todos,_that.searchQuery,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _TodoListState extends TodoListState {
  const _TodoListState({this.status = TodoListStatus.initial, final  List<TodoModel> todos = const <TodoModel>[], this.searchQuery = '', this.error}): _todos = todos,super._();
  

@override@JsonKey() final  TodoListStatus status;
 final  List<TodoModel> _todos;
@override@JsonKey() List<TodoModel> get todos {
  if (_todos is EqualUnmodifiableListView) return _todos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todos);
}

@override@JsonKey() final  String searchQuery;
@override final  NetworkException? error;

/// Create a copy of TodoListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoListStateCopyWith<_TodoListState> get copyWith => __$TodoListStateCopyWithImpl<_TodoListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoListState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._todos, _todos)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_todos),searchQuery,error);

@override
String toString() {
  return 'TodoListState(status: $status, todos: $todos, searchQuery: $searchQuery, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TodoListStateCopyWith<$Res> implements $TodoListStateCopyWith<$Res> {
  factory _$TodoListStateCopyWith(_TodoListState value, $Res Function(_TodoListState) _then) = __$TodoListStateCopyWithImpl;
@override @useResult
$Res call({
 TodoListStatus status, List<TodoModel> todos, String searchQuery, NetworkException? error
});


@override $NetworkExceptionCopyWith<$Res>? get error;

}
/// @nodoc
class __$TodoListStateCopyWithImpl<$Res>
    implements _$TodoListStateCopyWith<$Res> {
  __$TodoListStateCopyWithImpl(this._self, this._then);

  final _TodoListState _self;
  final $Res Function(_TodoListState) _then;

/// Create a copy of TodoListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? todos = null,Object? searchQuery = null,Object? error = freezed,}) {
  return _then(_TodoListState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodoListStatus,todos: null == todos ? _self._todos : todos // ignore: cast_nullable_to_non_nullable
as List<TodoModel>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as NetworkException?,
  ));
}

/// Create a copy of TodoListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkExceptionCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $NetworkExceptionCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
