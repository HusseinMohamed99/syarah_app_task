import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syarah_app_task/core/network/base_api_client.dart';
import 'package:syarah_app_task/core/network/network_providers.dart';

/// Exposes the single shared [BaseApiClient]. Hand-written DI provider.
final baseApiClientProvider = Provider<BaseApiClient>((ref) {
  return BaseApiClient(ref.watch(dioProvider));
});
