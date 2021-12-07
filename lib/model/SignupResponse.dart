

class SignupResponse {
  SignupResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.token,
  });

  bool success;
  String message;
  Data? data;
  String token;

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
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
    required this.profilePic,
    required this.dob,
    required this.email,
    required this.description,
    required this.password,
    required this.status,
    required this.longitude,
    required this.latitude,
    required this.id,
    required this.createdAt,
    required this.v,
  });

  String firstName;
  String lastName;
  String profilePic;
  String dob;
  String email;
  String description;
  String password;
  int status;
  double longitude;
  double latitude;
  String id;
  DateTime createdAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["firstName"],
    lastName: json["lastName"],
    profilePic: json["profilePic"],
    dob: json["dob"],
    email: json["email"],
    description: json["description"],
    password: json["password"],
    status: json["status"],
    longitude: json["longitude"].toDouble(),
    latitude: json["latitude"].toDouble(),
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "profilePic": profilePic,
    "dob": dob,
    "email": email,
    "description": description,
    "password": password,
    "status": status,
    "longitude": longitude,
    "latitude": latitude,
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
  };
}
