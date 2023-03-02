import 'package:flutter/material.dart';

import '../../data/repository/workout_database_repository.dart';
import '../widgets/custom_static_widgets.dart';

class EditExercisePage extends StatefulWidget {
  EditExercisePage({Key? key, required this.exerciseName, required this.isCompound, required this.exerciseId}) : super(key: key);

  //todo: replace with Exercise model
  final String exerciseName;
  final int exerciseId;
  late bool isCompound;

  @override
  State<EditExercisePage> createState() => _EditExercisePageState();
}

class _EditExercisePageState extends State<EditExercisePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameOfExerciseController = TextEditingController();

  @override
  void initState(){
    super.initState();
    nameOfExerciseController.text = widget.exerciseName;
  }

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
                      value: widget.isCompound,
                      onChanged: (a) {
                        setState(() {
                          widget.isCompound = a;
                        });
                      }),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_formKey.currentState!.validate()){
            WorkoutDatabaseRepository.updateExercise(nameOfExerciseController.text, widget.isCompound ? 1 : 0, widget.exerciseId);
            Future.delayed(const Duration(milliseconds: 200));
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
