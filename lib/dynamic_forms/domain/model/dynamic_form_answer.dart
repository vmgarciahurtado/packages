class DynamicFormAnswer {
  DynamicFormAnswer(
      {this.dynamicForms,
      this.dynamicContents,
      this.clientId,
      this.sellerId,
      this.answer,
      this.codeParam,
      this.createdAt,
      this.isEndSegmentation});

  String? dynamicForms;
  String? dynamicContents;
  String? clientId;
  String? sellerId;
  String? answer;
  String? codeParam;
  String? createdAt;
  bool? isEndSegmentation;

  factory DynamicFormAnswer.fromJson(Map<String, dynamic> json) =>
      DynamicFormAnswer(
        dynamicForms: json["dynamic_forms"],
        dynamicContents: json["dynamic_contents"],
        clientId: json["client_id"],
        sellerId: json["seller_id"],
        answer: json["answer"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "dynamic_forms": dynamicForms,
        "dynamic_contents": dynamicContents,
        "client_id": clientId,
        "seller_id": sellerId,
        "answer": answer,
        "created_at": createdAt,
      };
}
