import 'package:flutter/material.dart';

class ComponentOption {
  ComponentOption({
    this.label,
    this.codeParam,
    this.destiny,
    this.columns,
    this.rows,
    this.name,
    this.run,
    this.value,
  });

  String? label;
  int? codeParam;
  String? destiny;
  String? order;
  List<ColumnForm>? columns;
  List<RowForm>? rows;
  String? name;
  String? run;
  int? value;

  factory ComponentOption.fromJson(Map<String, dynamic> json) =>
      ComponentOption(
        label: json["label"],
        codeParam: json["code_param"],
        destiny: json["destiny"],
        columns: json["columns"] == null
            ? null
            : List<ColumnForm>.from(
                json["columns"].map((x) => ColumnForm.fromJson(x))),
        rows: json["rows"] == null
            ? null
            : List<RowForm>.from(json["rows"].map((x) => RowForm.fromJson(x))),
        name: json["name"],
        run: json["run"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "code_param": codeParam,
        "destiny": destiny,
        "columns": columns == null
            ? null
            : List<ColumnForm>.from(columns!.map((x) => x.toJson())),
        "rows": rows == null
            ? null
            : List<RowForm>.from(rows!.map((x) => x.toJson())),
        "name": name,
        "run": run,
        "value": value,
      };
}

class ColumnForm {
  ColumnForm({
    this.title,
    this.index,
    this.type,
  });

  String? title;
  String? index;
  String? type;

  factory ColumnForm.fromJson(Map<String, dynamic> json) => ColumnForm(
        title: json["title"],
        index: json["index"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "index": index,
        "type": type,
      };
}

class RowForm {
  RowForm({
    this.action,
    this.success,
    this.documentType,
    this.requesed,
    this.title,
  });

  Action? action;
  String? success;
  String? documentType;
  Map<String, dynamic>? requesed;
  String? title;

  factory RowForm.fromJson(Map<String, dynamic> json) => RowForm(
        action: json["action"] == null ? null : Action.fromJson(json["action"]),
        success: json["success"],
        documentType: json["document_type"],
        requesed: json["required"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "action": action == null ? null : action!.toJson(),
        "success": success,
        "document_type": documentType,
        "required": requesed,
        "title": title,
      };
}

class Action {
  Action({this.icon, this.type, this.link, this.order});

  Icon? icon;
  String? type;
  String? link;
  String? order;

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        icon: json["icon"] == null ? null : iconValues.map![json["icon"]],
        type: json["type"] == null ? null : json[json["type"]],
        link: json["link"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon == null ? null : iconValues.reverse[icon],
        "type": type,
        "link": link,
        "order": order,
      };
}

final iconValues = EnumValues(
  {"ADD": const Icon(Icons.add), "SUCCESS": const Icon(Icons.circle)},
);

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= reverseMap = map!.map((k, v) => MapEntry(v, k));

    return reverseMap!;
  }
}
