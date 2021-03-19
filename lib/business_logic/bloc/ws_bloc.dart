import 'ws_event.dart';
import 'ws_state.dart';
import 'package:bloc/bloc.dart';
import 'package:xml_test/data/repositories/usensor_repository.dart';

class WSBloc extends Bloc<AbstractWSEvent, AbstractWSState> {
  WSBloc() : super(InitStateWS()) {
    _uSensorsRepository.outUSensorListStream.listen((banchOfSensors) {
      this.add(NewSensors(sensors: banchOfSensors));
    });
  }

  USensorsRepository _uSensorsRepository = USensorsRepository();

  @override
  Stream<AbstractWSState> mapEventToState(AbstractWSEvent event) async* {
    if (event is SetParams) {
      // TODO проверка на корректность
      _uSensorsRepository.reConnectToWebsocket(
          askSensors: event.askSensors,
          address: event.address,
          port: event.port,
          endpoint: event.endpoint);
    } else if (event is NewSensors) {
      yield NewSensorsReceivedWSState(sens: event.sensors);
    } else if (event is StartExchange) {
      _uSensorsRepository.restartConnectToWebsocket();
    } else if (event is StopExchange) {
      print('Couldn\'t stop WS');
    }
  }
}
