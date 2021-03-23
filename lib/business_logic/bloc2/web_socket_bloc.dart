import 'package:bloc/bloc.dart';
import 'package:xml_test/business_logic/bloc2/web_socket_events.dart';
import 'package:xml_test/business_logic/bloc2/web_socket_states.dart';
import 'package:xml_test/business_logic/bloc/configure_parse_bloc.dart';
// import 'package:xml_test/business_logic/bloc/configure_parse_event.dart';
import 'package:xml_test/business_logic/bloc/configure_parse_state.dart';
import 'package:xml_test/data/repositories/uniset_repository.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  WebSocketBloc({this.configureParseBloc}) : super(WebSocketUnconnected()) {
    // Подписываесся на события из ConfigureParseBloc
    configureParseBloc.listen((state) {
      if (state is SensorsLoaded) {
        var _sensorsToAsk = '';
        for (final s in state.sensorsList) {
          _sensorsToAsk += '${s.name},';
        }
        _unisetRepository.askSensors = _sensorsToAsk;
      }
    });
    // Подписываемся на события от ws
    _unisetRepository.outUSensorListStream.listen((banchOfSensors) {
      this.add(GetSensors(usensors: banchOfSensors));
    });
  }

  final ConfigureParseBloc configureParseBloc;

  final UnisetRepository _unisetRepository = UnisetRepository();

  @override
  Stream<WebSocketState> mapEventToState(WebSocketEvent event) async* {
    if (event is Connect) {
      // _unisetRepository.connect();
    } else if (event is Disconnect) {
      // _unisetRepository.disconnect();
    } else if (event is GetSensors) {
      yield WebSocketNewSensorsRecieved(usensors: event.usensors);
    } else if (event is ConnectionError) {
      yield WebSocketError(error: event.error);
    }
  }
}
