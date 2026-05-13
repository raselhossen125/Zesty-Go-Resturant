import 'package:dio/dio.dart';

class ApiResponse {
  final dynamic response; // Response type-er poriborte dynamic korun
  final dynamic error;

  ApiResponse(this.response, this.error);

  ApiResponse.withError(dynamic errorValue)
      : response = null,
        error = errorValue;

  ApiResponse.withSuccess(dynamic responseValue) // Ekhon eta QuerySnapshot ba Response sob-i nibe
      : response = responseValue,
        error = null;
}