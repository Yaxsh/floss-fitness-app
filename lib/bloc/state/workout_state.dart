import 'package:floss_fitness_app/data/models/workout.dart';
import 'package:floss_fitness_app/data/models/set.dart';
import 'package:floss_fitness_app/data/models/working_exercise.dart';
import 'package:floss_fitness_app/data/models/exercise.dart';

class WorkoutState{
  late Workout workout;
  late List<SetW> sets;
  late List<WorkingExercise> workingExercises;
  Map<int, String> nameOfWorkingExerciseByName = <int, String>{};
  List<Exercise> exercises = [];
  late bool isExerciseListRead;

  WorkoutState({required this.workout}){
    sets = [];
    //todo: add a working exercise by default
    workingExercises = [];
    isExerciseListRead = false;
  }
}