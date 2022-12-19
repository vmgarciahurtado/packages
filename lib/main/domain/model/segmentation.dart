class Segmentation {
  Segmentation({
    this.tipologia,
    this.canal,
    this.subCanal,
    this.segmento,
    this.name,
  });

  String? tipologia;
  String? canal;
  String? subCanal;
  String? segmento;
  String? name;

  factory Segmentation.fromJson(Map<String, dynamic> json) => Segmentation(
        tipologia: json["tipologia"],
        canal: json["canal"],
        subCanal: json["sub_canal"],
        segmento: json["segmento"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "tipologia": tipologia,
        "canal": canal,
        "sub_canal": subCanal,
        "segmento": segmento,
        "name": name,
      };
}
