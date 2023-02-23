import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:floss_fitness_app/data/models/workout.dart';
import 'package:floss_fitness_app/const/db_constants.dart';

import '../models/set.dart';

class WorkoutDatabaseProvider{
  WorkoutDatabaseProvider._privateConstructor();
  static final WorkoutDatabaseProvider instance = WorkoutDatabaseProvider._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initWorkoutDatabase();

  Future<Database> _initWorkoutDatabase() async {
    String databaseDirectory = await getDatabasesPath();
    String databasePath = join(databaseDirectory, DbConstants.DATABASE_NAME);
    Database database = await openDatabase(
        databasePath,
        version: 1,
        onCreate: _onCreateWorkoutDatabase,
        //todo: implement onConfigure to enable foreign keys
    );

    return database;
  }

  Future _onCreateWorkoutDatabase(Database db, int version) async {
    await db.execute(DbConstants.CREATE_WORKOUT_TABLE);
    await db.execute(DbConstants.CREATE_SET_TABLE);
    await db.execute(DbConstants.CREATE_EXERCISE_TABLE);
    await db.execute(DbConstants.CREATE_WORKING_EXERCISE_TABLE);
    debugPrint("Installing dbs");
  }

  static Future<Map<String, Object?>> insertWorkoutAndReturn() async{
    Database db = await instance.database;
    await db.rawQuery(DbConstants.insertWorkoutQuery(Workout.newWorkout()));
    List<Map<String, Object?>> workouts =  await db.query(DbConstants.WORKOUT_TABLE_NAME, orderBy: 'id');
    return workouts.last;
  }

  static Future<List<Map<String, Object?>>> selectAllWorkouts() async{
    Database db = await instance.database;
    List<Map<String, Object?>> workouts = await db.query(DbConstants.WORKOUT_TABLE_NAME, orderBy: 'start_date_time', where: 'is_completed = ?', whereArgs: [1]);
    return workouts.reversed.toList();
  }

  static Future<List<Map<String, Object?>>> selectWorkingExAndJoinName(int workoutId) async{
    Database db = await instance.database;
    print(DbConstants.selectWorkingExercisesWithName(workoutId));
    List<Map<String, Object?>> wok = await db.rawQuery(DbConstants.selectWorkingExercisesWithName(workoutId));
    print('WOK: $wok');
    return wok;
  }

  static Future<List<Map<String, Object?>>> selectAllSetsForWorkingExercise(int finishedWorkingExerciseId) async {
    Database db = await instance.database;
    List<Map<String, Object?>> finishedSets = await db.query(
        DbConstants.SET_TABLE_NAME,
        orderBy: 'start_date_time',
        where: 'working_exercises_id = ?',
        whereArgs: [finishedWorkingExerciseId]
    );
    return finishedSets;
  }

  static Future<List<Map<String, Object?>>> selectAllWorkingExercisesForWorkoutId(int workoutId) async {
    Database db = await instance.database;
    List<Map<String, Object?>> finishedWorkingExercisesForWorkoutId = await db.query(
      DbConstants.WORKING_EXERCISE_TABLE_NAME,
      orderBy: 'id',
      where: 'workout_id = ?',
      whereArgs: [workoutId]
    );
    return finishedWorkingExercisesForWorkoutId;
  }

  Future<bool> checkIfWorkoutInProgress() async{
    Database db = await instance.database;
    List<Map<String, Object?>> res =  await db.query(DbConstants.WORKOUT_TABLE_NAME, where: 'is_completed = 0');
    return res.isNotEmpty;
  }

  static Future<Map<String, Object?>> insertWorkoutExerciseAndReturn(int workoutId) async {
    Database db = await instance.database;
    await db.rawQuery(DbConstants.insertNewWorkingExerciseQuery(workoutId));
    List<Map<String, Object?>> workingExercises =  await db.query(DbConstants.WORKING_EXERCISE_TABLE_NAME, orderBy: 'id');
    return workingExercises.last;
  }

  static Future<Map<String, Object?>> insertWorkoutSetAndReturn(SetW set) async {
    Database db = await instance.database;
    await db.rawQuery(DbConstants.insertNewSetQuery(set));
    List<Map<String, Object?>> workingExercises =  await db.query(DbConstants.SET_TABLE_NAME, orderBy: 'id');
    return workingExercises.last;
  }

  static Future<Map<String, Object?>> endWorkoutExerciseAndReturn(int workingExerciseId, int exerciseId) async {
    Database db = await instance.database;
    await db.rawQuery(DbConstants.endWorkingExerciseQuery(workingExerciseId, exerciseId));
    List<Map<String, Object?>> workingExercises =  await db.query(DbConstants.WORKING_EXERCISE_TABLE_NAME, where: 'id = ?', whereArgs: [workingExerciseId]);
    return workingExercises.last;
  }

  static Future<Map<String, Object?>> endWorkoutSetAndReturn(int setId, int reps, int weight) async {
    Database db = await instance.database;
    await db.rawQuery(DbConstants.endSetFromWorkingExerciseQuery(setId, reps, weight));
    List<Map<String, Object?>> endedSets =  await db.query(DbConstants.SET_TABLE_NAME, where: 'id = ?', whereArgs: [setId]);
    return endedSets.last;
  }

  static Future<Map<String, Object?>> endWorkoutAndReturn(int workoutId) async {
    Database db = await instance.database;
    await db.rawQuery(DbConstants.endWorkoutQuery(workoutId));
    List<Map<String, Object?>> endedWorkouts =  await db.query(DbConstants.WORKOUT_TABLE_NAME, where: 'id = ?', whereArgs: [workoutId]);
    return endedWorkouts.last;
  }

  static insertExercise(String exerciseName, bool isCompound) async {
    Database db = await instance.database;
    await db.rawQuery(DbConstants.insertExerciseQuery(exerciseName, isCompound));
  }

  static Future<List<Map<String, Object?>>> selectAllExercises() async {
    Database db = await instance.database;
    List<Map<String, Object?>> exerciseInDb = await db.query(
        DbConstants.EXERCISE_TABLE_NAME,
        orderBy: 'id',
    );
    return exerciseInDb;
  }
}