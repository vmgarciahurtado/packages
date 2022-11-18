class NomenclatureAddress {
  NomenclatureAddress({
    required this.id,
    required this.name,
    required this.code,
  });

  String id;
  String name;
  String code;

  factory NomenclatureAddress.fromJson(Map<String, dynamic> json) =>
      NomenclatureAddress(
        id: json["_id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "code": code,
      };
}
