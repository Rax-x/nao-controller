import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:nao_controller/data/models/nao_change_led_color_event_type.dart';
import 'package:nao_controller/data/models/nao_event.dart';


class NaoService {

  final String _url;
  final Dio _client;

  NaoService(this._client, this._url);

  Future<Response> _sendPostRequest(Map<String, Object> obj) async {

    final body = jsonEncode(obj);

    return _client.post(
      _url,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.contentLengthHeader: body.length.toString()
        }
      ),
      data: body
    );
  }

  Future<Response> speechText(String message) async {
    return _sendPostRequest({
      'type': NaoEvent.talk.index,
      'payload': message
    });
  } 

  Future<Response> walk(double x, double y) async {  
    return _sendPostRequest({
      'type': NaoEvent.walk.index,
      'payload': {
        'x': x,
        'y': y
      }
    });
  } 

  Future<Response> changeLedColor(NaoChangeLedColorEventType type) async {
    return _sendPostRequest({
      'type': NaoEvent.changeLedColor.index,
      'payload': type.index
    });
  } 

  Future<Response> getBatteryInfo() async {
    return _sendPostRequest({
      'type': NaoEvent.batteryInfo.index
    });
  }

  Future<Response> closeServer() async {
    return _sendPostRequest({
      'type': NaoEvent.closeServer.index
    });
  }

  Future<Response> pingServer() async {
    return _sendPostRequest({
      'type': NaoEvent.ping.index
    });
  }
}