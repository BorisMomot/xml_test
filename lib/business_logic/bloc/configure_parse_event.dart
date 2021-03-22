import 'package:flutter/material.dart';
import 'package:xml_test/data/models/conf_sensor.dart';
import 'package:equatable/equatable.dart';

abstract class ConfParseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Получен запрос на парсинг configure
class ParseConfigure extends ConfParseEvent {}

// Получены новые данные о настройках датчиков
class ChangeConfigureParam extends ConfParseEvent {
  final String pathToConfigure;
  final bool takeAllSensors;
  final int amountOfSensors;

  ChangeConfigureParam(
      {@required this.pathToConfigure,
      @required this.takeAllSensors,
      @required this.amountOfSensors});
}

// Считаны датчики с configure
class SensorsFromConfigure extends ConfParseEvent {
  final List<ConfSensor> sensors;

  SensorsFromConfigure({@required this.sensors});
}
