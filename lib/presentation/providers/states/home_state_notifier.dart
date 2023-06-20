import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeStateNotifier extends StateNotifier<HomeState>{
  
  
  HomeStateNotifier() : super(HomeState.loading()) {
    // ping server
    // if return error come back to connect screen
  }

}

sealed class HomeState {
  HomeState._();

  factory HomeState.none() => HomeStateNone();
  factory HomeState.success() => HomeStateSuccess();
  factory HomeState.loading() => HomeStateLoading();
  factory HomeState.error(String error) => HomeStateError(error);
}

class HomeStateNone extends HomeState{
  HomeStateNone() : super._();
}

class HomeStateSuccess extends HomeState{
  HomeStateSuccess() : super._();
}

class HomeStateLoading extends HomeState{
  HomeStateLoading() : super._();
}

class HomeStateError extends HomeState{
  final String error;
  HomeStateError(this.error) : super._();
}