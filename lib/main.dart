import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/logic/Dish/get_dishes_bloc.dart';
import 'package:restaurant_app/presentation/screens/home_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => GetDishesBloc()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        )),
  );
}
