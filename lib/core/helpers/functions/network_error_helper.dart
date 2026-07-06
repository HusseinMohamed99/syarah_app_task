import 'package:syarah_app_task/core/network/network_exception.dart';

/// Pattern-matches a [NetworkException] into a user-facing Arabic string.
///
/// This project has no localization layer, so plain strings are used.
String getNetworkErrorMessage(
  Object error, {
  String fallbackKey = 'حدث خطأ غير متوقع، حاول مرة أخرى',
}) {
  if (error is! NetworkException) return fallbackKey;

  return switch (error) {
    RequestCancelled() => 'تم إلغاء الطلب',
    UnauthorizedRequest() => 'غير مصرّح لك بالوصول',
    BadRequest() => 'طلب غير صالح',
    NotFound() => 'لم يتم العثور على البيانات المطلوبة',
    RequestTimeout() => 'انتهت مهلة الاتصال، حاول مرة أخرى',
    SendTimeout() => 'انتهت مهلة إرسال البيانات',
    Forbidden() => 'ليس لديك صلاحية للوصول',
    Conflict() => 'يوجد تعارض في البيانات',
    InternalServerError() => 'حدث خطأ في الخادم، حاول لاحقًا',
    ServiceUnavailable() => 'الخدمة غير متوفرة حاليًا',
    NoInternetConnection() => 'لا يوجد اتصال بالإنترنت',
    FormatFailure() => 'صيغة البيانات غير صحيحة',
    UnableToProcess() => 'تعذّر معالجة البيانات',
    DefaultError(:final message) => message,
    UnexpectedError() => fallbackKey,
    Unknown() => fallbackKey,
    Locked() => 'الحساب مقفل مؤقتًا',
  };
}
