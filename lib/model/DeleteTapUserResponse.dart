class DeleteTapUserResponse {
  DeleteTapUserResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory DeleteTapUserResponse.fromJson(Map<String, dynamic> json) => DeleteTapUserResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
