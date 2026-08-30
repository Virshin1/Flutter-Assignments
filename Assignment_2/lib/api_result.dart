/// Sealed class hierarchy representing the result of an asynchronous API operation
sealed class ApiResult<T> {}

/// Successful API response carrying strongly-typed data
class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  final int statusCode;

  ApiSuccess(this.data, {this.statusCode = 200});
}

/// Failed API response with error message and optional status code
class ApiError<T> extends ApiResult<T> {
  final String errorMessage;
  final int? statusCode;

  ApiError(this.errorMessage, {this.statusCode});
}

/// Empty API response (e.g. 404 Not Found or null content)
class ApiEmpty<T> extends ApiResult<T> {
  final String message;

  ApiEmpty({this.message = 'No data found for the requested resource.'});
}
