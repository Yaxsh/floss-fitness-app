import '../data_providers/workout_database_provider.dart';
import '../models/workout.dart';

class WorkoutDatabaseRepository{
  //todo: implement db interactions

  WorkoutDatabaseRepository();

  static Future<Workout> createAndReturnNewWorkoutInDb() async {
    Map<String, Object?> insertedWorkoutMap = await WorkoutDatabaseProvider.insertWorkoutAndReturn();
    return Workout.fromNewInsertMap(insertedWorkoutMap);
  }
}