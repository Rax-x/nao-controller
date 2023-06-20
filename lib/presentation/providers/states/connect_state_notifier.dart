import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/configs.dart';
import 'package:nao_controller/presentation/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final connectStateNotifier = 
  StateNotifierProvider<ConnectStateNotifier, ConnectState>((ref){
    final preferences = ref.watch(sharedPreferencesProvider);
    return ConnectStateNotifier(preferences);
  });

class ConnectStateNotifier extends StateNotifier<ConnectState> {

  final SharedPreferences _preferences;

  ConnectStateNotifier(this._preferences) : super(ConnectState.none());

  Future<void> connect(String url) async {
    state = ConnectState.loading();
    await _preferences.setString(naoIpAddressKey, url);
    state = ConnectState.success();
  }

}

sealed class ConnectState {
  ConnectState._();

  factory ConnectState.none() => ConnectStateNone();
  factory ConnectState.success() => ConnectStateSuccess();
  factory ConnectState.loading() => ConnectStateLoading();
}

class ConnectStateNone extends ConnectState {
  ConnectStateNone() : super._();
}

class ConnectStateSuccess extends ConnectState {
  ConnectStateSuccess() : super._();
}

class ConnectStateLoading extends ConnectState {
  ConnectStateLoading() : super._();
}