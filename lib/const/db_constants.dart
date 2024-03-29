import 'package:floss_fitness_app/data/models/exercise.dart';
import 'package:floss_fitness_app/data/models/workout.dart';
import 'package:floss_fitness_app/data/models/set.dart';

class DbConstants{

  //general consts
  // static const String _multiValuesJoiner = " | ";

  //database
  static const String DATABASE_NAME = "fitnelly.db";

  //tables
  static const String WORKOUT_TABLE_NAME = "workouts";
  static const String SET_TABLE_NAME = "sets";
  static const String EXERCISE_TABLE_NAME = "exercises";
  static const String WORKING_EXERCISE_TABLE_NAME = "working_exercises";

  //(C)reate queries
  static const String CREATE_WORKOUT_TABLE = '''CREATE TABLE $WORKOUT_TABLE_NAME(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        start_date_time TEXT,
        end_date_time TEXT,
        is_completed INTEGER NOT NULL,
        is_deleted INTEGER
  ) ''';

  static const String CREATE_SET_TABLE = '''CREATE TABLE $SET_TABLE_NAME(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        working_exercises_id INTEGER,
        type_of_set TEXT,
        start_date_time TEXT,
        end_date_time TEXT,
        reps INTEGER,
        weight INTEGER,
        note TEXT
  ) ''';

  static const String CREATE_EXERCISE_TABLE = '''CREATE TABLE $EXERCISE_TABLE_NAME(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        is_compound INTEGER
  ) ''';

  static const String CREATE_WORKING_EXERCISE_TABLE = '''CREATE TABLE $WORKING_EXERCISE_TABLE_NAME(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workout_id INTEGER,
        exercise_id INTEGER,
        is_completed INTEGER
  ) ''';

  //Update queries for V2 DB
  static const String UPDATE_WORKOUT_TABLE_V2 = '''ALTER TABLE $WORKOUT_TABLE_NAME
        ADD is_deleted INTEGER
  ''';

  static const String UPDATE_EXISTING_WORKOUT_V2 = '''UPDATE $WORKOUT_TABLE_NAME
        SET is_deleted = 0
  ''';

  //todo: investigate whether it is necessary
  static const String UPDATE_EXERCISE_TABLE_V2 = '''ALTER TABLE $SET_TABLE_NAME
        MODIFY COLUMN weight REAL
  ''';

  //(C)insert queries
  static String insertWorkoutQuery(Workout workout){
    String startTime = workout.startDateTime.toString();
    String endTime = workout.endDateTime == null ? "/" : workout.endDateTime.toString();
    int isCompleted = workout.isCompleted;
    int isDeleted = workout.isDeleted;
    return '''INSERT INTO $WORKOUT_TABLE_NAME(start_date_time, end_date_time, is_deleted, is_completed)
              VALUES('$startTime', '$endTime', $isDeleted, $isCompleted)''';
  }

  static String insertSetQuery(SetW set){
    int workingExercisesId = set.workingExercisesId;
    String startTime = set.startTimeOfSet.toString();
    String endTime = set.endTimeOfSet.toString();
    String typeOfSet = set.typeOfSet.toString();
    String reps = set.reps.toString();
    String weight = set.weight.toString();
    String note = set.note;
    return '''INSERT INTO $SET_TABLE_NAME(working_exercises_id, start_date_time, end_date_time, type_of_set, reps, weight, note)
              VALUES($workingExercisesId, $startTime, $endTime, $typeOfSet, $reps, $weight, $note)''';
  }

  static String insertNewSetQuery(SetW set){
    int workingExercisesId = set.workingExercisesId;
    String startTime = set.startTimeOfSet.toString();
    String typeOfSet = set.typeOfSet.toString();
    return '''INSERT INTO $SET_TABLE_NAME(working_exercises_id, start_date_time, type_of_set)
              VALUES($workingExercisesId, '$startTime', '$typeOfSet')''';
  }

  static String insertExerciseQuery(String name, bool isCompound){
    return '''INSERT INTO $EXERCISE_TABLE_NAME(name, is_compound)
              VALUES('$name', $isCompound)''';
  }

  static String updateExerciseQuery(String name, int isCompound, int exerciseId){
    return '''UPDATE $EXERCISE_TABLE_NAME
              SET name = '$name', is_compound = $isCompound
              WHERE id = $exerciseId''';
  }

  static String insertNewWorkingExerciseQuery(int workoutId){
    return '''INSERT INTO $WORKING_EXERCISE_TABLE_NAME(exercise_id, is_completed, workout_id) 
              VALUES(-1, 0, $workoutId)''';
  }

  static String endWorkingExerciseQuery(int workingExerciseId, int exerciseId){
    //todo: update exercise_id from $EXERCISE_TABLE_NAME
    return '''UPDATE $WORKING_EXERCISE_TABLE_NAME
              SET is_completed = 1, exercise_id = $exerciseId
              WHERE id = $workingExerciseId''';
  }

  static String endSetFromWorkingExerciseQuery(int setId, int reps, num weight){
    //todo: add note and exercise id
    DateTime temp = DateTime.now();
    return '''UPDATE $SET_TABLE_NAME
              SET reps = $reps, weight = $weight, end_date_time = '${temp.toString()}', note = 'no note todo'
              WHERE id = $setId''';
  }

  static String endWorkoutQuery(int workoutId) {
    DateTime temp = DateTime.now();
    return '''UPDATE $WORKOUT_TABLE_NAME
              SET end_date_time = '${temp.toString()}', is_completed = 1
              WHERE id = $workoutId''';
  }

  static String deleteWorkoutQuery(int workoutId){
    return '''UPDATE $WORKOUT_TABLE_NAME
              SET is_deleted = 1
              WHERE id = $workoutId''';
  }

  static String selectWorkingExercisesWithName(int workoutId){
    return '''SELECT $WORKING_EXERCISE_TABLE_NAME.id, $WORKING_EXERCISE_TABLE_NAME.is_completed, $WORKING_EXERCISE_TABLE_NAME.exercise_id, $WORKING_EXERCISE_TABLE_NAME.workout_id, $EXERCISE_TABLE_NAME.name
              FROM $WORKING_EXERCISE_TABLE_NAME
              INNER JOIN $EXERCISE_TABLE_NAME ON $WORKING_EXERCISE_TABLE_NAME.exercise_id=$EXERCISE_TABLE_NAME.id
              WHERE $WORKING_EXERCISE_TABLE_NAME.workout_id=$workoutId''';
  }
}