class ResendResponse {
  ResendResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory ResendResponse.fromJson(Map<String, dynamic> json) => ResendResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}