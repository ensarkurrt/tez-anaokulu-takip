class NetworkResponse<T> {
  final bool? success;
  final int? currentTime;
  final T? data;
  final List<String>? errors;
  final String? error;
  final int? errorCode;

  NetworkResponse({
    this.success,
    this.currentTime,
    this.data,
    this.errors,
    this.error,
    this.errorCode,
  });

  factory NetworkResponse.fromJson(Map<String, dynamic> json, T Function(dynamic json)? fromJsonT) {
    return NetworkResponse(
      success: json['success'],
      currentTime: json['currentTime'],
      errors: json['errorDetails'] != null ? List<String>.from(json['errorDetails']) : null,
      error: json['error'] as String?,
      errorCode: json['errorCode'] as int?,
      data: fromJsonT != null && json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  @override
  String toString() {
    return 'NetworkResponse{success: $success, currentTime: $currentTime, data: $data, errors: $errors, error: $error, errorCode: $errorCode}';
  }
}
