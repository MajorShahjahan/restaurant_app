import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/dish_response_model/dish_response_model.dart';

@immutable
abstract class GetDishesState extends Equatable {
  const GetDishesState();

  @override
  List<Object?> get props => [];
}

class GetDishesInitialState extends GetDishesState {
  const GetDishesInitialState();
}

class GetDishesLoadingState extends GetDishesState {
  const GetDishesLoadingState();
}

class GetDishesSuccessState extends GetDishesState {
  final List<DishResponseModel>? dishes;

  const GetDishesSuccessState({this.dishes});

  @override
  List<Object?> get props => [dishes];
}

class GetDishesFailureState extends GetDishesState {
  final String errorMessage;

  const GetDishesFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class DishCreateSuccessState extends GetDishesState {
  final DishResponseModel dish;

  const DishCreateSuccessState({required this.dish});

  @override
  List<Object?> get props => [dish];
}

class DishSelectedUpdateSuccessState extends GetDishesState {
  final DishResponseModel dish;

  const DishSelectedUpdateSuccessState({required this.dish});

  @override
  List<Object?> get props => [dish];
}

class DishSelectedDeleteSuccessState extends GetDishesState {
  const DishSelectedDeleteSuccessState();

  @override
  List<Object?> get props => [];
}
