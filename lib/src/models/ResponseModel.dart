class ResponseModel {
  final int statusCode;
  final dynamic data;
  final String message;
  final String status;

  ResponseModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.status,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      statusCode: json['statusCode'],
      data: json['data'],
      message: json['message'],
      status: json['status'],
    );
  }
}
