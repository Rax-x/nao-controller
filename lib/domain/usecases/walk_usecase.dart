import 'package:nao_controller/domain/repositories/nao_actions_repository.dart';
import 'package:nao_controller/utils/resource.dart';
import 'package:nao_controller/utils/usecase.dart';

class WalkUseCase implements UseCase<Resource, NaoCoordinatesParams>{

  final NaoActionsRepository _repo;

  WalkUseCase(this._repo);

  @override
  Future<Resource> call(NaoCoordinatesParams params) async {
    final NaoCoordinatesParams(:x, :y) = params;
    return _repo.walk(x, y);
  }
}

class NaoCoordinatesParams {
  final double x;
  final double y;

  NaoCoordinatesParams(this.x, this.y);
}