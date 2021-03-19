import 'package:flutter/cupertino.dart';
import 'package:xml_test/data/models/uniset_sensor.dart';
import 'package:equatable/equatable.dart';

abstract class AbstractWSState extends Equatable {
  List<USensor> sensors = [];
  @override
  List<Object> get props => [];
}

class InitStateWS extends AbstractWSState {}

class WaitingStateWS extends AbstractWSState {}

class ErrorStateWS extends AbstractWSState {}

class NewSensorsReceivedWSState extends AbstractWSState {
  NewSensorsReceivedWSState({@required List<USensor> sens}) {
    sensors = sens;
  }
}
