final String componentsTable = 'components';

class componentsField {
  static final List<String> values = [id, id_com, name, date, quntity];
  static final String id = '_id';
  static final String id_com = "id_com";
  static final String name = 'name';
  static final String date = 'date';
  static final String quntity = "quntity";
}

class components {
  final int? id;
  final int? id_com;
  final String name;
  final String date;
  final String quntity;

  const components(
      {this.id,
      required this.id_com,
      required this.name,
      required this.date,
      required this.quntity});
  static components fromJsonct(Map<String, Object?> json) => components(
        id: json[componentsField.id] as int?,
        id_com: json[componentsField.id_com] as int?,
        name: json[componentsField.name] as String,
        date: json[componentsField.date] as String,
        quntity: json[componentsField.quntity] as String,
      );

  Map<String, Object?> toJsonc() => {
        componentsField.id: id,
        componentsField.id_com: id_com,
        componentsField.name: name,
        componentsField.date: date,
        componentsField.quntity: quntity,
      };
  components copyc({int? id}) => components(
        id: id ?? this.id,
        id_com: id_com ?? this.id_com,
        name: name ?? this.name,
        date: date ?? this.date,
        quntity: quntity ?? this.quntity,
      );
}
