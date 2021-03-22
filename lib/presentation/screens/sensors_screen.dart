import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xml_test/presentation/components/rounded_button.dart';
import 'package:xml_test/presentation/constants.dart';
import 'package:flutter/services.dart';

import '../../business_logic/bloc/ws_bloc.dart';
import '../../business_logic/bloc/ws_state.dart';
import '../../data/models/uniset_sensor.dart';

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
        child: BlocBuilder<WSBloc, AbstractWSState>(builder: (context, state) {
          final List<USensor> sensors = state.sensors;

          return Column(
            children: [
              Text('Amount of received sensors: ${sensors.length}'),
              Container(
                height: 700,
                color: Colors.grey[300],
                child: Scrollbar(
                  child: ListView.builder(
                      itemCount: sensors.length,
                      itemBuilder: (BuildContext context, int index) {
                        final uSensor = sensors[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                          child: InkWell(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (_) => BlogPostModify(
                              //       uSensor: uSensor,
                              //     )));
                            },
                            child: Container(
                              padding: EdgeInsets.all(1),
                              child: Column(
                                children: [
                                  Text(
                                    '${uSensor.id} = ${uSensor.value}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
