class SignUpResponse {
  SignUpResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.token,
  });

  bool success;
  String message;
  Data? data;
  String token;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"]!=null?Data.fromJson(json["data"]):null,
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data!.toJson(),
    "token": token,
  };
}

class Data {
  Data({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.description,
    required this.password,
    required this.status,
    this.longitude,
    this.latitude,
    required this.verifyToken,
    required this.verifyStatus,
    required this.id,
    required this.createdAt,
    required this.profilePic,
    required this.v,
  });

  String firstName;
  String lastName;
  String email;
  String description;
  String password;
  int status;
  dynamic longitude;
  dynamic latitude;
  int verifyToken;
  int verifyStatus;
  String id;
  DateTime createdAt;
  String profilePic;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    description: json["description"],
    password: json["password"],
    status: json["status"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    verifyToken: json["verifyToken"],
    verifyStatus: json["verifyStatus"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    profilePic: json["profilePic"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "description": description,
    "password": password,
    "status": status,
    "longitude": longitude,
    "latitude": latitude,
    "verifyToken": verifyToken,
    "verifyStatus": verifyStatus,
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "profilePic": profilePic,
    "__v": v,
  };
}
