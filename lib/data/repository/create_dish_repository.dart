import 'dart:convert';
import 'package:restaurant_app/data/model/dish_response_model/dish_response_model.dart';
import 'package:restaurant_app/data/provider/remote_provider/create_dish_api.dart';

class CreateDishRepository {
  final CreateDishApi createDishApi;
  final String name;
  final String shortDescription;
  final double price;
  final String category;
  final String availability;
  final bool isActive;
  final int waitTime;

  const CreateDishRepository(
      {required this.createDishApi,
      required this.name,
      required this.shortDescription,
      required this.price,
      required this.category,
      required this.availability,
      required this.isActive,
      required this.waitTime});

  Future<DishResponseModel?> postDishData() async {
    final rawData = await createDishApi.getRawData(
        name: name,
        shortDescription: shortDescription,
        price: price,
        category: category,
        availability: availability,
        isActive: isActive,
        waitTime: waitTime);
    if (rawData.statusCode >= 200 && rawData.statusCode <= 399) {
      final jsonData = json.decode(rawData.body);
      final data = jsonData['data'];
      final newDish = DishResponseModel.fromJson(data);
      return newDish;
    } else {
      return null;
    }
  }
}
