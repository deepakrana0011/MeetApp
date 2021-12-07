class Links {
  Links({
    required this.success,
    required this.data,
  });

  bool success;
  List<Datum> data;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
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
    required this.userName,
    required this.type,
    required this.link,
    required this.v,
  });

  String id;
  String userName;
  String type;
  String link;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userName: json["userName"] == null ? null : json["userName"],
    type: json["type"],
    link: json["link"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userName": userName == null ? null : userName,
    "type": type,
    "link": link,
    "__v": v,
  };
}
