import 'dart:async';
import 'package:xml_test/data/models/uniset_sensor.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class USensorsProvider {
  String _askSensors = '';
  String _address = '';
  String _port = '';
  String _endpoint = '';

  var _websocket;

  USensorsProvider() {}

  // Getters
  Stream get websocket => _websocket.stream;
  String get endpoint => _endpoint;
  String get port => _port;
  String get address => _address;
  String get askSensors => _askSensors;

  // Заказ дополнительных датчиков
  void askExtraSensors(String sensors) {
    _websocket.sink.add('ask:$sensors');
  }

  // Запись значения в датчик
  void setSensorsValue(String sensor, int value) {
    _websocket.sink.add('set:$sensor=$value');
  }

  void initConnection({String askSensors, String address, String port, String endpoint}){
    _askSensors = askSensors;
    _address = address;
    _port = port;
    _endpoint = endpoint;
    _websocket = IOWebSocketChannel.connect(
        Uri.parse('ws://${_address}:${_port}${_endpoint}/?${askSensors}'));
    // print('ws://${_address}:${_port}${_endpoint}/?${askSensors}');
  }
  // Переподключиться
  void restartConnection() async {
    await _websocket.close();
    _websocket = IOWebSocketChannel.connect(
        Uri.parse('ws://${_address}:${_port}${_endpoint}/?${askSensors}'));
  }

  // Подключиться с другими параметрами
  void recrateConnection(
      {String askSensors, String address, String port, String endpoint}) async {
    await _websocket.close();
    initConnection(askSensors: askSensors, address: address, port: port, endpoint: endpoint);
  }

  // Отключить обмен
  void closeConnection() async {
    await _websocket.close();
  }
}
