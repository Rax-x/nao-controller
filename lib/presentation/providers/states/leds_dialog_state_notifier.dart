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

  Future<void> sendLedsMode(LedMode mode) async {
    
    state = LedsDialogState.loading();
    final resource = await _ledsUseCase.call(mode);

    if(resource is ResourceSuccess){
      state = LedsDialogState.success();
      return;
    }

    state = LedsDialogState.error((resource as ResourceError).message);
  }
  
}

class LedsDialogState{
  
  final bool isLoading;
  final bool hadError;
  final bool isSent;
 
  final String? error;
  
  LedsDialogState({
    this.isSent = false,
    this.isLoading = false,
    this.hadError = false,
    this.error
  });

  factory LedsDialogState.success() => LedsDialogState(isSent: true);
  factory LedsDialogState.loading() => LedsDialogState(isLoading: true);
  factory LedsDialogState.error(String error) => LedsDialogState(hadError: true);  

}
