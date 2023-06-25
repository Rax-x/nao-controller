import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/usecases/close_server_usecase.dart';
import 'package:nao_controller/domain/usecases/disconnect_usecase.dart';
import 'package:nao_controller/domain/usecases/ping_server_usecase.dart';
import 'package:nao_controller/presentation/providers/usecases/close_server_usecase_provider.dart';
import 'package:nao_controller/presentation/providers/usecases/disconnect_usecase_provider.dart';
import 'package:nao_controller/presentation/providers/usecases/ping_server_usecase_provider.dart';
import 'package:nao_controller/utils/resource.dart';
import 'package:nao_controller/utils/usecase.dart';

final homeStateNotifierProvider = 
  StateNotifierProvider.autoDispose<HomeStateNotifier, HomeState>((ref){
    final pingUseCase = ref.watch(pingServerUseCaseProvider);
    final closeServerUseCase = ref.watch(closeServerProvider);
    final disconnectUseCase = ref.watch(disconnectUseCaseProvider);

    return HomeStateNotifier(
      pingUseCase: pingUseCase,
      closeServerUseCase: closeServerUseCase,
      disconnectUseCase: disconnectUseCase 
    );
  });


class HomeStateNotifier extends StateNotifier<HomeState>{
  
  final DisconnectUseCase disconnectUseCase;
  final CloseServerUseCase closeServerUseCase;

  HomeStateNotifier({
    required PingServerUseCase pingUseCase,
    required this.disconnectUseCase,
    required this.closeServerUseCase
  }) : super(HomeState.loading()) {

    pingUseCase.call(UseCaseNoParams()).then((res){
      state = res is ResourceSuccess
        ? HomeState()
        : HomeState.error((res as ResourceError).message);
    }).catchError((err){
      state = HomeState.error(err.toString());
    });

  }

  Future<void> shutdownServer() async {
    state = HomeState.loading();
    disconnectUseCase.call(UseCaseNoParams());
    closeServerUseCase.call(UseCaseNoParams());
    state = HomeState();
  }

  Future<void> disconnect() async {
    state = HomeState.loading();
    disconnectUseCase.call(UseCaseNoParams());
    state = HomeState();
  }

}

class HomeState {

  final bool isLoading;
  final bool hadError;

  final String? error;

  HomeState({
    this.hadError = false,
    this.isLoading = false,
    this.error
  });

  factory HomeState.loading() => HomeState(isLoading: true);
  factory HomeState.error(String error) => HomeState(hadError: true, error: error);
}