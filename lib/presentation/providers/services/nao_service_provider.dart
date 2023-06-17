import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/data/datasources/remote/nao_service.dart';

final naoServicePtovider = Provider.family<NaoService, String>((ref, url){
  return NaoService(url);
});