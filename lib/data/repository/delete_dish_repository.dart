import 'package:restaurant_app/data/provider/remote_provider/delete_dish_api.dart';

class DeleteDishRepository {
  Future<int?> deleteDish(String id) async {
    final rawData = await DeleteDishApi.getRawData(id: id);
    if (rawData.statusCode >= 200 && rawData.statusCode <= 399) {
      return rawData.statusCode;
    } else {
      return null;
    }
  }
}