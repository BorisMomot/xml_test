import 'configure_parse_bloc.dart';
import 'ws_event.dart';
import 'ws_event.dart';
import 'ws_state.dart';
import 'package:bloc/bloc.dart';
import 'package:xml_test/data/repositories/usensor_repository.dart';
import 'package:xml_test/business_logic/bloc/configure_parse_bloc.dart';
import 'package:xml_test/business_logic/bloc/configure_parse_state.dart';

class WSBloc extends Bloc<AbstractWSEvent, AbstractWSState> {
  final ConfigureParseBloc configureParseBloc;

  // параметры соединения
  String _address = '';
  String _port = '';
  String _endpoint = '';

  // список запрашиваемых датчиков
  String _sensorsToAsk = '';

  WSBloc({this.configureParseBloc}) : super(InitStateWS()) {
    // Подписываесся на события из ConfigureParseBloc
    configureParseBloc.listen((state) {
      if (state is SensorsLoaded) {
        _sensorsToAsk = '';
        for (final s in state.sensorsList) {
          _sensorsToAsk += '${s.name},';
        }
        // print('New $_sensorsToAsk');
      }
    });
    // Подписываемся на события от ws
    _uSensorsRepository.outUSensorListStream.listen((banchOfSensors) {
      this.add(NewSensors(sensors: banchOfSensors));
    });
  }

  USensorsRepository _uSensorsRepository = USensorsRepository();

  @override
  Stream<AbstractWSState> mapEventToState(AbstractWSEvent event) async* {
    if (event is SetParams) {
      // TODO проверка на корректность

      print('Ask sensor value: $_sensorsToAsk');
      _address = event.address;
      _port = event.port;
      _endpoint = event.endpoint;
    } else if (event is NewSensors) {
      for (final s in event.sensors) {
        print('${s.name} = ${s.value}');
      }

      yield NewSensorsReceivedWSState(sens: event.sensors);
    } else if (event is StartExchange) {
      // _uSensorsRepository.restartConnectToWebsocket();
      _uSensorsRepository.connectToWebsocket(
          askSensors: _sensorsToAsk,
          address: _address,
          port: _port,
          endpoint: _endpoint);
    } else if (event is StopExchange) {
      print('Couldn\'t stop WS');
    }
  }
}
