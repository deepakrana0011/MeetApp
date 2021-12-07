class DioData {
  String id;
  String type;
  String link;
  int v;

  DioData({
    required this.id,
    required this.type,
    required this.link,
    required this.v,
  });
  factory DioData.fromJson(Map<String, dynamic> parsedJson) {
    return DioData(
      id: parsedJson['id'],
      type: parsedJson['type'],
      link: parsedJson['link'],
      v: parsedJson['_v'],
    );
  }
}
