import 'package:floss_fitness_app/views/widgets/custom_static_widgets.dart';
import 'package:flutter/material.dart';

class ExercisesDetailsPage extends StatefulWidget {
  const ExercisesDetailsPage({Key? key}) : super(key: key);

  @override
  State<ExercisesDetailsPage> createState() => _ExercisesDetailsPageState();
}

class _ExercisesDetailsPageState extends State<ExercisesDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      body: Center(
        child: Text("exercise-details page")
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {debugPrint("ADD NEW EX");},
        tooltip: 'Add a new exercise',
        child: Icon(Icons.add),
      ),
    );
  }
}
