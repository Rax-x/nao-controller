import 'package:nao_controller/domain/repositories/nao_actions_repository.dart';
import 'package:nao_controller/utils/resource.dart';
import 'package:nao_controller/utils/usecase.dart';

class PingServerUseCase extends UseCase<Resource, UseCaseNoParams>{
  
  final NaoActionsRepository _repo;

  PingServerUseCase(this._repo);
  
  @override
  Future<Resource> call(UseCaseNoParams params) async {
    return await _repo.pingServer();
  }
}