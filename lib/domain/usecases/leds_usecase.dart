import 'package:nao_controller/domain/entities/led_event.dart';
import 'package:nao_controller/domain/repositories/nao_actions_repository.dart';
import 'package:nao_controller/utils/resource.dart';
import 'package:nao_controller/utils/usecase.dart';

class LedsUseCase implements UseCase<Resource, LedEvent>{

  final NaoActionsRepository _repo;

  LedsUseCase(this._repo);

  @override
  Future<Resource> call(LedEvent event) async {
    
    switch(event){
      case LedEvent.onEvent:
        return await _repo.ledOn();
      case LedEvent.offEvent:
        return await _repo.ledOff();
      case LedEvent.randomEyesEvent:
        return await _repo.ledRandomEyes();
      case LedEvent.rastaEvent:
        return await _repo.ledRasta();
      case LedEvent.resetEvent:
        return await _repo.ledReset();
      default:
        break;
    }

    return Resource.error(
      "Unable to use leds!", 
      -1
    );

  }
}