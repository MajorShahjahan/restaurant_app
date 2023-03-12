import 'package:bloc/bloc.dart';
import 'package:restaurant_app/data/provider/remote_provider/create_dish_api.dart';
import 'package:restaurant_app/data/provider/remote_provider/update_dish_api.dart';
import 'package:restaurant_app/data/repository/create_dish_repository.dart';
import 'package:restaurant_app/data/repository/delete_dish_repository.dart';
import 'package:restaurant_app/data/repository/dishes_list_repository.dart';
import 'package:restaurant_app/data/repository/update_dish_repository.dart';
import 'get_dishes_event.dart';
import 'get_dishes_state.dart';

class GetDishesBloc extends Bloc<GetDishesEvent, GetDishesState> {
  GetDishesBloc() : super(const GetDishesInitialState()) {
    on<GetDishesLoadEvent>((event, emit) async {
      emit(const GetDishesLoadingState());
      final DishesListRepository repository = DishesListRepository();
      final result = await repository.getDishesListData();
      if (result == null) {
        emit(
            const GetDishesFailureState(errorMessage: "Failed to load Dishes"));
      } else {
        emit(const GetDishesLoadingState());
        emit(GetDishesSuccessState(dishes: result));
      }
    });
    on<DishCreateEvent>((event, emit) async {
      emit(const GetDishesLoadingState());
      final CreateDishRepository repository = CreateDishRepository(
          createDishApi: CreateDishApi(),
          name: event.name,
          shortDescription: event.shortDescription,
          price: event.price,
          category: event.category,
          availability: event.availability,
          isActive: event.isActive,
          waitTime: event.waitTime);
      final result = await repository.postDishData();

      if (result == null) {
        emit(
            const GetDishesFailureState(errorMessage: "some thing went wrong"));
      } else {
        emit(const GetDishesLoadingState());
        emit(DishCreateSuccessState(dish: result));
      }
    });
    on<DishSelectedUpdateEvent>((event, emit) async {
      emit(const GetDishesLoadingState());
      final UpdateDishRepository repository = UpdateDishRepository(
          updateDishApi: UpdateDishApi(),
          id: event.id,
          name: event.name,
          shortDescription: event.shortDescription,
          price: event.price,
          category: event.category,
          availability: event.availability,
          isActive: event.isActive,
          waitTime: event.waitTime);
      final result = await repository.putDishData();

      if (result == null) {
        emit(
            const GetDishesFailureState(errorMessage: "some thing went wrong"));
      } else {
        emit(const GetDishesLoadingState());
        emit(DishSelectedUpdateSuccessState(dish: result));
      }
    });
    on<DishSelectedDeleteEvent>((event, emit) async {
      emit(const GetDishesLoadingState());
      final DeleteDishRepository repository = DeleteDishRepository();
      final result = await repository.deleteDish(event.id);
      if (result! >= 200 && result <= 399) {
        emit(const GetDishesLoadingState());
        emit(const DishSelectedDeleteSuccessState());
      } else {
        emit(
            const GetDishesFailureState(errorMessage: "Failed to Delete Dish"));
      }
    });
  }
}
