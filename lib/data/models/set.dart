class SetW{
  //primary keys
  late int setId;
  //foreign keys
  late int workingExercisesId; //can add multiple exercises, intended for super sets
  //properties
  late DateTime startTimeOfSet;
  late DateTime? endTimeOfSet;
  late TypeOfSet typeOfSet = TypeOfSet.set;
  late int reps;
  late num weight;
  late String note;

  SetW({
    required this.typeOfSet,
    required this.workingExercisesId
  }){
    startTimeOfSet = DateTime.now();
    endTimeOfSet = null;
  }

  // SetW.regularSet(int workoutId) :
  //       this(typeOfSet: TypeOfSet.set);
  // SetW.superSet(int workoutId) :
  //       this(typeOfSet: TypeOfSet.superset);
  // SetW.dropSet(int workoutId) :
  //       this(typeOfSet: TypeOfSet.dropset);
  SetW.fromNewInsertMap(Map<String, Object?> map){
    setId = map['id'] as int;
    workingExercisesId = map['working_exercises_id'] as int;
    startTimeOfSet = DateTime.parse(map['start_date_time'] as String);
    endTimeOfSet = null;
    reps = 0;
    weight = 0;
    var writtenValueTypeOfSet = map['type_of_set'] as String;
    switch(writtenValueTypeOfSet){
      case 'TypeOfSet.superSet':
        typeOfSet = TypeOfSet.superset;
        break;
      case 'TypeOfSet.dropSet':
        typeOfSet = TypeOfSet.dropset;
        break;
      default:
        typeOfSet = TypeOfSet.set;
    }
  }

  SetW.fromEndedSetMap(Map<String, Object?> map){
    setId = map['id'] as int;
    workingExercisesId = map['working_exercises_id'] as int;
    startTimeOfSet = DateTime.parse(map['start_date_time'] as String);
    endTimeOfSet = DateTime.parse(map['end_date_time'] as String);
    reps = map['reps'] as int;
    weight = map['weight'] as num;
    note = map['note'] as String;
    var writtenValueTypeOfSet = map['type_of_set'] as String;
    switch(writtenValueTypeOfSet){
      case 'TypeOfSet.superSet':
        typeOfSet = TypeOfSet.superset;
        break;
      case 'TypeOfSet.dropSet':
        typeOfSet = TypeOfSet.dropset;
        break;
      default:
        typeOfSet = TypeOfSet.set;
    }
  }


  @override
  String toString(){
    return 'Set{setId: $setId, exercisesId: $workingExercisesId, startTimeOfSet: $startTimeOfSet, endTimeOfSet: $endTimeOfSet, typeOfSet: $typeOfSet '
        'reps: $reps, weight: $weight, note: $note}';
  }
}

enum TypeOfSet{
  superset,
  dropset,
  set
}