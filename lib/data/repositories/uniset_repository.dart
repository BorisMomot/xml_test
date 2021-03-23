import 'dart:async';
import 'dart:convert';
import 'package:xml_test/data/models/uniset_sensor.dart';
import 'package:xml_test/data/providers/usensor_provider.dart';
import 'package:web_socket_channel/io.dart';

class UnisetRepository {
  var _websocket;

  // Флаг о том, что заданы параметры соединения и мы готовы connect
  bool _isReadyToConnect = false;
  bool get isReadyToConnect => _isReadyToConnect;
  // Список зарпашиваемых датчиков
  String _askSensors;

  set askSensors(String value) {
    if (value.isNotEmpty) {
      _askSensors = value;
      // Проверка не готовы ли мы
      _isReadyToConnect = _checkReadyToWork();
    }
  }

  // Настройка соединения
  String _address = '';
  int _port = 0;
  String _endpoint = '';
  void setConnectionParams({String address, int port, String endpoint}) {
    // Должна быть проверка корректности
    if (address.isNotEmpty && port > 1000 && endpoint.isNotEmpty) {
      _address = address;
      _port = port;
      _endpoint = endpoint;
      // Проверка не готовы ли мы
      _isReadyToConnect = _checkReadyToWork();
    }
  }

  bool _checkReadyToWork() {
    return _askSensors.isNotEmpty &&
        _address.isNotEmpty &&
        _port > 0 &&
        _endpoint.isNotEmpty;
  }

  // Получить параметры соеденения
  List<String> getConnectionParams() {
    List<String> temp = [];
    temp.add(_address);
    temp.add(_port.toString());
    temp.add(_endpoint);
    temp.add(_askSensors);
    return temp;
  }

  void connect() {
    if (_isReadyToConnect) {
      _websocket = IOWebSocketChannel.connect(
          'ws://${_address}:${_port.toString()}${_endpoint}/?${_askSensors}');

      // Функция для обработки полученных из провайдера данных
      final Function listenMethod = (dynamic message) {
        print('Receive message! ');

        var sensorsJSONList = jsonDecode(message.toString())['data'] as List;
        final _usensorsList = sensorsJSONList
            .map((sensorJSON) => USensor.fromJSON(sensorJSON))
            .toList();
        // отправляем новые датчики в поток
        _inUSensorsStream.add(_usensorsList);
      };
      // Привязываем обработчик
      _websocket.stream.listen(listenMethod, onError: (error) {
        print('Websocket Error');
      }, onDone: () {
        print('Websocket connection closed!');
      });
    }
  }

  void disconnect() {
    _websocket.close();
  }

  // Основной поток с датчиками
  StreamController<List<USensor>> _usensorStreamController =
      StreamController.broadcast();
  // Точка входа, чтобы закидывать датчики в поток с датчиками
  Sink<List<USensor>> get _inUSensorsStream => _usensorStreamController.sink;

  // Публичный поток с датчиками
  Stream<List<USensor>> get outUSensorListStream =>
      _usensorStreamController.stream;

  UnisetRepository() {}
}
