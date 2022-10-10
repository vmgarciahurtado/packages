import 'component_config.dart';
import 'component_option.dart';

class DynamicFormContent {
  DynamicFormContent({
    this.code,
    this.config,
    this.component,
    this.label,
    this.id,
    this.option,
    this.type,
    this.defaultAnswer,
  });

  String? code;
  ComponentConfig? config;
  String? component;
  String? label;
  String? id;
  List<ComponentOption>? option;
  String? type;
  String? defaultAnswer;

  factory DynamicFormContent.fromJson(Map<dynamic, dynamic> json) =>
      DynamicFormContent(
        code: json["code"],
        config: json["config"],
        component: json["component"],
        label: json["label"],
        id: json["_id"],
        option: json["option"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "config": config,
        "component": component,
        "label": label,
        "_id": id,
        "option": option,
        "type": type,
      };
}
