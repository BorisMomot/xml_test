import 'package:xml_test/data/models/uniset_sensor.dart';
import 'package:equatable/equatable.dart';

abstract class WebSocketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Установить параметры соединения
class SetConnectionsSettings extends WebSocketEvent {
  final String addrress;
  final int port;
  final String endpoint;
  SetConnectionsSettings({this.addrress, this.port, this.endpoint});
}

// Подключиться к websopcket-у
class Connect extends WebSocketEvent {}

// Отключиться от websopcket-а
class Disconnect extends WebSocketEvent {}

// Получены следующие датчики
class GetSensors extends WebSocketEvent {
  final List<USensor> usensors;
  GetSensors({this.usensors});
}

// Получена ошибка соединения
class ConnectionError extends WebSocketEvent {
  final String error;
  ConnectionError({this.error});
}
