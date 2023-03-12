import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/dish_response_model/dish_response_model.dart';
import 'package:restaurant_app/utilities/constants/constants.dart';
import 'package:restaurant_app/utilities/exceptions/exception_handler.dart';

class CreateDishApi {
  Future<http.Response> getRawData({
    required String name,
    required String shortDescription,
    required double price,
    required String category,
    required String availability,
    required bool isActive,
    required int waitTime,
  }) async {
    final http.Response response;
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final DishResponseModel body = DishResponseModel(
        name: name,
        shortDescription: shortDescription,
        price: price,
        category: category,
        availability: availability,
        isActive: isActive,
        waitTime: waitTime);

    try {
      response = await http.post(
        Uri.parse("$baseUrl/insertDish"),
        body: jsonEncode(body.toJson()),
        headers: headers,
      );
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
