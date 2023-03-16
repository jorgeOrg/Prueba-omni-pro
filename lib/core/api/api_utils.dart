import 'dart:async';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prueba_tecnica/core/models/result.dart';

import '../../ui/utils/constants.dart';
import 'error_handler.dart';


class ApiUtils {
  static const int timeOutDuration = 35;
  //GET
  Future<Result<dynamic, BackendError>> get(String path) async {
    var uri = Uri.parse("https://$kHost$path");
    try {
      var response =
          await http.get(uri).timeout(const Duration(seconds: timeOutDuration));
        final data = json.decode(response.body);
      return Result.success(data);
    } on HttpException catch (e) {
      return Result.fail(
        BackendError(
          statusCode: 408,
          data: const {},
          description: e.message,
          err: e.message
        )
      );
    }
  }

  //POST
  Future<Result<dynamic, BackendError>> post(String path, dynamic payloadObj) async {
    var uri = Uri.parse("https://$kHost$path");
    var payload = jsonEncode(payloadObj);
    try {
      var response = await http
          .post(uri, body: payload)
          .timeout(const Duration(seconds: timeOutDuration));

      return Result.success(response.body);
    } on HttpException catch (e) {
      return Result.fail(
        BackendError(
          statusCode: 408,
          data: e.message as Map,
          description: e.message ,
          err: e.message.toString()
        )
      );
    }
  }

  //HERE OTHERS METHODS

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        return responseJson;
      case 400: //Bad request
        throw BadRequestException(jsonDecode(response.body)['message']);
      case 401: //Unauthorized
        throw UnAuthorizedException(jsonDecode(response.body)['message']);
      case 403: //Forbidden
        throw UnAuthorizedException(jsonDecode(response.body)['message']);
      case 404: //Resource Not Found
        throw NotFoundException(jsonDecode(response.body)['message']);
      case 500: //Internal Server Error
      default:
        throw FetchDataException(
            'Something went wrong! ${response.statusCode}');
    }
  }
}