import 'package:floss_fitness_app/bloc/controller/workout_bloc.dart';
import 'package:floss_fitness_app/bloc/state/workout_state.dart';
import 'package:floss_fitness_app/data/models/working_exercise.dart';
import 'package:floss_fitness_app/views/widgets/custom_static_widgets.dart';
import 'package:floss_fitness_app/views/widgets/set_card.dart';
import 'package:floss_fitness_app/views/widgets/workout_app_bar.dart';
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
      child: Builder(
        builder: (context) { return Scaffold(
          appBar: AppBar(
            title: Text(
              Constants.titleOfApp, style: TextStyle(color: Colors.black, letterSpacing: 1.5),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<WorkoutBloc>(context).add(WorkoutEvent(eventType: EventType.endWorkout));
                  },
                  child: const Icon(
                    Icons.check,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
          drawer: const Drawer(),
          body: ListView(
            key: UniqueKey(),
            scrollDirection: Axis.vertical,
            children: _getSetCardsFromState(BlocProvider.of<WorkoutBloc>(context).state),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
            //todo: inspect why first set added is not shown immediately
            BlocProvider.of<WorkoutBloc>(context).add(WorkoutEvent(eventType: EventType.addWorkingExercise));
            await Future.delayed(const Duration(milliseconds: 500));
            setState(() {});
            },
            tooltip: 'Add exercise',
            child: const Icon(Icons.add),
          ),
        );}
      ),
    );
  }

  List<SetCard> _getSetCardsFromState(WorkoutState workoutState){
    List<SetCard> setCards = [];
    for(WorkingExercise workingExercise in workoutState.workingExercises){
      setCards.add(SetCard(workingExerciseId: workingExercise.id));
    }
    return setCards;
  }
}
