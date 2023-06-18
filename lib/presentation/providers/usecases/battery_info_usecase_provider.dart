import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/usecases/battery_info_usecase.dart';
import 'package:nao_controller/presentation/providers/repositories/nao_actions_repository_provider.dart';

final batteryInfoUseCaseProvider = Provider<BatteryInfoUseCase>((ref){
  final repo = ref.watch(naoActionsRepositoryProvider);
  return BatteryInfoUseCase(repo);
});