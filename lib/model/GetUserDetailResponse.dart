class GetUserDetailResponse {
  GetUserDetailResponse({
    required this.success,
    required this.data,
  });

  bool success;
  List<Datum> data;

  factory GetUserDetailResponse.fromJson(Map<String, dynamic> json) => GetUserDetailResponse(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
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
    required this.userdetails,
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
  List<Userdetail> userdetails;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    dob: json["dob"],
    email: json["email"],
    description: json["description"],
    password: json["password"],
    status: json["status"],
    longitude: json["longitude"]!=null?json["longitude"].toDouble():0.0,
    latitude: json["latitude"]!=null?json["latitude"].toDouble():0.0,
    verifyToken: json["verifyToken"],
    verifyStatus: json["verifyStatus"],
    createdAt: DateTime.parse(json["createdAt"]),
    profilePic: json["profilePic"],
    v: json["__v"],
    userdetails: List<Userdetail>.from(json["userdetails"].map((x) => Userdetail.fromJson(x))),
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
    "userdetails": List<dynamic>.from(userdetails.map((x) => x.toJson())),
  };
}

class Userdetail {
  Userdetail({
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

  factory Userdetail.fromJson(Map<String, dynamic> json) => Userdetail(
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
