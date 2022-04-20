class OneDataModel {
  OneDataModel({
    required this.abbreviation,
    required this.name,
  });

  String abbreviation;
  String name;

  factory OneDataModel.fromJson(Map<String, dynamic> json) => OneDataModel(
        abbreviation: json["sigla"],
        name: json["nome"],
      );

  static List<OneDataModel> listFromJson(list) => List<OneDataModel>.from(list.map((x) => OneDataModel.fromJson(x)));
}
