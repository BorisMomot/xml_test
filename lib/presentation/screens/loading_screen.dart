import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xml_test/presentation/components/rounded_button.dart';
import 'package:xml_test/presentation/constants.dart';
import 'package:flutter/services.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
