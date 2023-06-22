import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/usecases/ping_server_usecase.dart';
import 'package:nao_controller/presentation/providers/repositories/nao_actions_repository_provider.dart';

final pingServerUseCaseProvider = Provider<PingServerUseCase>((ref){
  final repo = ref.watch(naoActionsRepositoryProvider);
  return PingServerUseCase(repo);
});