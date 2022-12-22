import 'package:floss_fitness_app/data/models/exercise.dart';
import 'package:floss_fitness_app/data/models/workout.dart';
import 'package:floss_fitness_app/data/models/set.dart';

class DbConstants{

  //general consts
  static const String _multiValuesJoiner = " | ";

  //database
  static const String DATABASE_NAME = "fitnelly.db";

  //tables
  static const String WORKOUT_TABLE_NAME = "workouts";
  static const String SET_TABLE_NAME = "sets";
  static const String EXERCISE_TABLE_NAME = "exercises";

  //(C)reate queries
  static const String CREATE_WORKOUT_TABLE = '''CREATE TABLE $WORKOUT_TABLE_NAME(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        start_date_time TEXT,
        end_date_time TEXT,
        is_completed INTEGER NOT NULL
  ) ''';
  static const String CREATE_SET_TABLE = '''CREATE TABLE $SET_TABLE_NAME(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workout_id INTEGER,
        exercises_id TEXT,
        start_date_time TEXT,
        end_date_time TEXT,
        type_of_set TEXT,
        reps TEXT,
        weight TEXT,
        note TEXT
  ) ''';
  static const String CREATE_EXERCISE_TABLE = '''CREATE TABLE $EXERCISE_TABLE_NAME(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        is_compound INTEGER
  ) ''';

  //(C)insert queries
  static String insertWorkoutQuery(Workout workout){
    String startTime = workout.startDateTime.toString();
    String endTime = workout.endDateTime.toString();
    int isCompleted = workout.isCompleted ? 1 : 0;
    return '''INSERT INTO $WORKOUT_TABLE_NAME(start_date, end_date, is_completed)
              VALUES($startTime, $endTime, $isCompleted)''';
  }

  static String insertSetQuery(SetW set){
    int workoutId = set.workoutId;
    String exerciseId = set.exercisesId.join(_multiValuesJoiner);
    String startTime = set.startTimeOfSet.toString();
    String endTime = set.endTimeOfSet.toString();
    String typeOfSet = set.typeOfSet.toString();
    String reps = set.reps.join(_multiValuesJoiner);
    String weight = set.weight.join(_multiValuesJoiner);
    String note = set.note;
    return '''INSERT INTO $SET_TABLE_NAME(workout_id, exercises_id, start_date_time, end_date_time, type_of_set, reps, weight, note)
              VALUES($workoutId, $exerciseId, $startTime, $endTime, $typeOfSet, $reps, $weight, $note)''';
  }

  static String insertExerciseQuery(Exercise exercise){
    String name = exercise.name;
    int isCompound = exercise.isCompound ? 1 : 0;
    return '''INSERT INTO $EXERCISE_TABLE_NAME(name, is_compound)
              VALUES($name, $isCompound)''';
  }
}