class GetTapUserResponse {
  GetTapUserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory GetTapUserResponse.fromJson(Map<String, dynamic> json) => GetTapUserResponse(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.tapUserid,
    required this.v,
  });

  String id;
  String userId;
  TapUserid tapUserid;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userId: json["userId"],
    tapUserid: TapUserid.fromJson(json["tapUserid"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "tapUserid": tapUserid.toJson(),
    "__v": v,
  };
}

class TapUserid {
  TapUserid({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
    required this.description,
    required this.status,
    required this.longitude,
    required this.latitude,
    this.verifyToken,
    required this.verifyStatus,
    required this.createdAt,
    required this.profilePic,
    required this.v,
  });

  String id;
  String firstName;
  String lastName;
  String dob;
  String email;
  String description;
  int status;
  double longitude;
  double latitude;
  dynamic verifyToken;
  int verifyStatus;
  DateTime createdAt;
  String profilePic;
  int v;

  factory TapUserid.fromJson(Map<String, dynamic> json) => TapUserid(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    dob: json["dob"],
    email: json["email"],
    description: json["description"],
    status: json["status"],
    longitude: json["longitude"]!=null?json["longitude"].toDouble():0.0,
    latitude: json["latitude"]!=null?json["latitude"].toDouble():0.0,
    verifyToken: json["verifyToken"],
    verifyStatus: json["verifyStatus"],
    createdAt: DateTime.parse(json["createdAt"]),
    profilePic: json["profilePic"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "dob": dob,
    "email": email,
    "description": description,
    "status": status,
    "longitude": longitude,
    "latitude": latitude,
    "verifyToken": verifyToken,
    "verifyStatus": verifyStatus,
    "createdAt": createdAt.toIso8601String(),
    "profilePic": profilePic,
    "__v": v,
  };
}
