class GetLocationResponse {
  GetLocationResponse({
    required this.success,
    required this.data,
  });

  bool success;
  List<Datum> data;

  factory GetLocationResponse.fromJson(Map<String, dynamic> json) => GetLocationResponse(
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
    required this.longitude,
    required this.latitude,
  });

  String id;
  String firstName;
  String lastName;
  double longitude;
  double latitude;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    longitude: json["longitude"].toDouble(),
    latitude: json["latitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "longitude": longitude,
    "latitude": latitude,
  };
}
