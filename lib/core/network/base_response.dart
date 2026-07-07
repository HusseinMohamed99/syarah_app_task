class BaseResponse<T> {
  const BaseResponse({
    this.data,
    this.message,
    this.status,
    this.statusCode,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return BaseResponse<T>(
      data: json['data'] == null ? null : fromJsonT(json['data']),
      message: json['message'] as String?,
      status: json['status'] as bool?,
      statusCode: json['status_code'] as int?,
    );
  }

  final T? data;
  final String? message;
  final bool? status;
  final int? statusCode;
}
