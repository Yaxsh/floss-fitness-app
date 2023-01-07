import 'package:floss_fitness_app/bloc/controller/workout_bloc.dart';
import 'package:floss_fitness_app/bloc/state/workout_state.dart';
import 'package:floss_fitness_app/views/widgets/custom_wigets.dart';
import 'package:floss_fitness_app/views/widgets/set_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/workout.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {

  //todo: replace with reading from bloc state
  List<SetCard> setCardsList = [const SetCard()];

  @override
  Widget build(BuildContext context) {
    final pushedWorkoutArgument = ModalRoute.of(context)?.settings.arguments as Map<String, Object?>;
    Workout newInsertedWorkout = Workout.fromNewInsertMap(pushedWorkoutArgument);

    return BlocProvider(
      create: (context) => WorkoutBloc(WorkoutState(newInsertedWorkout)),
      child: Scaffold(
        appBar: CustomWidgets.getAppBar(),
        drawer: const Drawer(),
        body: ListView(
          key: UniqueKey(),
          scrollDirection: Axis.vertical,
          children: setCardsList,
        ),
        floatingActionButton: FloatingActionButton(
          //todo: add bloc event addExercise to onPressed
          onPressed: () => _addSet(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _addSet() {
    setCardsList.add(const SetCard());
    setState(() {});
  }

}
