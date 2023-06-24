import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:nao_controller/data/models/nao_change_led_color_event_type.dart';
import 'package:nao_controller/data/models/nao_event.dart';


class NaoService {

  final String _url;

  NaoService(this._url);

  Future<http.Response> _sendPostRequest(Map<String, Object> obj) async {

    final body = jsonEncode(obj);

    return http.post(
      Uri.parse(_url),
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': body.length.toString()
      },
      body: body
    );
  }

  Future<http.Response> speechText(String message) async {
    return _sendPostRequest({
      'type': NaoEvent.talk.index,
      'payload': message
    });
  } 

  Future<http.Response> walk(Map<String, double> coordinates) async {  
    return _sendPostRequest({
      'type': NaoEvent.walk.index,
      'payload': coordinates
    });
  } 

  Future<http.Response> changeLedColor(NaoChangeLedColorEventType type) async {
    return _sendPostRequest({
      'type': NaoEvent.changeLedColor.index,
      'payload': type.index
    });
  } 

  Future<http.Response> getBatteryInfo() async {
    return _sendPostRequest({
      'type': NaoEvent.batteryInfo.index
    });
  }

  Future<http.Response> closeServer() async {
    return _sendPostRequest({
      'type': NaoEvent.closeServer.index
    });
  }

  Future<http.Response> pingServer() async {
    return _sendPostRequest({
      'type': NaoEvent.ping.index
    });
  }
}