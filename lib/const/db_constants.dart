class DbConstants{

  //database
  static const String DATABASE_NAME = "fitnelly.db";

  //tables
  static const String WORKOUT_TABLE_NAME = "workouts";
  static const String SET_TABLE_NAME = "sets";
  static const String EXERCISE_TABLE_NAME = "exercises";

  //queries
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
        note TEXT
  ) ''';
  static const String CREATE_EXERCISE_TABLE = '''CREATE TABLE $EXERCISE_TABLE_NAME(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        is_compound INTEGER
  ) ''';
}