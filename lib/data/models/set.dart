class Set{
  //primary keys
  late int setId;
  //foreign keys
  late int workoutId;
  late List<int> exercisesId; //can add multiple exercises, intended for super sets
  //properties
  late DateTime startTimeOfSet;
  late DateTime endTimeOfSet;
  late TypeOfSet typeOfSet = TypeOfSet.set;

  Set({
    required this.setId,
    required this.workoutId,
    required this.typeOfSet
  }){ this.exercisesId = []; }

  Set.regularSet(int setId, int workoutId) : this(setId: setId, workoutId: workoutId, typeOfSet: TypeOfSet.set);
  Set.superSet(int setId, int workoutId) : this(setId: setId, workoutId: workoutId, typeOfSet: TypeOfSet.superset);
  Set.dropSet(int setId, int workoutId) : this(setId: setId, workoutId: workoutId, typeOfSet: TypeOfSet.dropset);
}

enum TypeOfSet{
  superset,
  dropset,
  set
}