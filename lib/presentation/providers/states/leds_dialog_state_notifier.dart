import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/entities/led_mode.dart';
import 'package:nao_controller/domain/usecases/leds_usecase.dart';
import 'package:nao_controller/presentation/providers/usecases/leds_usecase_provider.dart';
import 'package:nao_controller/utils/resource.dart';

final ledsDialogStateNotifier = 
  StateNotifierProvider<LedsDialogStateNotifier, LedsDialogState>((ref){
    final ledsUseCase = ref.watch(ledsUseCaseProvider);
    return LedsDialogStateNotifier(ledsUseCase);
  });

class LedsDialogStateNotifier extends StateNotifier<LedsDialogState>{
  
  final LedsUseCase _ledsUseCase;
  
  LedsDialogStateNotifier(this._ledsUseCase) : super(LedsDialogState());

  Future<void> sendLedsMode() async {
    
    state = LedsDialogState.loading(state.currentMode);
    final resource = await _ledsUseCase.call(state.currentMode);

    if(resource is ResourceSuccess){
      state = LedsDialogState.success(state.currentMode);
      return;
    }

    state = LedsDialogState.error(
      state.currentMode,
      (resource as ResourceError).message
    );
  }

  void updateMode(LedMode mode){
    state = LedsDialogState(currentMode: mode);
  }

}

class LedsDialogState{
  
  bool isLoading;
  bool hadError;
  bool sent;

  LedMode currentMode;
  String? errorMessage;
  
  LedsDialogState({
    this.sent = false,
    this.isLoading = false,
    this.hadError = false,
    this.currentMode = LedMode.rasta,
    this.errorMessage
  });

  factory LedsDialogState.success(LedMode mode) => LedsDialogState(currentMode: mode, sent: true);
  factory LedsDialogState.loading(LedMode mode) => LedsDialogState(currentMode: mode, isLoading: true);

  factory LedsDialogState.error(LedMode mode, String error) {
    return LedsDialogState(
      hadError: true, 
      errorMessage: error, 
      currentMode: mode
    );  
  }

}
