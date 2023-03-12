import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class GetDishesEvent {
  const GetDishesEvent();
}

class GetDishesLoadEvent extends GetDishesEvent {
  const GetDishesLoadEvent();
}

class DishCreateEvent extends GetDishesEvent {
  final String name;
  final String shortDescription;
  final double price;
  final String category;
  final String availability;
  final bool isActive;
  final int waitTime;

  const DishCreateEvent(
      {required this.name,
      required this.shortDescription,
      required this.price,
      required this.category,
      required this.availability,
      required this.isActive,
      required this.waitTime});
}

class DishSelectedUpdateEvent extends GetDishesEvent {
  final String id;
  final String name;
  final String shortDescription;
  final double price;
  final String category;
  final String availability;
  final bool isActive;
  final int waitTime;

  const DishSelectedUpdateEvent(
      {required this.id,
      required this.name,
      required this.shortDescription,
      required this.price,
      required this.category,
      required this.availability,
      required this.isActive,
      required this.waitTime});
}

class DishSelectedDeleteEvent extends GetDishesEvent {
  final String id;

  const DishSelectedDeleteEvent({required this.id});
}
