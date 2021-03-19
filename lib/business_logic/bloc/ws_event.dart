import 'package:xml_test/data/models/uniset_sensor.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AbstractWSEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SetParams extends AbstractWSEvent {
  final String askSensors;
  final String address;
  final String port;
  final String endpoint;

  SetParams({this.askSensors, this.address, this.port, this.endpoint});

  @override
  List<Object> get props => [askSensors, address, port, endpoint];
}

class NewSensors extends AbstractWSEvent {
  final List<USensor> sensors;

  NewSensors({@required this.sensors});
}

class StartExchange extends AbstractWSEvent {}

class StopExchange extends AbstractWSEvent {}
