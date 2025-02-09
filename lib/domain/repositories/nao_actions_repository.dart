import 'package:nao_controller/utils/resource.dart';

abstract class NaoActionsRepository {

  Future<Resource> talk(String message);
  Future<Resource> walk(double x, double y);

  Future<Resource> getBatteryInfo();

  Future<Resource> ledOff(); 
  Future<Resource> ledOn(); 
  Future<Resource> ledReset(); 
  Future<Resource> ledRandomEyes(); 
  Future<Resource> ledRasta();

  Future<Resource> closeServer();  
  Future<Resource> pingServer();
}