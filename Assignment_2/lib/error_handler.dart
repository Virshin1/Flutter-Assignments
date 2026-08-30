/// Custom exception class for API-related failures
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException [Status ${statusCode ?? "N/A"}]: $message';
}

/// Helper function with `Never` return type that throws an ApiException
/// Demonstrates the `Never` return type concept from advanced null safety
Never throwApiException(String message, {int? statusCode}) {
  throw ApiException(message, statusCode: statusCode);
}

/// Validates raw response payloads for mandatory root structures
void validatePayloadPresence(Object? payload, {String contextName = 'Payload'}) {
  if (payload == null) {
    throwApiException('$contextName cannot be null or empty', statusCode: 400);
  }
}
