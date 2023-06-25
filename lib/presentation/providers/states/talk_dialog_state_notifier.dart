import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/usecases/talk_usecase.dart';
import 'package:nao_controller/presentation/providers/usecases/talk_usecase_provider.dart';
import 'package:nao_controller/utils/resource.dart';

final talkDialogStateNotifier = 
  StateNotifierProvider<TalkDialogStateNotifier, TalkDialogState>((ref){
    final talkUseCase = ref.watch(talkUseCaseProvider);
    return TalkDialogStateNotifier(talkUseCase);
  });

class TalkDialogStateNotifier extends StateNotifier<TalkDialogState>{
  
  final TalkUseCase _talkUseCase;
  
  TalkDialogStateNotifier(this._talkUseCase) : super(TalkDialogState());

  Future<void> sendText(String text) async {
    
    state = TalkDialogState.loading();
    final resource = await _talkUseCase.call(text);

    if(resource is ResourceSuccess){
      state = TalkDialogState.success();
      return;
    }

    state = TalkDialogState.error(
      (resource as ResourceError).message
    );
  }

}

class TalkDialogState{
  
  final bool isLoading;
  final bool hadError;
  final bool isSent;

  final String? error;
  
  TalkDialogState({
    this.isSent = false,
    this.isLoading = false,
    this.hadError = false,
    this.error
  });

  factory TalkDialogState.success() => TalkDialogState(isSent: true);
  factory TalkDialogState.loading() => TalkDialogState(isLoading: true);

  factory TalkDialogState.error(String error) {
    return TalkDialogState(
      hadError: true, 
      error: error, 
    );  
  }

}