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
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => WorkoutBloc(WorkoutState(workout: newInsertedWorkout)),
      child: Builder(builder: (context)  {
        return WillPopScope(
          onWillPop: () async { 
            debugPrint('XD');
            showDialog(context: context,
                builder: (context) =>
                AlertDialog(
                    title: Text("End workout?"),
                    content: Text("Are you sure you want to end the workout without saving?"),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(onPressed: (){debugPrint('xd'); Navigator.pop(context); Navigator.pop(context);}, child: Text('yes')),
                          Padding(padding: EdgeInsets.only(right: 15)),
                          OutlinedButton(onPressed: (){debugPrint('xd111'); Navigator.pop(context);}, child: Text('no')),
                        ],
                      ),
                    ],
                ),
            );
            return false; 
            },
          child: Scaffold(
            key: scaffoldKey,
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
                      if(BlocProvider.of<WorkoutBloc>(context).state.workingExercises.isEmpty || BlocProvider.of<WorkoutBloc>(context).state.workingExercises.any((element) => element.isCompleted!=1)){
                        String textForSnackBar =  BlocProvider.of<WorkoutBloc>(context).state.workingExercises.isEmpty ? 'Add exercises to workout' : 'Finish all exercises';
                        SnackBar snackBar = SnackBar(
                          content: Text(textForSnackBar),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      else {
                        Navigator.pop(context);
                      }
                    },
                    child: const Icon(
                      Icons.check,
                      size: 35.0,
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
          ),
        );
      }),
    );
  }

  List<WorkingExerciseCard> _getWorkingExerciseCardsFromState(WorkoutState workoutState) {
    List<WorkingExerciseCard> workingExerciseCards = [];
    for (WorkingExercise workingExercise in workoutState.workingExercises) {
      String? selectedExercise = workoutState.nameOfWorkingExerciseByName[workingExercise.id];
      workingExerciseCards.add(WorkingExerciseCard(
          workingExerciseId: workingExercise.id,
          exercises: workoutState.exercises,
          selectedValue: selectedExercise,
          isOngoing: workingExercise.isCompleted == 1 ? false : true,
        ),
      );
    }
    return workingExerciseCards;
  }
}
