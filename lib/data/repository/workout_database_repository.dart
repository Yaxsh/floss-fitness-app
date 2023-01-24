import 'package:floss_fitness_app/data/models/set.dart';
import 'package:floss_fitness_app/data/models/working_exercise.dart';

import '../data_providers/workout_database_provider.dart';
import '../models/workout.dart';

class WorkoutDatabaseRepository{
  WorkoutDatabaseRepository();

  static Future<Workout> createAndReturnNewWorkoutInDb() async {
    Map<String, Object?> insertedWorkoutMap = await WorkoutDatabaseProvider.insertWorkoutAndReturn();
    return Workout.fromNewInsertMap(insertedWorkoutMap);
  }

  Future<WorkingExercise> addNewWorkingExercise() async {
    Map<String, Object?> insertedWorkingExercise = await WorkoutDatabaseProvider.insertWorkoutExerciseAndReturn();
    return WorkingExercise.fromNewInsertMap(insertedWorkingExercise);
  }

  Future<SetW> addNewWorkingSet(SetW set) async {
    Map<String, Object?> insertedWorkingExercise = await WorkoutDatabaseProvider.insertWorkoutSetAndReturn(set);
    return SetW.fromNewInsertMap(insertedWorkingExercise);
  }
}