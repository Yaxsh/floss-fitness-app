import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../const/db_constants.dart';

class WorkoutDatabase{
  WorkoutDatabase._privateConstructor();
  static final WorkoutDatabase instance = WorkoutDatabase._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initWorkoutDatabase();

  Future<Database> _initWorkoutDatabase() async {
    String databaseDirectory = await getDatabasesPath();
    String databasePath = join(databaseDirectory, DbConstants.DATABASE_NAME);
    print('DATABASE PATH: $databasePath');
    Database database = await openDatabase(
        databasePath,
        version: 1,
        onCreate: _onCreateWorkoutDatabase,
        //todo: implement onConfigure to enable foreign keys
    );

    return database;
  }

  Future _onCreateWorkoutDatabase(Database db, int version) async{
    await db.execute('''CREATE TABLE test_table(
          id INTEGER PRIMARY KEY,
          tst TEXT
    )''');
  }

  Future<List<Map<String, Object?>>> getTestQuery() async {
    Database db = await instance.database;
    return await db.query('test_table', orderBy: 'tst');
  }

  Future<void> insertTestQuery() async {
    Database db = await instance.database;
    String tst2 = '1t1t1t1';
    print('INSERTED');
    return await db.execute('INSERT INTO test_table(tst) VALUES (\'$tst2\');');
  }
}