class USensor {
  final String name;
  final int value;
  final int id;
  final String ioType;

  USensor({this.name, this.value, this.id, this.ioType});

  factory USensor.fromJSON(dynamic json) {
    return USensor(
      id: json['id'] as int,
      name: json['name'] as String,
      value: json['value'] as int,
      ioType: json['iotype'] as String,
    );
  }
}
