import 'package:floss_fitness_app/data/models/set.dart';
import 'package:floss_fitness_app/data/models/working_exercise.dart';
import 'package:flutter/cupertino.dart';

import '../data_providers/workout_database_provider.dart';
import '../models/workout.dart';

class WorkoutDatabaseRepository{
  WorkoutDatabaseRepository();

  static Future<Workout> createAndReturnNewWorkoutInDb() async {
    Map<String, Object?> insertedWorkoutMap = await WorkoutDatabaseProvider.insertWorkoutAndReturn();
    return Workout.fromNewInsertMap(insertedWorkoutMap);
  }

  Future<WorkingExercise> addNewWorkingExercise(int workoutId) async {
    Map<String, Object?> insertedWorkingExercise = await WorkoutDatabaseProvider.insertWorkoutExerciseAndReturn(workoutId);
    return WorkingExercise.fromNewInsertMap(insertedWorkingExercise);
  }

  Future<SetW> addNewWorkingSet(SetW set) async {
    Map<String, Object?> insertedWorkingExercise = await WorkoutDatabaseProvider.insertWorkoutSetAndReturn(set);
    return SetW.fromNewInsertMap(insertedWorkingExercise);
  }

  Future<WorkingExercise> endWorkingExercise(int workingExerciseId) async {
    Map<String, Object?> insertedWorkingExercise = await WorkoutDatabaseProvider.endWorkoutExerciseAndReturn(workingExerciseId);
    return WorkingExercise.fromNewInsertMap(insertedWorkingExercise);
  }

  Future<SetW> endSetFromWorkingExercise(int setId, int reps, int weight) async {
    //todo: add exercise id
    Map<String, Object?> endedSetFromWorkingExercise = await WorkoutDatabaseProvider.endWorkoutSetAndReturn(setId, reps, weight);
    return SetW.fromEndedSetMap(endedSetFromWorkingExercise);
  }

  Future<Workout> endWorkout(int workoutId) async {
    Map<String, Object?> endedWorkoutMap = await WorkoutDatabaseProvider.endWorkoutAndReturn(workoutId);
    return Workout.fromEndUpdateMap(endedWorkoutMap);
  }

  static Future<List<Map<String, Object?>>> getAllFinishedWorkouts() async {
    debugPrint("EXECUTED STATIC FUNC!");
    List<Map<String, Object?>> workoutsMap = await WorkoutDatabaseProvider.selectAllWorkouts();
    return workoutsMap;
    // List<Workout> workoutsList = [];
    // debugPrint("MAP: $workoutsMap");
    // for(Map<String, Object?> workoutMap in workoutsMap){
    //   debugPrint("MAP IN FOR LOOP: $workoutMap");
    //   workoutsList.add(Workout.fromEndUpdateMap(workoutMap));
    // }
    // debugPrint("BEFORE RETURN : $workoutsList");
    // return workoutsList;
  }
}