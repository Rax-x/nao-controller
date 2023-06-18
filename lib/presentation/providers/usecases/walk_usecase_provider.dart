import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/usecases/walk_usecase.dart';
import 'package:nao_controller/presentation/providers/repositories/nao_actions_repository_provider.dart';

final walkUseCaseProvider = Provider<WalkUseCase>((ref){
  final repo = ref.watch(naoActionsRepositoryProvider);
  return WalkUseCase(repo);
});