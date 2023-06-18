import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/configs.dart';
import 'package:nao_controller/data/datasources/remote/nao_service.dart';
import 'package:nao_controller/presentation/providers/shared_preferences_provider.dart';

final naoServicePtovider = Provider<NaoService>((ref){
    final url = ref
    .watch(sharedPreferencesProvider)
    .getString(naoIpAddressKey) ?? "http://localhost/";

  return NaoService(url);
});