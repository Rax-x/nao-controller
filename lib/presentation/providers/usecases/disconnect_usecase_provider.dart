import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/usecases/disconnect_usecase.dart';
import 'package:nao_controller/presentation/providers/shared_preferences_provider.dart';

final disconnectUseCaseProvider = Provider<DisconnectUseCase>((ref){
  final preferences = ref.watch(sharedPreferencesProvider);
  return DisconnectUseCase(preferences);
});