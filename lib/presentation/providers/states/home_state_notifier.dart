import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/usecases/battery_info_usecase.dart';
import 'package:nao_controller/domain/usecases/ping_server_usecase.dart';
import 'package:nao_controller/presentation/providers/usecases/battery_info_usecase_provider.dart';
import 'package:nao_controller/presentation/providers/usecases/ping_server_usecase_provider.dart';
import 'package:nao_controller/utils/resource.dart';
import 'package:nao_controller/utils/usecase.dart';

final homeStateNotifierProvider = 
  StateNotifierProvider<HomeStateNotifier, HomeState>((ref){
    final pingUseCase = ref.watch(pingServerUseCaseProvider);
    final batteryInfoUseCase = ref.watch(batteryInfoUseCaseProvider);

    return HomeStateNotifier(
      pingUseCase: pingUseCase,
      batteryUseCase: batteryInfoUseCase 
    );
  });


class HomeStateNotifier extends StateNotifier<HomeState>{
  
  final BatteryInfoUseCase batteryUseCase;
  
  HomeStateNotifier({
    required PingServerUseCase pingUseCase,
    required this.batteryUseCase,
  }) : super(HomeState.loading()) {
    pingUseCase.call(UseCaseNoParams()).then((res){
      state = res is ResourceSuccess
        ? HomeState.none()
        : HomeState.error(
          (res as ResourceError).message,
          shoudReturnToConnectScreen: true
        );
    }).catchError((_){
      state = HomeState.error(
        "An Error occurred!", 
        shoudReturnToConnectScreen: true
      );
    });
  }

  Future<String> getBatteryInfo() async {
    state = HomeState.loading();
    final resource = await batteryUseCase.call(UseCaseNoParams());

    if(resource is ResourceError){
      state = HomeState.error(resource.message);
      return "Error!";
    }

    final batteryFormatted = 
      "${(resource as ResourceSuccess).data!['battery_info']}%";

    return batteryFormatted;
  }

}

sealed class HomeState {
  HomeState._();

  factory HomeState.none() => HomeStateNone();
  factory HomeState.success() => HomeStateSuccess();
  factory HomeState.loading() => HomeStateLoading();
  factory HomeState.error(
    String error, 
    {bool shoudReturnToConnectScreen = false}
  ){
    return HomeStateError(
      error, 
      shoudReturnToConnectScreen: shoudReturnToConnectScreen
    );
  }
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
  final bool shoudReturnToConnectScreen;
  HomeStateError(this.error, {this.shoudReturnToConnectScreen = false}) : super._();
}