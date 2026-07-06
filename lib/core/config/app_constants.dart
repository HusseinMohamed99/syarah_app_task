/// Application-wide configuration constants.
class AppConstants {
  const AppConstants._();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration networkTimeout = Duration(seconds: 120);

  static const String todosEndpoint = '/todos';
}
