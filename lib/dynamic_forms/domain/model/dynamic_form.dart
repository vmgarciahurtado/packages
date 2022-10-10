class DynamicForm {
  DynamicForm({
    required this.code,
    required this.id,
    required this.name,
    required this.type,
    required this.conditioned,
    required this.context,
  });

  String code;
  String id;
  String name;
  String type;
  String conditioned;
  String context;

  factory DynamicForm.fromJson(Map<dynamic, dynamic> json) => DynamicForm(
        code: json["code"],
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        conditioned: json["conditioned"],
        context: json["context"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "_id": id,
        "name": name,
        "type": type,
        "conditioned": conditioned,
        "context": context,
      };
}
