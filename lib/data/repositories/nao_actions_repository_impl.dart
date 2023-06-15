import 'dart:convert';

import 'package:nao_controller/data/datasources/remote/nao_service.dart';
import 'package:nao_controller/data/models/nao_change_led_color_event_type.dart';
import 'package:nao_controller/domain/repositories/nao_actions_repository.dart';
import 'package:nao_controller/utils/resource.dart';

// TODO: Improve error messages

class NaoActionsRepositoryImpl implements NaoActionsRepository {

  final NaoService _service;
  final _errorMessage = "An Error occurred! Check your internet connection!";

  NaoActionsRepositoryImpl(this._service);

  @override
  Future<Resource> getBatteryInfo() async {
    final response = await _service.getBatteryInfo();

    if(response.statusCode != 200 || response.contentLength == 0){
      return Resource.error(
        _errorMessage,
        response.statusCode
      );
    }

    return Resource.success(
      jsonDecode(response.body)
    );
  }

  @override
  Future<Resource> ledOff() async {
    final response = await _service
      .changeLedColor(NaoChangeLedColorEventType.off);

    return response.statusCode != 200
      ? Resource.error(_errorMessage, response.statusCode) 
      : Resource.success();
  }

  @override
  Future<Resource> ledOn() async {
    final response = await _service
      .changeLedColor(NaoChangeLedColorEventType.on);

    return response.statusCode != 200
      ? Resource.error(_errorMessage, response.statusCode) 
      : Resource.success();
  }

  @override
  Future<Resource> ledRandomEyes() async {
    final response = await _service
      .changeLedColor(NaoChangeLedColorEventType.randomEyes);

    return response.statusCode != 200
      ? Resource.error(_errorMessage, response.statusCode) 
      : Resource.success();
  }

  @override
  Future<Resource> ledRasta() async {
    final response = await _service
      .changeLedColor(NaoChangeLedColorEventType.rasta);

    return response.statusCode != 200
      ? Resource.error(_errorMessage, response.statusCode) 
      : Resource.success();
  }

  @override
  Future<Resource> ledReset() async {
    final response = await _service
      .changeLedColor(NaoChangeLedColorEventType.reset);

    return response.statusCode != 200
      ? Resource.error(_errorMessage, response.statusCode) 
      : Resource.success();
  }

  @override
  Future<Resource> talk(String message) async {
    final response = await _service.speechText(message);

    return response.statusCode != 200
      ? Resource.error(_errorMessage, response.statusCode) 
      : Resource.success();
  }

  @override
  Future<Resource> walk(Map<String, double> coordinates) async {
    final response = await _service.walk(coordinates);

    return response.statusCode != 200
      ? Resource.error(_errorMessage, response.statusCode) 
      : Resource.success();
  }

  @override
  Future<Resource> closeServer() async {
    final response = await _service.closeServer();

    return response.statusCode != 200
      ? Resource.error(_errorMessage, response.statusCode) 
      : Resource.success();
  }
}