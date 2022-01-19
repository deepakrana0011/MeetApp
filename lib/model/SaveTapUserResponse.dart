class SaveTapUserResponse {
  SaveTapUserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data? data;

  factory SaveTapUserResponse.fromJson(Map<String, dynamic> json) => SaveTapUserResponse(
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
    required this.tapUserid,
    required this.id,
    required this.v,
  });

  String userId;
  String tapUserid;
  String id;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"],
    tapUserid: json["tapUserid"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "tapUserid": tapUserid,
    "_id": id,
    "__v": v,
  };
}
