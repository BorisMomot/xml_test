import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xml_test/presentation/components/rounded_button.dart';
import 'package:xml_test/presentation/constants.dart';
import 'package:flutter/services.dart';
import 'package:xml_test/business_logic/bloc/configure_parse_bloc.dart';
import 'package:xml_test/business_logic/bloc/configure_parse_event.dart';
import 'package:xml_test/business_logic/bloc/ws_bloc.dart';
import 'package:xml_test/business_logic/bloc/ws_event.dart';

import 'package:bloc/bloc.dart';
import '../../business_logic/bloc/configure_parse_bloc.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Настройки для парсинга configure
  String pathToConfigure = './configure.xml';

  // Настройки для соединения с ws
  TextEditingController textEditingController = TextEditingController();

  String address = 'ws://127.0.0.1';
  String port = '8081';
  String endpoint = '/wsgate';
  bool askAllSensors =
      true; // подписываться ли на все датчики из configure, если нет,то на сколько
  int amountSensors = 1;
  TextEditingController amountOfSensorsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Обрабатываем ввод
    amountOfSensorsController.addListener(() {
      if (!askAllSensors) {
        amountSensors = 0;
        amountOfSensorsController.value =
            amountOfSensorsController.value.copyWith(
          text: '',
        );
      } else {
        amountSensors = int.tryParse(amountOfSensorsController.text);
      }
    });
  }

  @override
  void dispose() {
    amountOfSensorsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48,
            ),
            // path to configure
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Path to configure file',
              ),
              initialValue: './configure.xml',
              textAlign: TextAlign.center,
              onChanged: (value) {
                pathToConfigure = value;
              },
            ),
            SizedBox(
              height: 8,
            ),

            // address
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
              ),
              initialValue: '127.0.0.1',
              textAlign: TextAlign.center,
              onChanged: (value) {
                address = value;
              },
            ),
            SizedBox(
              height: 8,
            ),

            // port
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Port',
              ),
              initialValue: '8081',
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.center,
              onChanged: (value) {
                port = value;
              },
            ),
            SizedBox(
              height: 8,
            ),

            // endpoint
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Endpoint',
              ),
              initialValue: '/wsgate',
              textAlign: TextAlign.center,
              onChanged: (value) {
                pathToConfigure = value;
              },
            ),
            SizedBox(
              height: 8,
            ),
            // askAllSensors
            Row(
              children: [
                Switch(
                    value: askAllSensors,
                    onChanged: (value) {
                      setState(() {
                        askAllSensors = !askAllSensors;
                        print(askAllSensors);
                      });
                    }),
                Container(
                  width: 300,
                  child: TextFormField(
                    controller: amountOfSensorsController,
                    enabled: askAllSensors,
                    decoration: InputDecoration(
                      labelText: 'Amount of sensors',
                    ),
                    // initialValue: '1',
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.center,
                    // onChanged: (value) {
                    //   amountOfSensorsController.text = '$value';
                    // },
                  ),
                ),
              ],
            ),
            RoundedButton(
              title: 'Save',
              colour: Colors.blueAccent,
              onPressed: () {
                // Validate and save values

                BlocProvider.of<ConfigureParseBloc>(context).add(
                    ChangeConfigureParam(
                        pathToConfigure: pathToConfigure,
                        takeAllSensors: askAllSensors,
                        amountOfSensors: amountSensors));

                BlocProvider.of<ConfigureParseBloc>(context)
                    .add(ParseConfigure());

                BlocProvider.of<WSBloc>(context).add(SetParams(
                    address: address, endpoint: endpoint, port: port));

                // /home/boris/pr/uniset2/conf/test.xml
              },
            )
          ],
        ),
      ),
    );
  }
}
