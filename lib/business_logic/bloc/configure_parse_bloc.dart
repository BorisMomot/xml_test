import 'configure_parse_event.dart';
import 'configure_parse_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xml_test/data/repositories/conf_sensors_repositories.dart';

class ConfigureParseBloc extends Bloc<ConfParseEvent, ConfParseState> {
  ConfigureParseBloc() : super(InitState());

  ConfSensorsRepository confSensorsRepository = ConfSensorsRepository();

  @override
  Stream<ConfParseState> mapEventToState(ConfParseEvent event) async* {
    if (event is ParseConfigure) {
      await confSensorsRepository
          .updateSensors(['/home/boris/projects/sedbm/conf/configure.xml']);
      yield SensorsLoaded(sensors: confSensorsRepository.sensors);
    }
  }
}
