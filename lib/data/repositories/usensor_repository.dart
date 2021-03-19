import 'dart:async';
import 'dart:convert';
import 'package:xml_test/data/models/uniset_sensor.dart';
import 'package:xml_test/data/providers/usensor_provider.dart';

class USensorsRepository {
  USensorsProvider _uSensorsProvider = USensorsProvider();

  // Полученные датчики
  List<USensor> _usensorsList = [];

  // Основной поток с датчиками
  StreamController<List<USensor>> _usensorStreamController =
      StreamController.broadcast();
  // Точка входа, чтобы закидывать датчики в поток с датчиками
  Sink<List<USensor>> get _inUSensorsStream => _usensorStreamController.sink;

  // Публичный поток с датчиками
  Stream<List<USensor>> get outUSensorListStream =>
      _usensorStreamController.stream;

  // Подключиться к вебсокету
  void connectToWebsocket(
      {String askSensors, String address, String port, String endpoint}) {
    // TODO Добавить проверку состояния
    _uSensorsProvider.initConnection(
        askSensors: askSensors,
        address: address,
        port: port,
        endpoint: endpoint);
  }

  // Переподключиться
  void reConnectToWebsocket(
      {String askSensors, String address, String port, String endpoint}) {
    // TODO Добавить проверку состояния
    _uSensorsProvider.recrateConnection(
        askSensors: askSensors,
        address: address,
        port: port,
        endpoint: endpoint);
  }

  // Рестартануть websocket
  void restartConnectToWebsocket() {
    _uSensorsProvider.restartConnection();
  }

  // Заказать дополнительные датчики
  void askExtraSensors(String sensors) {
    _uSensorsProvider.askExtraSensors(sensors);
  }

  // Получить параметры соеденения
  List<String> getConnectionParams() {
    List<String> temp = [];
    temp.add(_uSensorsProvider.askSensors);
    temp.add(_uSensorsProvider.address);
    temp.add(_uSensorsProvider.port);
    temp.add(_uSensorsProvider.endpoint);
    return temp;
  }

  USensorsRepository() {
    // Функция для обработки полученных из провайдера данных
    final Function listenMethod = (dynamic message) {
      // чистим сообщения с прошлого раза
      _usensorsList.clear();

      var sensorsJSONList = jsonDecode(message.toString())['data'] as List;
      _usensorsList = sensorsJSONList
          .map((sensorJSON) => USensor.fromJSON(sensorJSON))
          .toList();
      // отправляем новые датчики в поток
      _inUSensorsStream.add(_usensorsList);
    };
    // Привязываем обработчик
    _uSensorsProvider.websocket.listen(listenMethod, onError: (error) {
      print('Websocket Error');
    }, onDone: () {
      print('Websocket connection closed!');
    });
  }
}
