class Exercise{
  int? exerciseId;
  late String name;
  late bool isCompound;
  //todo: add targets muscles for stats

  Exercise({this.exerciseId, required this.name, required this.isCompound});

  Exercise.fromDBMap(Map<String, Object?> map){
    //this works for exercises with id, i.e. read from DB
    exerciseId = map['id'] as int;
    name = map['name'].toString();
    isCompound = map['is_compound'] as int == 1 ? true : false;
  }

  @override
  String toString(){
    return 'Exercise{exerciseId: $exerciseId, name: $name, isCompound: $isCompound}';
  }
}