import 'package:nao_controller/domain/repositories/nao_actions_repository.dart';
import 'package:nao_controller/utils/resource.dart';
import 'package:nao_controller/utils/usecase.dart';

class BatteryInfoUseCase implements UseCase<Resource, NaoCoordinatesParams>{

  final NaoActionsRepository _repo;

  BatteryInfoUseCase(this._repo);

  @override
  Future<Resource> call(NaoCoordinatesParams params) async {
    return await _repo.walk({
      "x": params.x,
      "y": params.y
    });
  }
}

class NaoCoordinatesParams {
  final double x;
  final double y;

  NaoCoordinatesParams(this.x, this.y);
}