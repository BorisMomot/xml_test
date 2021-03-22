import 'dart:io';
import 'package:args/args.dart' as args;
import 'package:xml/xml.dart';

// класс для удобства парсинга configure и получения информации по датчикам
class ConfigureParser {
  // -t sensors ./conf/configure.xml
  final args.ArgParser argumentParser = args.ArgParser()
    ..addOption(
      'tag',
      abbr: 't',
      help: 'Filter by tag name.',
      defaultsTo: 'sensors',
    );

  List<List<XmlAttribute>> parseConfigure({List<String> arguments}) {
    final files = <File>[];
    final results = argumentParser.parse(arguments);
    final String tag = results['tag'];

    List<List<XmlAttribute>> sensorsAttributes = [];

    for (final argument in results.rest) {
      final file = File(argument);
      if (file.existsSync()) {
        files.add(file);
      } else {
        stderr.writeln('File not found: $file');
        // exit(2);
        return sensorsAttributes;
      }
    }

    // проходим по всем файлам указанным как configure
    for (final file in files) {
      final document = XmlDocument.parse(file.readAsStringSync());
      // ищем все элементы с тегом sensors
      final elements = document.findAllElements(tag);
      for (final sens in elements) {
        final sensInScope = sens.children;
        for (final s in sensInScope) {
          if (s.attributes.isNotEmpty) {
            sensorsAttributes.add(s.attributes);
          }
        }
      }
    }
    return sensorsAttributes;
  }
}
