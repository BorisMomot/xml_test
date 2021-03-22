import '../../data/models/conf_sensor.dart';
import 'configure_parse_event.dart';
import 'configure_parse_event.dart';
import 'configure_parse_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xml_test/data/repositories/conf_sensors_repositories.dart';

import 'configure_parse_state.dart';

class ConfigureParseBloc extends Bloc<ConfParseEvent, ConfParseState> {
  ConfigureParseBloc() : super(InitState());

  String _pathToConfigure = './configure.xml';
  bool _takeAllSensors = true;
  int _amountOfSensors = 0;

  ConfSensorsRepository confSensorsRepository = ConfSensorsRepository();

  @override
  Stream<ConfParseState> mapEventToState(ConfParseEvent event) async* {
    if (event is ParseConfigure) {
      // await confSensorsRepository
      //     .updateSensors(['/home/boris/projects/sedbm/conf/configure.xml']);
      //
      try {
        List<ConfSensor> _sens = confSensorsRepository.getSensors(
            filePath: _pathToConfigure,
            amount: _takeAllSensors ? 0 : _amountOfSensors);
        yield SensorsLoaded(sensors: _sens);
      } catch (e) {
        yield ErrorLoad();
      }
    } else if (event is ChangeConfigureParam) {
      _pathToConfigure = event.pathToConfigure;
      _takeAllSensors = event.takeAllSensors;
      _amountOfSensors = event.amountOfSensors;
    }
  }
}
