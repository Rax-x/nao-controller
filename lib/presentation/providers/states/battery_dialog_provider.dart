import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/presentation/providers/usecases/battery_info_usecase_provider.dart';
import 'package:nao_controller/utils/resource.dart';
import 'package:nao_controller/utils/usecase.dart';

final batteryDialogProvider = FutureProvider<BatteryDialogState>((ref) async {
  final batteryUseCase = ref.watch(batteryInfoUseCaseProvider);
  final resource = await batteryUseCase.call(UseCaseNoParams());

  if(resource is ResourceError){
    return BatteryDialogStateError(resource.message);
  }

  return BatteryDialogStateSuccess(
    (resource as ResourceSuccess).data?['battery_info'] ?? "N/A"
  );
});

sealed class BatteryDialogState{
  BatteryDialogState._();
}

class BatteryDialogStateSuccess extends BatteryDialogState{
  final String batteryLevel;
  BatteryDialogStateSuccess(this.batteryLevel) : super._();
}

class BatteryDialogStateError extends BatteryDialogState{
  final String message;
  BatteryDialogStateError(this.message) : super._();
}
