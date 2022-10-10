class ComponentConfig {
  ComponentConfig({
    this.requesed,
    this.size,
    this.min,
    this.max,
    this.interval,
    this.hasDecimals,
    this.decimalQuantity,
    this.maxPhotos,
    this.minPhotos,
    this.textOnly,
    this.format,
    this.parent,
    this.questionScore,
    this.setDefaultValue,
    this.defaultValue,
    this.weighting,
  });

  String? requesed;
  String? size;
  String? min;
  String? max;
  String? interval;
  String? hasDecimals;
  String? decimalQuantity;
  String? maxPhotos;
  String? minPhotos;
  String? textOnly;
  String? format;
  String? parent;
  String? questionScore;
  String? setDefaultValue;
  dynamic defaultValue;
  Weighting? weighting;

  factory ComponentConfig.fromJson(Map<String, dynamic> json) =>
      ComponentConfig(
        requesed: json["required"],
        size: json["size"],
        min: json["min"],
        max: json["max"],
        interval: json["interval"],
        hasDecimals: json["has_decimals"],
        decimalQuantity: json["decimal_quantity"],
        maxPhotos: json["max_photos"],
        minPhotos: json["min_photos"],
        textOnly: json["text_only"],
        format: json["format"],
        parent: json["parent"],
        questionScore: json["question_score"],
        setDefaultValue: json["set"],
        defaultValue: json["default_value"],
        weighting: json["weighting"] == null
            ? null
            : Weighting.fromJson(json["weighting"]),
      );

  Map<String, dynamic> toJson() => {
        "required": requesed,
        "size": size,
        "min": min,
        "max": max,
        "interval": max,
        "has_decimals": hasDecimals,
        "decimal_quantity": decimalQuantity,
        "max_photos": maxPhotos,
        "min_photos": minPhotos,
        "text_only": textOnly,
        "format": format,
        "parent": parent,
        "question_score": questionScore,
        "set": setDefaultValue,
        "default_value": defaultValue,
        "weighting": weighting == null ? null : weighting!.toJson(),
      };
}

class Weighting {
  Weighting({
    this.weighting,
    this.typeSurvey,
  });

  int? weighting;
  String? typeSurvey;
  String? type;

  factory Weighting.fromJson(Map<String, dynamic> json) => Weighting(
        weighting: json["weighting"],
        typeSurvey: json["type_survey"],
      );

  Map<String, dynamic> toJson() => {
        "weighting": weighting,
        "type_survey": typeSurvey,
      };
}
