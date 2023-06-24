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
  
  bool isLoading;
  bool hadError;
  bool sent;

  String? errorMessage;
  
  TalkDialogState({
    this.sent = false,
    this.isLoading = false,
    this.hadError = false,
    this.errorMessage
  });

  factory TalkDialogState.success() => TalkDialogState(sent: true);
  factory TalkDialogState.loading() => TalkDialogState(isLoading: true);

  factory TalkDialogState.error(String error) {
    return TalkDialogState(
      hadError: true, 
      errorMessage: error, 
    );  
  }

}