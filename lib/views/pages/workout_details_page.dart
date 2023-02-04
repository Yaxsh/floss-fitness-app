import 'package:floss_fitness_app/data/models/working_exercise.dart';
import 'package:flutter/material.dart';
import 'package:floss_fitness_app/data/models/workout.dart';
import 'package:floss_fitness_app/views/widgets/custom_static_widgets.dart';
import '../../data/repository/workout_database_repository.dart';
import '../widgets/finished_working_exercise_card.dart';

class WorkoutDetailsPage extends StatefulWidget {
  WorkoutDetailsPage({Key? key, required this.workout}) : super(key: key);

  final Workout workout;
  final List<FinishedWorkingExerciseCard> workingExercises = [];

  @override
  State<WorkoutDetailsPage> createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.workout.toString());
    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      //todo: replace single future with multiple futures because future in FinishedWorkingExerciseCard is stopping the render process
      body: FutureBuilder<List<Map<String, Object?>>>(
        future: WorkoutDatabaseRepository.getAllWorkingExercisesForWorkoutId(widget.workout.id!),
        builder: (BuildContext buildContext,AsyncSnapshot<List<Map<String, Object?>>> asyncSnap) {
          if(!asyncSnap.hasData || asyncSnap.data == null) {
            debugPrint('ENTERING NULL IF');
            return Center(child: CircularProgressIndicator());
          }
          else{
            debugPrint('ENTERING ELSE NON-NULL, DATA: ${asyncSnap.data}');
            return ListView(
                key: UniqueKey(),
                scrollDirection: Axis.vertical,
                children: _getFinishedWorkingExerciseCardsFromDB(asyncSnap.data!)
            );
          }
        }
      ),
    );
  }

  List<FinishedWorkingExerciseCard> _getFinishedWorkingExerciseCardsFromDB(List<Map<String, Object?>> workingExercisesListOfMaps){
    List<FinishedWorkingExerciseCard> finishedWorkingExerciseCards = [];
    for(Map<String, Object?> workingExerciseMap in workingExercisesListOfMaps){
      finishedWorkingExerciseCards.add(FinishedWorkingExerciseCard(finishedWorkingExercise: WorkingExercise.fromEndedUpdateMap(workingExerciseMap)));
    }
    return finishedWorkingExerciseCards;
  }
}
