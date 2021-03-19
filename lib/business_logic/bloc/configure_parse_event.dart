import 'package:equatable/equatable.dart';

abstract class ConfParseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Получен запрос на парсинг configure
class ParseConfigure extends ConfParseEvent {}
