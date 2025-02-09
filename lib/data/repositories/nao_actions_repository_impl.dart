import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nao_controller/data/datasources/remote/nao_service.dart';
import 'package:nao_controller/data/models/nao_change_led_color_event_type.dart';
import 'package:nao_controller/domain/repositories/nao_actions_repository.dart';
import 'package:nao_controller/utils/resource.dart';

class NaoActionsRepositoryImpl implements NaoActionsRepository {

  final NaoService _service;

  NaoActionsRepositoryImpl(this._service);

  Resource _handleError(DioException dioException){

    return Resource.error(
      dioException.type == DioExceptionType.unknown 
        ? dioException.error.toString()
        : dioException.message!
    );

  }

  Resource _successIfOkOtherwiseError(Response response){
    return response.statusCode != HttpStatus.ok
      ? Resource.error("An error occurred, try to check your internet connection.") 
      : Resource.success();
  }

  @override
  Future<Resource> getBatteryInfo() async {
    try{
      final response = await _service.getBatteryInfo();

      if(response.statusCode != HttpStatus.ok || 
          response.headers[HttpHeaders.contentLengthHeader] == null){
        
        return Resource.error("NAO battery level retrieval failed.");
      }

      return Resource.success(
        jsonDecode(response.data as String)
      );

    } on DioException catch (e){
      return _handleError(e);
    }
  }

  Future<Resource> _sendLedEvent(NaoChangeLedColorEventType event) async {

    try{
      Response response = await _service.changeLedColor(event);
      return _successIfOkOtherwiseError(response); 
    } on DioException catch(e){
      return _handleError(e);
    }
  }

  @override
  Future<Resource> ledOff() async {
    return _sendLedEvent(NaoChangeLedColorEventType.off);  
  }

  @override
  Future<Resource> ledOn() async {
    return _sendLedEvent(NaoChangeLedColorEventType.on);
  }

  @override
  Future<Resource> ledRandomEyes() async {
    return _sendLedEvent(NaoChangeLedColorEventType.randomEyes);
  }

  @override
  Future<Resource> ledRasta() async {
    return _sendLedEvent(NaoChangeLedColorEventType.rasta);
  }

  @override
  Future<Resource> ledReset() async {
    return _sendLedEvent(NaoChangeLedColorEventType.reset);
  }

  @override
  Future<Resource> talk(String message) async {
    
    try{
      final response = await _service.speechText(message);
      return _successIfOkOtherwiseError(response);
    } on DioException catch(e){
      return _handleError(e);
    }
  }

  @override
  Future<Resource> walk(double x, double y) async {
    try{
      final response = await _service.walk(x, y);
      return _successIfOkOtherwiseError(response);
    } on DioException catch(e){
      return _handleError(e);
    }
  }

  @override
  Future<Resource> closeServer() async {
    try{
      final response = await _service.closeServer();
      return _successIfOkOtherwiseError(response);
    } on DioException catch(e){
      return _handleError(e);
    }
  }

  @override
  Future<Resource> pingServer() async {
    try{ 
      final response = await _service.pingServer();
      return _successIfOkOtherwiseError(response);
    } on DioException catch(e){
      return _handleError(e);
    }
  }
}