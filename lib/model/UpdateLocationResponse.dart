class UpdateLocationResponse {
  UpdateLocationResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory UpdateLocationResponse.fromJson(Map<String, dynamic> json) =>
      UpdateLocationResponse(
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
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
    required this.description,
    required this.status,
    required this.longitude,
    required this.latitude,
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
        status: json["status"],
        longitude:
            json["longitude"] != null ? json["longitude"].toDouble() : 0.0,
        latitude: json["latitude"] != null ? json["latitude"].toDouble() : 0.0,
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
        "createdAt": createdAt.toIso8601String(),
        "profilePic": profilePic,
        "__v": v,
      };
}
