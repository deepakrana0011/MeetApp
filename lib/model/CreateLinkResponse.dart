class CreateLinkResponse {
  CreateLinkResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data? data;

  factory CreateLinkResponse.fromJson(Map<String, dynamic> json) => CreateLinkResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"]!=null?Data.fromJson(json["data"]):null,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    required this.userId,
    required this.userName,
    required this.type,
    required this.link,
    required this.id,
    required this.v,
  });

  String userId;
  String userName;
  String type;
  String link;
  String id;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"],
    userName: json["userName"],
    type: json["type"],
    link: json["link"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "type": type,
    "link": link,
    "_id": id,
    "__v": v,
  };
}
