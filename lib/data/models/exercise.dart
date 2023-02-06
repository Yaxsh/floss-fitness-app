class Exercise{
  int? exerciseId;
  late String name;
  late bool isCompound;
  //todo: add targets muscles for stats

  Exercise({this.exerciseId, required this.name, required this.isCompound});

  @override
  String toString(){
    return 'Exercise{exerciseId: $exerciseId, name: $name, isCompound: $isCompound}';
  }
}