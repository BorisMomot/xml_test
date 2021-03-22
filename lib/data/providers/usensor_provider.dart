import 'dart:async';
import 'package:xml_test/data/models/uniset_sensor.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class USensorsProvider {
  String _askSensors = '';
  String _address = '';
  String _port = '';
  String _endpoint = '';

  var _websocket = IOWebSocketChannel.connect(
      'ws://127.0.0.1:8081/wsgate/?Input1_S,Input2_S,Input3_S,Input4_S,Input5_S,Input6_S,AI11_AS,Input12_S,Input60_S,DO_C,DO1_C,AO_AS,AI_AS,DI1_S,DI2_S,Threshold1_S,TestMode_S,RespondRTU_S,NoRespondRTU2_S,AlarmFuse1_S,AlarmFuse2_AS,DumpSensor1_S,DumpSensor2_S,DumpSensor3_S,DumpSensor4_S,DumpSensor5_S,DumpSensor6_S,DumpSensor7_S,DumpSensor8_S,MB1_AS,MB2_AS,MB3_AS,IOTestMode_AS,imitator_performance1,performance1,Message1,MB1_Mode_AS,Input50_S,Input51_S,Input52_S,Input53_S,Input67_S,AI54_S,AI55_S,AI56_S,AI57_S,Lamp58_C,LogLevel_S,SVU_AskCount_AS,AI64_AS,DI66_AS,D65_S,AI100_AS,AI102_AS,AI103_AS,AI104_AS,AI105_AS,D106_S,AI107_AS,AI108_AS,MM1_Not_Respond_S,MM2_Not_Respond_S,MQTT_AI_AS,MQTT_DI_S,AIForThresholds,Threshold1,Threshold2,AIMBADD2,UNET_DATA1_S,UNET_DATA2_S,UNET_DATA3_S,DATA1_S,DATA2_S,01_01_S,01_02_S,01_04_AS,01_05_S,01_06_AS,01_07_S,01_13_AS,01_14_S,01_14_1_S,01_15_AS,01_16_S,01_16_1_S,01_17_AS,01_18_S,01_19_AS,01_20_S,01_22_S,01_23_S,01_24_S,02_01_AS,02_02_S,02_03_AS,02_04_S,02_05_S,02_06_S,02_07_AS,02_08_S,02_09_AS,02_10_S,02_17_AS,02_18_S,02_19_S,02_20_S,02_21_S,02_22_S,02_23_S,02_24_AS,02_25_S,02_27_AS,02_28_S,02_30_S,02_31_S,02_32_S,02_33_S,02_34_S,02_35_S,02_36_S,02_37_S,02_38_S,02_39_AS,02_40_AS,02_41_S,02_43_S,02_42_S,02_44_S,Sensor10001_S,Sensor10002_S,Sensor10003_S,Sensor10004_S,Sensor10005_S,Sensor10006_S,Sensor10007_S,Sensor10008_S,Sensor10009_S,Sensor10010_S,Sensor10011_S,Sensor10012_S,Sensor10013_S,Sensor10014_S,Sensor10015_S,Sensor10016_S,Sensor10017_S,Sensor10018_S,Sensor10019_S,Sensor10020_S,Sensor10021_S,Sensor10022_S,Sensor10023_S,Sensor10024_S,Sensor10025_S,Sensor10026_S,Sensor10027_S,Sensor10028_S,Sensor10029_S,Sensor10030_S,Sensor10031_S,Sensor10032_S,Sensor10033_S,Sensor10034_S,Sensor10035_S,Sensor10036_S,Sensor10037_S,Sensor10038_S,Sensor10039_S,Sensor10040_S,Sensor10041_S,Sensor10042_S,Sensor10043_S,Sensor10044_S,Sensor10045_S,Sensor10046_S,Sensor10047_S,Sensor10048_S,Sensor10049_S,Sensor10050_S,Sensor10052_S,Sensor10053_S,Sensor10054_S,Sensor10055_S,Sensor10056_S,Sensor10057_S,Sensor10058_S,Sensor10059_S,Sensor10060_S,Sensor10061_S,Sensor10062_S,Sensor10063_S,Sensor10064_S');

  USensorsProvider() {}

  // Getters
  Stream get websocket => _websocket.stream;
  String get endpoint => _endpoint;
  String get port => _port;
  String get address => _address;
  String get askSensors => _askSensors;

  // Заказ дополнительных датчиков
  void askExtraSensors(String sensors) {
    _websocket.sink.add('ask:$sensors');
  }

  // Запись значения в датчик
  void setSensorsValue(String sensor, int value) {
    _websocket.sink.add('set:$sensor=$value');
  }

  void initConnection(
      {String askSensors, String address, String port, String endpoint}) {
    _askSensors = askSensors;
    _address = address;
    _port = port;
    _endpoint = endpoint;
    // _websocket = IOWebSocketChannel.connect(
    //     Uri.parse('${_address}:${_port}${_endpoint}/?${askSensors}'));

    _websocket = IOWebSocketChannel.connect(
        'ws://127.0.0.1:8081/wsgate/?Input1_S,Input2_S,Input3_S,Input4_S,Input5_S,Input6_S,AI11_AS,Input12_S,Input60_S,DO_C,DO1_C,AO_AS,AI_AS,DI1_S,DI2_S,Threshold1_S,TestMode_S,RespondRTU_S,NoRespondRTU2_S,AlarmFuse1_S,AlarmFuse2_AS,DumpSensor1_S,DumpSensor2_S,DumpSensor3_S,DumpSensor4_S,DumpSensor5_S,DumpSensor6_S,DumpSensor7_S,DumpSensor8_S,MB1_AS,MB2_AS,MB3_AS,IOTestMode_AS,imitator_performance1,performance1,Message1,MB1_Mode_AS,Input50_S,Input51_S,Input52_S,Input53_S,Input67_S,AI54_S,AI55_S,AI56_S,AI57_S,Lamp58_C,LogLevel_S,SVU_AskCount_AS,AI64_AS,DI66_AS,D65_S,AI100_AS,AI102_AS,AI103_AS,AI104_AS,AI105_AS,D106_S,AI107_AS,AI108_AS,MM1_Not_Respond_S,MM2_Not_Respond_S,MQTT_AI_AS,MQTT_DI_S,AIForThresholds,Threshold1,Threshold2,AIMBADD2,UNET_DATA1_S,UNET_DATA2_S,UNET_DATA3_S,DATA1_S,DATA2_S,01_01_S,01_02_S,01_04_AS,01_05_S,01_06_AS,01_07_S,01_13_AS,01_14_S,01_14_1_S,01_15_AS,01_16_S,01_16_1_S,01_17_AS,01_18_S,01_19_AS,01_20_S,01_22_S,01_23_S,01_24_S,02_01_AS,02_02_S,02_03_AS,02_04_S,02_05_S,02_06_S,02_07_AS,02_08_S,02_09_AS,02_10_S,02_17_AS,02_18_S,02_19_S,02_20_S,02_21_S,02_22_S,02_23_S,02_24_AS,02_25_S,02_27_AS,02_28_S,02_30_S,02_31_S,02_32_S,02_33_S,02_34_S,02_35_S,02_36_S,02_37_S,02_38_S,02_39_AS,02_40_AS,02_41_S,02_43_S,02_42_S,02_44_S,Sensor10001_S,Sensor10002_S,Sensor10003_S,Sensor10004_S,Sensor10005_S,Sensor10006_S,Sensor10007_S,Sensor10008_S,Sensor10009_S,Sensor10010_S,Sensor10011_S,Sensor10012_S,Sensor10013_S,Sensor10014_S,Sensor10015_S,Sensor10016_S,Sensor10017_S,Sensor10018_S,Sensor10019_S,Sensor10020_S,Sensor10021_S,Sensor10022_S,Sensor10023_S,Sensor10024_S,Sensor10025_S,Sensor10026_S,Sensor10027_S,Sensor10028_S,Sensor10029_S,Sensor10030_S,Sensor10031_S,Sensor10032_S,Sensor10033_S,Sensor10034_S,Sensor10035_S,Sensor10036_S,Sensor10037_S,Sensor10038_S,Sensor10039_S,Sensor10040_S,Sensor10041_S,Sensor10042_S,Sensor10043_S,Sensor10044_S,Sensor10045_S,Sensor10046_S,Sensor10047_S,Sensor10048_S,Sensor10049_S,Sensor10050_S,Sensor10052_S,Sensor10053_S,Sensor10054_S,Sensor10055_S,Sensor10056_S,Sensor10057_S,Sensor10058_S,Sensor10059_S,Sensor10060_S,Sensor10061_S,Sensor10062_S,Sensor10063_S,Sensor10064_S');
    print('${_address}:${_port}${_endpoint}/?${askSensors}');
  }

  // Переподключиться
  void restartConnection() async {
    await _websocket.sink.close();
    _websocket = IOWebSocketChannel.connect(
        Uri.parse('ws://${_address}:${_port}${_endpoint}/?${askSensors}'));
  }

  // Подключиться с другими параметрами
  void recrateConnection(
      {String askSensors, String address, String port, String endpoint}) async {
    await _websocket.sink.close();
    initConnection(
        askSensors: askSensors,
        address: address,
        port: port,
        endpoint: endpoint);
  }

  // Отключить обмен
  void closeConnection() async {
    await _websocket.sink.close();
  }
}
