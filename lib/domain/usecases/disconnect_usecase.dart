import 'package:nao_controller/configs.dart';
import 'package:nao_controller/utils/usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisconnectUseCase extends UseCase<void, UseCaseNoParams>{

  final SharedPreferences _preferences;

  DisconnectUseCase(this._preferences);

  @override
  Future<void> call(UseCaseNoParams params) async {
    if(_preferences.containsKey(naoIpAddressKey)){
      _preferences.remove(naoIpAddressKey);
    }
  }

}