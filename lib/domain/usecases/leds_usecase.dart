import 'package:nao_controller/domain/entities/led_mode.dart';
import 'package:nao_controller/domain/repositories/nao_actions_repository.dart';
import 'package:nao_controller/utils/resource.dart';
import 'package:nao_controller/utils/usecase.dart';

class LedsUseCase implements UseCase<Resource, LedMode>{

  final NaoActionsRepository _repo;

  LedsUseCase(this._repo);

  @override
  Future<Resource> call(LedMode mode) async {
    
    switch(mode){
      case LedMode.on:
        return _repo.ledOn();
      case LedMode.off:
        return _repo.ledOff();
      case LedMode.randomEyes:
        return _repo.ledRandomEyes();
      case LedMode.rasta:
        return _repo.ledRasta();
      case LedMode.reset:
        return _repo.ledReset();
      default:
        break;
    }

    // TODO: refactor this
    return Resource.error(
      "Unable to use leds!", 
      -1
    );

  }
}