class AnswerValuesResponse {
  AnswerValuesResponse({required this.id, required this.value});

  String id;
  String value;

  factory AnswerValuesResponse.fromJson(Map<String, dynamic> json) =>
      AnswerValuesResponse(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
