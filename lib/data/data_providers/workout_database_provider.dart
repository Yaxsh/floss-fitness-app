import 'dart:async';

import 'package:floss_fitness_app/data/models/workout.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../const/db_constants.dart';

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
  }

  static Future<Map<String, Object?>> insertWorkoutAndReturn() async{
    Database db = await instance.database;
    Workout newWorkout = Workout.newWorkout();
    await db.rawQuery(DbConstants.insertWorkoutQuery(newWorkout));
    List<Map<String, Object?>> workouts =  await db.query(DbConstants.WORKOUT_TABLE_NAME, orderBy: 'id');
    return workouts.last;
  }

  static Future<List<Map<String, Object?>>> selectAllWorkouts() async{
    Database db = await instance.database;
    return await db.query(DbConstants.WORKOUT_TABLE_NAME, orderBy: 'start_date_time');
  }

  Future<bool> checkIfWorkoutInProgress() async{
    Database db = await instance.database;
    List<Map<String, Object?>> res =  await db.query(DbConstants.WORKOUT_TABLE_NAME, where: 'is_completed = 0');
    return res.isNotEmpty;
  }
}