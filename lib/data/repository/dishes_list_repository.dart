import 'dart:convert';
import 'package:restaurant_app/data/model/dish_response_model/dish_response_model.dart';
import 'package:restaurant_app/data/provider/remote_provider/get_dishes_api.dart';

class DishesListRepository {
  Future<List<DishResponseModel>?> getDishesListData() async {
    final rawData = await DishesListApi.getRawData();
    if (rawData.statusCode >= 200 && rawData.statusCode <= 399) {
      final jsonData = json.decode(rawData.body);
      final data = jsonData['data'];
      final dishes = List<DishResponseModel>.from(
          data.map((e) => DishResponseModel.fromJson(e)));
      return dishes;
    } else {
      return null;
    }
  }
}
