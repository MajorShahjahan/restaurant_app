import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/logic/Dish/get_dishes_bloc.dart';
import 'package:restaurant_app/logic/Dish/get_dishes_event.dart';
import 'package:restaurant_app/logic/Dish/get_dishes_state.dart';
import 'package:restaurant_app/presentation/screens/create_new_dish.dart';
import 'package:restaurant_app/presentation/screens/update_dish_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final GetDishesBloc dishesBloc;
  @override
  void initState() {
    super.initState();
    dishesBloc = BlocProvider.of<GetDishesBloc>(context);
    dishesBloc.add(const GetDishesLoadEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetDishesBloc,GetDishesState>(
        listener: (context,state){
          if (state is DishSelectedDeleteSuccessState) {
            AwesomeDialog(
              context: context,
              isDense: false,
              animType: AnimType.topSlide,
              dialogType: DialogType.success,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(("Dish Deleted")
                    .toUpperCase()),
              ),
              btnOkOnPress: () {
                dishesBloc.add(const GetDishesLoadEvent());
              },
            ).show();
          }
          if(state is GetDishesFailureState){
            AwesomeDialog(
              context: context,
              isDense: false,
              animType: AnimType.topSlide,
              dialogType: DialogType.error,
              body: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text("some thing went wrong"),
              ),
              btnOkOnPress: () {},
            ).show();
          }
        },
        builder: (context,state){
          if(state is GetDishesInitialState){
            return Scaffold(
              appBar: AppBar(
                title: const Text("Restaurant Menu"),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            );
          }else if(state is GetDishesLoadingState){
            return Scaffold(
              appBar: AppBar(
                title: const Text("Restaurant Menu"),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNewDishScreen()));
                    },
                  )
                ],
              ),
              body: const SafeArea(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }else if(state is GetDishesSuccessState){
            return Scaffold(
              appBar: AppBar(
                title: const Text("Restaurant Menu"),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNewDishScreen()));
                    },
                  )
                ],
              ),
              body: SafeArea(
                child: ListView.builder(
                  itemCount: state.dishes!.length,
                    itemBuilder: (context,index){
                    final dish = state.dishes![index];
                    return Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: const Color(0xFF1565C0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(dish.name.toString().toUpperCase(),style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500
                                    ),),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            UpdateDishScreen(
                                              id: dish.id as String,
                                              name: dish.name as String,
                                              shortDescription: dish.shortDescription as String,
                                              price: dish.price,
                                              category: dish.category as String,
                                              availability: dish.availability as String,
                                              waitTime: dish.waitTime,

                                            )));
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        dishesBloc.add(DishSelectedDeleteEvent(id: dish.id as String));
                                        dishesBloc.add(const GetDishesLoadEvent());
                                      },
                                    ),
                                  ],),

                                ],
                              ),
                              Text("Price: ${dish.price.toString()}€",style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                              )),
                              const SizedBox(height: 10,),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Description: ${dish.shortDescription.toString()}", style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    )),
                                    const SizedBox(height: 10,),
                                    Text("Category: ${dish.category.toString()}", style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    )),
                                    const SizedBox(height: 10,),
                                    Text("Availability: ${dish.availability.toString()}", style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    )),
                                    const SizedBox(height: 10,),
                                    Text("Wait Time: ${dish.waitTime.toString()}mint", style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    )),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                    }
                ),
              ),
            );
          } else{
            return  Scaffold(
              appBar: AppBar(
                title: const Text("Restaurant Menu"),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNewDishScreen()));
                    },
                  )
                ],
              ),
            );
          }
        },
    );
  }
}
