import 'dart:io';
import 'package:flutter/material.dart';
import 'package:args/args.dart' as args;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xml/xml.dart';

// import 'package:xml_test/data/repositories/conf_sensors_repositories.dart';
import 'package:xml_test/business_logic/bloc/configure_parse_bloc.dart';
import 'package:xml_test/business_logic/bloc/configure_parse_state.dart';
import 'package:xml_test/business_logic/bloc/configure_parse_event.dart';

// import 'package:xml_test/business_logic/bloc/configure_parse_bloc.dart';
// import 'package:xml_test/business_logic/bloc/configure_parse_state.dart';
// import 'package:xml_test/business_logic/bloc/configure_parse_event.dart';

import 'package:xml_test/presentation/screens/welcome_screen.dart';
import 'package:xml_test/presentation/screens/settings_screen.dart';
import 'package:xml_test/presentation/screens/loading_screen.dart';
import 'package:xml_test/presentation/screens/error_screen.dart';
import 'package:xml_test/presentation/screens/sensors_screen.dart';

void main(List<String> arguments) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ConfigureParseBloc _configureParseBloc = ConfigureParseBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => BlocProvider.value(
            value: _configureParseBloc, child: WelcomeScreen()),
        SettingsScreen.id: (context) => BlocProvider.value(
            value: _configureParseBloc, child: SettingsScreen()),
        LoadingScreen.id: (context) => BlocProvider.value(
            value: _configureParseBloc, child: LoadingScreen()),
        SensorsScreen.id: (context) => BlocProvider.value(
            value: _configureParseBloc, child: SensorsScreen()),
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              height: 400,
              child: BlocBuilder<ConfigureParseBloc, ConfParseState>(
                  builder: (context, state) {
                if (state.sensorsList != null && state.sensorsList.isNotEmpty) {
                  return ListView.builder(
                      itemCount: state.sensorsList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('${state.sensorsList[index].name}'),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ConfigureParseBloc>(context).add(ParseConfigure());
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
