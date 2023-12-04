class AizenModel {
  String? system;
  String? message;

  AizenModel({this.system, this.message});

  AizenModel.fromJson(Map<String, dynamic> json) {
    if (json["system"] is String) {
      system = json["system"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["system"] = system;
    data["message"] = message;
    return data;
  }
}
