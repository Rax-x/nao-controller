import 'dart:convert';

import 'package:nao_controller/data/datasources/remote/nao_service.dart';
import 'package:nao_controller/data/models/nao_change_led_color_event_type.dart';
import 'package:nao_controller/domain/repositories/nao_actions_repository.dart';
import 'package:nao_controller/utils/resource.dart';

import 'package:http/http.dart';

// TODO: Improve error messages

class NaoActionsRepositoryImpl implements NaoActionsRepository {

  final NaoService _service;
  final _errorMessage = "An Error occurred! Check your internet connection!";

  final _okStatusCode = 200;

  NaoActionsRepositoryImpl(this._service);

  Resource _successIfOKOtherwiseError(Response response){
    return response.statusCode != _okStatusCode
      ? Resource.error(_errorMessage, response.statusCode) 
      : Resource.success();
  }

  @override
  Future<Resource> getBatteryInfo() async {
    final response = await _service.getBatteryInfo();

    if(response.statusCode != _okStatusCode || response.contentLength == 0){
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

    return _successIfOKOtherwiseError(response);
  }

  @override
  Future<Resource> ledOn() async {
    final response = await _service
      .changeLedColor(NaoChangeLedColorEventType.on);

    return _successIfOKOtherwiseError(response);
  }

  @override
  Future<Resource> ledRandomEyes() async {
    final response = await _service
      .changeLedColor(NaoChangeLedColorEventType.randomEyes);

    return _successIfOKOtherwiseError(response);
  }

  @override
  Future<Resource> ledRasta() async {
    final response = await _service
      .changeLedColor(NaoChangeLedColorEventType.rasta);

    return _successIfOKOtherwiseError(response);
  }

  @override
  Future<Resource> ledReset() async {
    final response = await _service
      .changeLedColor(NaoChangeLedColorEventType.reset);

    return _successIfOKOtherwiseError(response);
  }

  @override
  Future<Resource> talk(String message) async {
    final response = await _service.speechText(message);

    return _successIfOKOtherwiseError(response);
  }

  @override
  Future<Resource> walk(Map<String, double> coordinates) async {
    final response = await _service.walk(coordinates);

    return _successIfOKOtherwiseError(response);
  }

  @override
  Future<Resource> closeServer() async {
    final response = await _service.closeServer();

    return _successIfOKOtherwiseError(response);
  }

  @override
  Future<Resource> pingServer() async {
    final response = await _service.pingServer();

    return _successIfOKOtherwiseError(response);
  }
}