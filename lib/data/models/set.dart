class SetW{
  //primary keys
  late int setId;
  //foreign keys
  late int workoutId;
  late List<int> exercisesId; //can add multiple exercises, intended for super sets
  //properties
  late DateTime startTimeOfSet;
  late DateTime endTimeOfSet;
  late TypeOfSet typeOfSet = TypeOfSet.set;
  late List<int> reps;
  late List<int> weight;
  late String note;

  SetW({
    required this.setId,
    required this.workoutId,
    required this.typeOfSet
  }){ exercisesId = []; }

  SetW.regularSet(int setId, int workoutId) :
        this(setId: setId, workoutId: workoutId, typeOfSet: TypeOfSet.set);
  SetW.superSet(int setId, int workoutId) :
        this(setId: setId, workoutId: workoutId, typeOfSet: TypeOfSet.superset);
  SetW.dropSet(int setId, int workoutId) :
        this(setId: setId, workoutId: workoutId, typeOfSet: TypeOfSet.dropset);

  @override
  String toString(){
    return 'Set{setId: $setId, exercisesId: $exercisesId, startTimeOfSet: $startTimeOfSet, endTimeOfSet: $endTimeOfSet, typeOfSet: $typeOfSet '
        'reps: $reps, weight: $weight, note: $note}';
  }
}

enum TypeOfSet{
  superset,
  dropset,
  set
}