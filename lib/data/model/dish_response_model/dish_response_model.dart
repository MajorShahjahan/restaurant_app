class DishResponseModel {
  String? id;
  String? name;
  String? shortDescription;
  double? price;
  String? category;
  String? availability;
  bool? isActive;
  int? waitTime;

  DishResponseModel({
    this.id,
    this.name,
    this.shortDescription,
    this.price,
    this.category,
    this.availability,
    this.isActive,
    this.waitTime,
  });

  factory DishResponseModel.fromJson(Map<String, dynamic> json) {
    return DishResponseModel(
      id: json['_id'],
      name: json['name'],
      shortDescription: json['shortDescription'],
      price: json['price'].toDouble(),
      category: json['category'],
      availability: json['availability'],
      isActive: json['isActive'],
      waitTime: json['waitTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'shortDescription': shortDescription,
        'price': price,
        'category': category,
        'availability': availability,
        'isActive': isActive,
        'waitTime': waitTime,
      };
}
