import 'package:floss_fitness_app/data/models/exercise.dart';
import 'package:floss_fitness_app/data/models/set.dart';
import 'package:floss_fitness_app/data/models/working_exercise.dart';
import 'package:flutter/cupertino.dart';

import '../data_providers/workout_database_provider.dart';
import '../models/workout.dart';

class WorkoutDatabaseRepository{
  WorkoutDatabaseRepository();

  //DB calls in BloC

  Future<WorkingExercise> addNewWorkingExercise(int workoutId) async {
    Map<String, Object?> insertedWorkingExercise = await WorkoutDatabaseProvider.insertWorkoutExerciseAndReturn(workoutId);
    return WorkingExercise.fromNewInsertMap(insertedWorkingExercise);
  }

  Future<SetW> addNewWorkingSet(SetW set) async {
    Map<String, Object?> insertedWorkingExercise = await WorkoutDatabaseProvider.insertWorkoutSetAndReturn(set);
    return SetW.fromNewInsertMap(insertedWorkingExercise);
  }

  Future<List<Exercise>> getAllExerciseFromDbAsList() async {
    List<Map<String, Object?>> exerciseInDb = await WorkoutDatabaseProvider.selectAllExercises();
    List<Exercise> exercisesList = [];
    for(Map<String, Object?> exerciseMap in exerciseInDb){
      exercisesList.add(Exercise.fromDBMap(exerciseMap));
    }
    return exercisesList;
  }

  Future<WorkingExercise> endWorkingExercise(int workingExerciseId, int exerciseId) async {
    Map<String, Object?> insertedWorkingExercise = await WorkoutDatabaseProvider.endWorkoutExerciseAndReturn(workingExerciseId, exerciseId);
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

  //DB calls outside BloC

  static Future<Workout> createAndReturnNewWorkoutInDb() async {
    Map<String, Object?> insertedWorkoutMap = await WorkoutDatabaseProvider.insertWorkoutAndReturn();
    return Workout.fromNewInsertMap(insertedWorkoutMap);
  }

  static Future<List<Map<String, Object?>>> getAllFinishedWorkouts() async {
    List<Map<String, Object?>> workoutsMap = await WorkoutDatabaseProvider.selectAllWorkouts();
    return workoutsMap;
  }

  static Future<List<Map<String, Object?>>> getAllSetsForWorkingExercise(int finishedWorkingExerciseId) async {
    List<Map<String, Object?>> setsListOfMaps = await WorkoutDatabaseProvider.selectAllSetsForWorkingExercise(finishedWorkingExerciseId);
    return setsListOfMaps;
  }

  static Future<List<Map<String, Object?>>> getAllWorkingExercisesForWorkoutId(int workoutId) async {
    List<Map<String, Object?>> workingExerciseListOfMaps = await WorkoutDatabaseProvider.selectAllWorkingExercisesForWorkoutId(workoutId);
    return workingExerciseListOfMaps;
  }

  static Future<List<Map<String, Object?>>> selectWorkingExAndJoinName(int workoutId) async {
    List<Map<String, Object?>> workingExerciseListOfMaps = await WorkoutDatabaseProvider.selectWorkingExAndJoinName(workoutId);
    return workingExerciseListOfMaps;
  }

  static void insertExercise(String exerciseName, bool isCompound) async {
    await WorkoutDatabaseProvider.insertExercise(exerciseName, isCompound);
  }

  static void updateExercise(String exerciseName, int isCompound, int exerciseId) async {
    await WorkoutDatabaseProvider.updateExercise(exerciseName, isCompound, exerciseId);
  }

  static Future<List<Map<String, Object?>>> getAllExerciseFromDBAsMaps() async {
    List<Map<String, Object?>> exerciseInDb = await WorkoutDatabaseProvider.selectAllExercises();
    return exerciseInDb;
  }

  static Future deleteWorkoutById(int workoutId) async {
    await WorkoutDatabaseProvider.deleteWorkoutById(workoutId);
  }
}