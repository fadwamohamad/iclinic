import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  int? _errorCode;
  dynamic? _errorMessage = "";

  ServerError.withError({DioError? error}) {
    _handleError(error!);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        _errorMessage = "Request was cancelled";
        break;
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.other:
        _errorMessage = "Connection failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.response:
        if (error.response!.data is Map) {
          /*  Map<String, dynamic> body = error.response!.data;
          final message = body["message"];
          if (message != null) {
            _errorMessage = message;
          } else {*/
          _errorMessage = error.response!.data; //"Received invalid status code: ${error.response.statusCode}";
          //  }
        } else {
          _errorMessage = error.response!.data; //"Received invalid status code: ${error.response.statusCode}";
        }

        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        break;
    }
    return _errorMessage;
  }
}
