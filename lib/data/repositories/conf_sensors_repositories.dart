import 'package:flutter/cupertino.dart';
import 'package:xml/xml.dart';
import 'package:xml_test/data/providers/configure_parser.dart';
import 'package:xml_test/data/models/conf_sensor.dart';

import '../models/conf_sensor.dart';
import '../models/conf_sensor.dart';
import '../models/conf_sensor.dart';

// Репозиторий для хранения датчиков
class ConfSensorsRepository {
  // ConfigureParser configureParser = ConfigureParser(arguments: '/home/boris/projects/sedbm/conf/configure.xml');
  ConfigureParser configureParser = ConfigureParser();
  List<ConfSensor> _sensors = [];

  List<ConfSensor> get sensors => _sensors;

  ConfSensorsRepository();

  // Парсим configure
  List<ConfSensor> getSensors({@required String filePath, int amount}) {
    List<ConfSensor> _sens = [];
    final confSensPararmList =
        configureParser.parseConfigure(arguments: [filePath]);

    // Парсим configure и выбираем датчики
    if (amount == null || amount <= 0) {
      // выбираем все датчики
      for (final sensParam in confSensPararmList) {
        _sens.add(_parseConfSensParamString(sensParam));
      }
    } else {
      // выбираем только заданное количество
      int counter = 0;
      for (final sensParam in confSensPararmList) {
        if (counter >= amount) {
          break;
        }
        _sens.add(_parseConfSensParamString(sensParam));
        counter++;
      }
    }
    return _sens;
  }

  // Служебная функция для парсинга конфигурационных строчек
  ConfSensor _parseConfSensParamString(List<XmlAttribute> atr) {
    final id =
        atr.lastWhere((element) => element.name.local == 'id').value ?? 0;
    // print(id);
    final name =
        atr.lastWhere((element) => element.name.local == 'name').value ?? '';
    // print(name);
    final defaultValue = 0;
    return ConfSensor(
        id: int.parse(id), name: name, defaultValue: defaultValue);
  }
  // Future<void> updateSensors(List<String> params) async {
  //   final confSensPararmList = configureParser.parseConfigure(
  //       arguments: ['/home/boris/projects/sedbm/conf/configure.xml']);
  //
  //   for (final sensParam in confSensPararmList) {
  //     final id =
  //         sensParam.lastWhere((element) => element.name.local == 'id').value ??
  //             0;
  //     print(id);
  //     final name = sensParam
  //             .lastWhere((element) => element.name.local == 'name')
  //             .value ??
  //         '';
  //     print(name);
  //     final defaultValue = 0;
  //
  //     _sensors.add(ConfSensor(
  //         id: int.parse(id), name: name, defaultValue: defaultValue));
  //   }
  // }
}
