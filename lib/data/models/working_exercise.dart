class WorkingExercise{
  late int id;
  late int exerciseId;

  WorkingExercise({required this.id, required this.exerciseId});

  WorkingExercise.fromNewInsertMap(Map<String, Object?> map){
    id = map['id'] as int;
    exerciseId = map['exercise_id'] as int;
  }

  @override
  String toString(){
    return "WorkingExercise{id: $id, exerciseId: $exerciseId}";
  }
}