import 'package:floss_fitness_app/views/widgets/custom_static_widgets.dart';
import 'package:floss_fitness_app/views/widgets/workout_card.dart';
import 'package:flutter/material.dart';

import '../../data/models/workout.dart';
import '../../data/repository/workout_database_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //todo: read workout from db, call selectAllWorkouts()!!
  List<WorkoutCard> workoutCardList = [const WorkoutCard()];

  Workout? newWorkout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      drawer: const Drawer(),
      body: ListView(
        key: UniqueKey(),
        scrollDirection: Axis.vertical,
        children: workoutCardList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => {
          newWorkout = await WorkoutDatabaseRepository.createAndReturnNewWorkoutInDb(),
          Navigator.pushNamed(context, '/workout', arguments: newWorkout?.toMap())
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
