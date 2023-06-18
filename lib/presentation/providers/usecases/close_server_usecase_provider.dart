import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/usecases/close_server_usecase.dart';
import 'package:nao_controller/presentation/providers/repositories/nao_actions_repository_provider.dart';

final closeServerProvider = Provider<CloseServerUseCase>((ref){
  final repo = ref.watch(naoActionsRepositoryProvider);
  return CloseServerUseCase(repo);
});