final String orderTable = 'orders';

class orderField {
  static final List<String> values = [id, idU, idC, dateR, quntity];
  static final String id = '_id';
  static final String idU = "idU";
  static final String idC = 'idC';
  static final String dateR = 'dateR';
  static final String quntity = "quntity";
}

class order {
  final int? id;
  final String idU;
  final String idC;
  final String dateR;
  final String quntity;

  const order(
      {this.id,
      required this.idU,
      required this.idC,
      required this.dateR,
      required this.quntity});
  static order fromJson(Map<String, Object?> json) => order(
        id: json[orderField.id] as int?,
        idU: json[orderField.idU] as String,
        idC: json[orderField.idC] as String,
        dateR: json[orderField.dateR] as String,
        quntity: json[orderField.quntity] as String,
      );

  Map<String, Object?> toJson() => {
        orderField.id: id,
        orderField.idU: idU,
        orderField.idC: idC,
        orderField.dateR: dateR,
        orderField.quntity: quntity,
      };
  order copy({int? id}) => order(
        id: id ?? this.id,
        idU: idU ?? this.idU,
        idC: idC ?? this.idC,
        dateR: dateR ?? this.dateR,
        quntity: quntity ?? this.quntity,
      );
}
