import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/usecases/walk_usecase.dart';
import 'package:nao_controller/presentation/providers/usecases/walk_usecase_provider.dart';
import 'package:nao_controller/utils/resource.dart';

final walkStateNotifierProvider = 
  StateNotifierProvider<WalkStateNotifier, WalkState>((ref){
    final walkUseCase = ref.watch(walkUseCaseProvider);
    return WalkStateNotifier(walkUseCase);
  });

class WalkStateNotifier extends StateNotifier<WalkState> {
  
  final WalkUseCase _walkUseCase;
  
  WalkStateNotifier(this._walkUseCase) : super(WalkState.none());
  
  Future<void> walkTo(double x, double y) async {
    state = WalkState.loading();
    final resource = await _walkUseCase.call(NaoCoordinatesParams(x, y));

    if(resource is ResourceError){
      state = WalkState.error(resource.message);
      return;
    }

    state = WalkState.success();
  }

}

sealed class WalkState{
  WalkState._();

  factory WalkState.none() => WalkStateNone();
  factory WalkState.success() => WalkStateSuccess();
  factory WalkState.loading() => WalkStateLoading();
  factory WalkState.error(String error) => WalkStateError(error);
}


class WalkStateNone extends WalkState{
  WalkStateNone() : super._();
}

class WalkStateSuccess extends WalkState{
  WalkStateSuccess() : super._();
}

class WalkStateLoading extends WalkState{
  WalkStateLoading() : super._();
}

class WalkStateError extends WalkState{
  final String message;
  WalkStateError(this.message) : super._();
}