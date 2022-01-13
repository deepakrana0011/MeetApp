class LoginResponse {
  LoginResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.token,
  });

  bool success;
  String message;
  Data? data;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
    required this.description,
    required this.password,
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
  String password;
  int status;
  double longitude;
  double latitude;
  dynamic verifyToken;
  int verifyStatus;
  DateTime createdAt;
  String profilePic;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    dob: json["dob"],
    email: json["email"],
    description: json["description"],
    password: json["password"],
    status: json["status"],
    longitude: json["longitude"].toDouble(),
    latitude: json["latitude"].toDouble(),
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
    "password": password,
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
