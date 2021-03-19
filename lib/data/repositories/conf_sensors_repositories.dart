import 'package:flutter/cupertino.dart';
import 'package:xml/xml.dart';
import 'package:xml_test/data/providers/configure_parser.dart';
import 'package:xml_test/data/models/conf_sensor.dart';

// Репозиторий для хранения датчиков
class ConfSensorsRepository {
  // ConfigureParser configureParser = ConfigureParser(arguments: '/home/boris/projects/sedbm/conf/configure.xml');
  ConfigureParser configureParser = ConfigureParser();
  List<ConfSensor> _sensors = [];

  List<ConfSensor> get sensors => _sensors;

  ConfSensorsRepository();

  Future<void> updateSensors(List<String> params) async {
    final confSensPararmList = configureParser.parseConfigure(
        arguments: ['/home/boris/projects/sedbm/conf/configure.xml']);

    for (final sensParam in confSensPararmList) {
      final id =
          sensParam.lastWhere((element) => element.name.local == 'id').value ??
              0;
      print(id);
      final name = sensParam
              .lastWhere((element) => element.name.local == 'name')
              .value ??
          '';
      print(name);
      final defaultValue = 0;

      _sensors.add(ConfSensor(
          id: int.parse(id), name: name, defaultValue: defaultValue));
    }
  }
}
