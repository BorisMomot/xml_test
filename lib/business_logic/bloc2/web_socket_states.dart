import 'package:xml_test/data/models/uniset_sensor.dart';
import 'package:equatable/equatable.dart';

abstract class WebSocketState extends Equatable {
  static const String StateName = '';

  @override
  List<Object> get props => [];
}

// Web socket не подключен
class WebSocketUnconnected extends WebSocketState {
  static const String StateName = 'Websocket disconnected';
}

// Получена порция дитчиков
class WebSocketNewSensorsRecieved extends WebSocketState {
  static const String StateName = 'Websocket recieved sensors';
  final List<USensor> usensors;

  WebSocketNewSensorsRecieved({this.usensors});
}

// Получена ошибка соединения
class WebSocketError extends WebSocketState {
  static const String StateName = 'Websocket error';
  final String error;

  WebSocketError({this.error});
}
