import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syarah_app_task/core/network/base_api_client.dart';
import 'package:syarah_app_task/core/network/network_providers.dart';

final baseApiClientProvider = Provider<BaseApiClient>((ref) {
  return BaseApiClient(ref.watch(dioProvider));
});
