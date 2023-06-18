import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/usecases/talk_usecase.dart';
import 'package:nao_controller/presentation/providers/repositories/nao_actions_repository_provider.dart';

final talkUseCaseProvider = Provider<TalkUseCase>((ref){
  final repo = ref.watch(naoActionsRepositoryProvider);
  return TalkUseCase(repo);
});