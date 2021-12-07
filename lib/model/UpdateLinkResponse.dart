class UpdateLinkResponse {
  UpdateLinkResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory UpdateLinkResponse.fromJson(Map<String, dynamic> json) => UpdateLinkResponse(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.userId,
    required this.type,
    required this.link,
    required this.v,
  });

  String id;
  String userId;
  String type;
  String link;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    userId: json["userId"],
    type: json["type"],
    link: json["link"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "type": type,
    "link": link,
    "__v": v,
  };
}
