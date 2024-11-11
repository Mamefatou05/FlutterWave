import 'TrasactionModel.dart';

class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? errorMessage;
  final int statusCode;

  ApiResponse({
    required this.success,
    this.data,
    this.errorMessage,
    required this.statusCode,
  });

  factory ApiResponse.success(T data, int statusCode) {
    return ApiResponse(
      success: true,
      data: data,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.error(String message, int statusCode) {
    return ApiResponse(
      success: false,
      errorMessage: message,
      statusCode: statusCode,
    );
  }

  static ApiResponse<TransferResponseDto> fromJson(Map<String, dynamic> json) {
    // Si c'est une réponse d'erreur
    if (json['status'] == 'ECHEC') {
      return ApiResponse<TransferResponseDto>.error(
        json['message']['data'] as String,
        json['statusCode'] as int,
      );
    }

    // Si c'est une réponse de succès
    return ApiResponse<TransferResponseDto>.success(
      TransferResponseDto.fromJson(json['data'] as Map<String, dynamic>),
      json['statusCode'] as int,
    );
  }
}