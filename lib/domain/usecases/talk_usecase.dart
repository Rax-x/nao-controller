import 'package:nao_controller/domain/repositories/nao_actions_repository.dart';
import 'package:nao_controller/utils/resource.dart';
import 'package:nao_controller/utils/usecase.dart';

class TalkUseCase implements UseCase<Resource, String>{

  final NaoActionsRepository _repo;

  TalkUseCase(this._repo);

  @override
  Future<Resource> call(String message) async {
    return _repo.talk(message);
  }
}