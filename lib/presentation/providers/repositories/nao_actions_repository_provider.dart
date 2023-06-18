import 'package:nao_controller/data/repositories/nao_actions_repository_impl.dart';
import 'package:nao_controller/domain/repositories/nao_actions_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/presentation/providers/services/nao_service_provider.dart';

final naoActionsRepositoryProvider = Provider<NaoActionsRepository>((ref) {
  final service = ref.watch(naoServicePtovider);
  return NaoActionsRepositoryImpl(service);
});