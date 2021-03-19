import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xml_test/presentation/components/rounded_button.dart';
import 'package:xml_test/presentation/constants.dart';
import 'package:flutter/services.dart';

class SensorsScreen extends StatefulWidget {
  static const String id = 'sensors_screen';
  @override
  _SensorsScreenState createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensors'),
        elevation: (1),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8),
        child: StreamBuilder<List<Text>>(),
      ),
    );
  }
}
