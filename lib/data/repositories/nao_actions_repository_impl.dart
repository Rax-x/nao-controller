import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nao_controller/data/datasources/remote/nao_service.dart';
import 'package:nao_controller/data/models/nao_change_led_color_event_type.dart';
import 'package:nao_controller/domain/repositories/nao_actions_repository.dart';
import 'package:nao_controller/utils/resource.dart';


class NaoActionsRepositoryImpl implements NaoActionsRepository {

  final NaoService _service;
  final _errorMessage = "An Error occurred! Check your internet connection!";

  final _okStatusCode = 200;

  NaoActionsRepositoryImpl(this._service);

  Resource _handleError(DioException dioException){

    return Resource.error(
      dioException.type == DioExceptionType.unknown 
        ? dioException.error.toString()
        : dioException.message!
    );

  }

  Resource _successIfOkOtherwiseError(Response response){
    return response.statusCode != _okStatusCode
      ? Resource.error(_errorMessage) 
      : Resource.success();
  }

  @override
  Future<Resource> getBatteryInfo() async {

    Response response;

    try{
      response = await _service.getBatteryInfo();
    } on DioException catch (e){
      return _handleError(e);
    }

    if(response.statusCode != _okStatusCode || 
        response.headers[HttpHeaders.contentLengthHeader] == null){
      
      return Resource.error(
        _errorMessage);
    }

    return Resource.success(
      jsonDecode(response.data as String)
    );
  }

  @override
  Future<Resource> ledOff() async {
    Response response;

    try{
      response = await _service
        .changeLedColor(NaoChangeLedColorEventType.off);  
    } on DioException catch(e){
      return _handleError(e);
    }
    
    return _successIfOkOtherwiseError(response);
  }

  @override
  Future<Resource> ledOn() async {
    Response response;
    
    try{
      response = await _service
        .changeLedColor(NaoChangeLedColorEventType.on);
    } on DioException catch(e){
      return _handleError(e);
    }
    return _successIfOkOtherwiseError(response);
  }

  @override
  Future<Resource> ledRandomEyes() async {
    Response response;
    
    try{
      response = await _service
        .changeLedColor(NaoChangeLedColorEventType.randomEyes);
    } on DioException catch(e){
      return _handleError(e);
    }

    return _successIfOkOtherwiseError(response);
  }

  @override
  Future<Resource> ledRasta() async {
    Response response;

    try{
      response = await _service
        .changeLedColor(NaoChangeLedColorEventType.rasta);
    } on DioException catch(e){
      return _handleError(e);
    }
    return _successIfOkOtherwiseError(response);
  }

  @override
  Future<Resource> ledReset() async {
    Response response;

    try{
      response = await _service
        .changeLedColor(NaoChangeLedColorEventType.reset);
    } on DioException catch(e){
      return _handleError(e);
    }
    return _successIfOkOtherwiseError(response);
  }

  @override
  Future<Resource> talk(String message) async {
    Response response;

    try{
      response = await _service.speechText(message);
    } on DioException catch(e){
      return _handleError(e);
    }
    return _successIfOkOtherwiseError(response);
  }

  @override
  Future<Resource> walk(Map<String, double> coordinates) async {
    Response response;

    try{
      response = await _service.walk(coordinates);
    } on DioException catch(e){
      return _handleError(e);
    }
    return _successIfOkOtherwiseError(response);
  }

  @override
  Future<Resource> closeServer() async {
    Response response;

    try{
      response = await _service.closeServer();
    } on DioException catch(e){
      return _handleError(e);
    }
    return _successIfOkOtherwiseError(response);
  }

  @override
  Future<Resource> pingServer() async {
    Response response;

    try{ 
      response = await _service.pingServer();
    } on DioException catch(e){
      return _handleError(e);
    }

    return _successIfOkOtherwiseError(response);
  }
}