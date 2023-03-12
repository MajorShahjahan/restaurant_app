import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/utilities/constants/constants.dart';
import 'package:restaurant_app/utilities/exceptions/exception_handler.dart';

class DishesListApi {
  static Future<http.Response> getRawData() async {
    final http.Response response;

    try {
      response = await http.get(Uri.parse("$baseUrl/dishes"));
    } on TimeoutException {
      throw TimeoutException("Timed out");
    } on SocketException {
      throw NoInternetException("No Internet");
    } on HttpException {
      throw NoServiceFoundException("No Service Found");
    } catch (e) {
      throw UnknownException(e.toString());
    }
    return response;
  }
}
