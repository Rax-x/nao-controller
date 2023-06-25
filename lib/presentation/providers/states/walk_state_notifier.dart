import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/usecases/walk_usecase.dart';
import 'package:nao_controller/presentation/providers/usecases/walk_usecase_provider.dart';
import 'package:nao_controller/utils/resource.dart';

final walkStateNotifierProvider = 
  StateNotifierProvider.autoDispose<WalkStateNotifier, WalkState>((ref){
    final walkUseCase = ref.watch(walkUseCaseProvider);
    return WalkStateNotifier(walkUseCase);
  });

class WalkStateNotifier extends StateNotifier<WalkState> {
  
  final WalkUseCase _walkUseCase;
  
  WalkStateNotifier(this._walkUseCase) : super(WalkState());
  
  Future<void> walkTo(double x, double y) async {
    state = WalkState.loading();
    final resource = await _walkUseCase.call(NaoCoordinatesParams(x, y));

    if(resource is ResourceError){
      state = WalkState.error(resource.message);
      return;
    }

    state = WalkState();
  }

}

class WalkState{
  
  final bool isLoading;
  final bool hadError;

  final String? error;
  
  WalkState({
    this.hadError = false,
    this.isLoading = false,
    this.error
  });

  factory WalkState.loading() => WalkState(isLoading: true);
  factory WalkState.error(String error) => WalkState(hadError: true, error: error);
}