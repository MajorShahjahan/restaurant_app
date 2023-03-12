import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/logic/Dish/get_dishes_bloc.dart';
import 'package:restaurant_app/logic/Dish/get_dishes_state.dart';
import 'package:restaurant_app/presentation/widgets/custom_button_widget.dart';
import 'package:restaurant_app/presentation/widgets/text_field_label_widget.dart';
import '../../logic/Dish/get_dishes_event.dart';
import '../widgets/custom_input_text_field.dart';

class CreateNewDishScreen extends StatefulWidget {
  const CreateNewDishScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewDishScreen> createState() => _CreateNewDishScreenState();
}

class _CreateNewDishScreenState extends State<CreateNewDishScreen> {
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController shortDescriptionController =
      TextEditingController();
  late final TextEditingController priceController = TextEditingController();
  late final TextEditingController categoryController = TextEditingController();
  late final TextEditingController availabilityController =
      TextEditingController();
  late final TextEditingController waitTimeController = TextEditingController();
  bool isActive = true;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    nameController.dispose();
    shortDescriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
    availabilityController.dispose();
    waitTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool dropdownValue = true;
    List<bool> itemList = [false, true];
    final createDishBloc = BlocProvider.of<GetDishesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Menu"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: BlocConsumer<GetDishesBloc, GetDishesState>(
              listener: (context, state) {
                if (state is DishCreateSuccessState) {
                  AwesomeDialog(
                    context: context,
                    isDense: false,
                    animType: AnimType.topSlide,
                    dialogType: DialogType.success,
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(("Dish Created").toUpperCase()),
                    ),
                    btnOkOnPress: () {
                      createDishBloc.add(const GetDishesLoadEvent());
                      Navigator.pop(context);
                    },
                  ).show();
                }
                if (state is GetDishesFailureState) {
                  AwesomeDialog(
                    context: context,
                    isDense: false,
                    animType: AnimType.topSlide,
                    dialogType: DialogType.error,
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(("somethingWentWrong").toUpperCase()),
                    ),
                    btnOkOnPress: () {},
                  ).show();
                }
              },
              builder: (context, state) {
                if (state is GetDishesInitialState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: ("Create").toUpperCase(),
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 25,
                                fontWeight: FontWeight.w700)),
                        const WidgetSpan(
                            child: SizedBox(
                          width: 10,
                        )),
                        TextSpan(
                            text: ("Dish").toUpperCase(),
                            style: const TextStyle(
                                color: Color(0xFF1565C0),
                                fontSize: 25,
                                fontWeight: FontWeight.w700))
                      ])),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Dish Name",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        keyboardType: TextInputType.text,
                        hintText: "dish name",
                        controller: nameController,
                        validator: (name) {
                          if (name == null || name.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Description",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        keyboardType: TextInputType.text,
                        hintText: "short description of the dish",
                        controller: shortDescriptionController,
                        validator: (shortDescription) {
                          if (shortDescription == null ||
                              shortDescription.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Price",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        keyboardType: TextInputType.number,
                        hintText: "dish price",
                        controller: priceController,
                        validator: (price) {
                          if (price == null || price.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Category",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        keyboardType: TextInputType.text,
                        hintText: "e.g starter, main course, dessert, beverage",
                        controller: categoryController,
                        validator: (category) {
                          if (category == null || category.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Availability",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        keyboardType: TextInputType.text,
                        hintText:
                            "e.g breakfast, dinner, lunch, weekdays/-ends",
                        controller: availabilityController,
                        validator: (availability) {
                          if (availability == null || availability.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Wait Time",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        keyboardType: TextInputType.number,
                        hintText: "wait time to get ready the dish",
                        controller: waitTimeController,
                        validator: (waitTime) {
                          if (waitTime == null || waitTime.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Active Status",
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        //height: 42,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                color: Colors.lightBlue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                              borderSide: BorderSide(
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                                width: 1.0,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                )),
                            contentPadding: const EdgeInsets.all(10),
                          ),
                          value: dropdownValue,
                          items: itemList
                              .map<DropdownMenuItem<bool>>((bool value) {
                            return DropdownMenuItem<bool>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          validator: (subject) {
                            if (subject == null) {
                              return "requiredField";
                            }
                            return null;
                          },
                          onChanged: (bool? value) {
                            setState(() {
                              dropdownValue = value!;
                              isActive = value;
                            });
                          },
                        ),
                      ),
                      CustomButtonWidget(
                        color: Colors.blue,
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            createDishBloc.add(DishCreateEvent(
                                name: nameController.text,
                                shortDescription:
                                    shortDescriptionController.text,
                                price: double.parse(priceController.text),
                                category: categoryController.text,
                                availability: availabilityController.text,
                                waitTime: int.parse(waitTimeController.text),
                                isActive: isActive));
                          }
                        },
                        label: Text(
                          'Submit'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width < 768
                                ? 15
                                : 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is GetDishesLoadingState) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: ("Create").toUpperCase(),
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 25,
                                fontWeight: FontWeight.w700)),
                        const WidgetSpan(
                            child: SizedBox(
                          width: 10,
                        )),
                        TextSpan(
                            text: ("Dish").toUpperCase(),
                            style: const TextStyle(
                                color: Color(0xFF1565C0),
                                fontSize: 25,
                                fontWeight: FontWeight.w700))
                      ])),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Dish Name",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        keyboardType: TextInputType.text,
                        hintText: "dish name",
                        controller: nameController,
                        validator: (name) {
                          if (name == null || name.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Description",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        keyboardType: TextInputType.text,
                        hintText: "short description of the dish",
                        controller: shortDescriptionController,
                        validator: (shortDescription) {
                          if (shortDescription == null ||
                              shortDescription.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Price",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        hintText: "price of the dish",
                        keyboardType: TextInputType.number,
                        controller: priceController,
                        validator: (price) {
                          if (price == null || price.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Category",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        hintText: "e.g starter, main course, dessert, beverage",
                        keyboardType: TextInputType.text,
                        controller: categoryController,
                        validator: (category) {
                          if (category == null || category.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Availability",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText:
                            "e.g  breakfast, dinner, lunch, weekdays/-ends",
                        margin: const EdgeInsets.only(bottom: 20),
                        keyboardType: TextInputType.text,
                        controller: availabilityController,
                        validator: (availability) {
                          if (availability == null || availability.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Wait Time",
                      ),
                      TextFieldWidget(
                        //textFieldHeight: 42,
                        readOnly: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        hintText: "Wait time to get ready dish",
                        keyboardType: TextInputType.number,
                        controller: waitTimeController,
                        validator: (waitTime) {
                          if (waitTime == null || waitTime.isEmpty) {
                            return "requiredField";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      const TextFieldLabelWidget(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        label: "Active Status",
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        //height: 42,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                color: Colors.lightBlue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                              borderSide: BorderSide(
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                                width: 1.0,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                )),
                            contentPadding: const EdgeInsets.all(10),
                          ),
                          value: dropdownValue,
                          items: itemList
                              .map<DropdownMenuItem<bool>>((bool value) {
                            return DropdownMenuItem<bool>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          validator: (subject) {
                            if (subject == null) {
                              return "requiredField";
                            }
                            return null;
                          },
                          onChanged: (bool? value) {
                            setState(() {
                              dropdownValue = value!;
                              isActive = value;
                            });
                          },
                        ),
                      ),
                      CustomButtonWidget(
                        color: Colors.blue,
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            createDishBloc.add(DishCreateEvent(
                                name: nameController.text,
                                shortDescription:
                                    shortDescriptionController.text,
                                price: double.parse(priceController.text),
                                category: categoryController.text,
                                availability: availabilityController.text,
                                waitTime: int.parse(waitTimeController.text),
                                isActive: isActive));
                          }
                        },
                        label: Text(
                          'Submit'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width < 768
                                ? 15
                                : 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
