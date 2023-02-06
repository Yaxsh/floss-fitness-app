import 'package:floss_fitness_app/data/models/exercise.dart';
import 'package:floss_fitness_app/views/widgets/custom_static_widgets.dart';
import 'package:flutter/material.dart';

import '../../data/repository/workout_database_repository.dart';

class ExercisesDetailsPage extends StatefulWidget {
  const ExercisesDetailsPage({Key? key}) : super(key: key);

  @override
  State<ExercisesDetailsPage> createState() => _ExercisesDetailsPageState();
}

class _ExercisesDetailsPageState extends State<ExercisesDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameOfExerciseController =
      TextEditingController();
  late bool isCompound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            //todo: center in cross axis
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameOfExerciseController,
                validator: (value) {
                  //todo: check if name already exists
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid name";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: 'Name of exercise'),
              ),
              Row(
                children: [
                  Text("Is compound: "),
                  Switch(
                      value: isCompound,
                      onChanged: (a) {
                        setState(() {
                          isCompound = a;
                        });
                      }),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(_formKey.currentState!.validate()){
            WorkoutDatabaseRepository.insertExercise(nameOfExerciseController.text, isCompound);
            Future.delayed(const Duration(milliseconds: 200));
            Navigator.pop(context);
          }
        },
        tooltip: 'Add a new exercise',
        child: Icon(Icons.check),
      ),
    );
  }
}
