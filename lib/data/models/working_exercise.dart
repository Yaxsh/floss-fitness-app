class WorkingExercise{
  late int id;
  late int exerciseId;
  late int workoutId;
  late int isCompleted;

  WorkingExercise({required this.id, required this.exerciseId, required this.workoutId});

  WorkingExercise.fromNewInsertMap(Map<String, Object?> map){
    id = map['id'] as int;
    exerciseId = map['exercise_id'] as int;
    workoutId = map['workout_id'] as int;
    isCompleted = map['is_completed'] as int;
  }

  WorkingExercise.fromEndedUpdateMap(Map<String, Object?> map){
    id = map['id'] as int;
    exerciseId = map['exercise_id'] as int;
    workoutId = map['workout_id'] as int;
    isCompleted = map['is_completed'] as int;
  }

  @override
  String toString(){
    return "WorkingExercise{id: $id, exerciseId: $exerciseId, workoutId: $workoutId, isCompleted: $isCompleted}";
  }
}