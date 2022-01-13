class VerifyResponse {
  VerifyResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory VerifyResponse.fromJson(Map<String, dynamic> json) => VerifyResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
