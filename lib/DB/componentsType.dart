final String componentsTypeTable = 'componentsType';

class componentsTypeField {
  static final List<String> values = [id, type];
  static final String id = '_id';
  static final String type = 'type';
}

class componentsType {
  final int? id;
  final String type;

  const componentsType({
    this.id,
    required this.type,
  });
  static componentsType fromJsonct(Map<String, Object?> json) => componentsType(
    id: json[componentsTypeField.id] as int?,
    type: json[componentsTypeField.type] as String,
  );

  Map<String, Object?> toJsonct() => {
    componentsTypeField.id: id,
    componentsTypeField.type: type,
  };
  componentsType copyct({int? id}) => componentsType(
    id: id ?? this.id,
    type: type ?? this.type,
  );
}
