import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:xml_test/data/models/conf_sensor.dart';

abstract class ConfParseState extends Equatable {
  List<ConfSensor> sensorsList = [];

  ConfParseState({this.sensorsList});

  @override
  List<Object> get props => [];
}

class InitState extends ConfParseState {}

class ErrorLoad extends ConfParseState {}

class SensorsLoaded extends ConfParseState {
  SensorsLoaded({@required List<ConfSensor> sensors})
      : super(sensorsList: sensors);
}
