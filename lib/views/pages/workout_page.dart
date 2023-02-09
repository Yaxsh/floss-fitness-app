import 'package:floss_fitness_app/bloc/controller/workout_bloc.dart';
import 'package:floss_fitness_app/bloc/state/workout_state.dart';
import 'package:floss_fitness_app/data/models/working_exercise.dart';
import 'package:floss_fitness_app/views/widgets/working_exercise_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/constants.dart';
import '../../data/models/workout.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    final pushedWorkoutArgument = ModalRoute.of(context)?.settings.arguments as Map<String, Object?>;
    Workout newInsertedWorkout = Workout.fromNewInsertMap(pushedWorkoutArgument);

    return BlocProvider(
      create: (context) => WorkoutBloc(WorkoutState(workout: newInsertedWorkout)),
      child: Builder(builder: (context)  {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              Constants.titleOfApp,
              style: TextStyle(color: Colors.black, letterSpacing: 1.5),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    BlocProvider.of<WorkoutBloc>(context).add(WorkoutEvent(eventType: EventType.endWorkout));
                    //todo: replace with popup to confirm
                    await Future.delayed(const Duration(milliseconds: 200));
                    if(BlocProvider.of<WorkoutBloc>(context).state.workout.isCompleted==1) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Icon(
                    Icons.check,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
          // drawer: const Drawer(),
          body: ListView(
            key: UniqueKey(),
            scrollDirection: Axis.vertical,
            children: _getWorkingExerciseCardsFromState(
                BlocProvider.of<WorkoutBloc>(context).state),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              BlocProvider.of<WorkoutBloc>(context)
                  .add(WorkoutEvent(eventType: EventType.addWorkingExercise));
              await Future.delayed(const Duration(milliseconds: 200));
              setState(() {});
            },
            tooltip: 'Add exercise',
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }

  List<WorkingExerciseCard> _getWorkingExerciseCardsFromState(WorkoutState workoutState) {
    List<WorkingExerciseCard> setCards = [];
    for (WorkingExercise workingExercise in workoutState.workingExercises) {
      setCards.add(WorkingExerciseCard(
          workingExerciseId: workingExercise.id,
          exercises: workoutState.exercises)
      );
    }
    return setCards;
  }
}
